# 6 Token standard for public and private usage

In previous units, we have covered a simple token standard that supports mint and transfer function for private usage. But what if you want to do public transfers and make your balance of a token public?

Here we will introduce a more comprehensive token design example that supports both public actions, private actions, and action that converts balances from public to private, and vice versa.

## Define the public mint and transfer functions

### Step one: Define an onchain token balance tracking variable, where the key is the user's address and value is the user's token balance.

```leo
mapping account: address => u64;
```

### Step two: define your public mint function

```leo
// The function `mint_public` issues the specified token amount for the token receiver publicly on the network.
transition mint_public(public receiver: address, public amount: u64) {
    // Mint the tokens publicly by invoking the computation on-chain.
    return then finalize(receiver, amount);
}

finalize mint_public(public receiver: address, public amount: u64) {
    // Increments `account[receiver]` by `amount`.
    // If `account[receiver]` does not exist, it will be created.
    // If `account[receiver] + amount` overflows, `mint_public` is reverted.
    let receiver_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
    Mapping::set(account, receiver, receiver_amount + amount);
}
```

### Step three: define your public transfer function

```leo
transition transfer_public(public receiver: address, public amount: u64) {
    // Transfer the tokens publicly, by invoking the computation on-chain.
    return then finalize(self.caller, receiver, amount);
}

finalize transfer_public(public sender: address, public receiver: address, public amount: u64) {
    // Decrements `account[sender]` by `amount`.
    // If `account[sender]` does not exist, it will be created.
    // If `account[sender] - amount` underflows, `transfer_public` is reverted.
    let sender_amount: u64 = Mapping::get_or_use(account, sender, 0u64);
    Mapping::set(account, sender, sender_amount - amount);
    
    // Increments `account[receiver]` by `amount`.
    // If `account[receiver]` does not exist, it will be created.
    // If `account[receiver] + amount` overflows, `transfer_public` is reverted.
    let receiver_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
    Mapping::set(account, receiver, receiver_amount + amount);
}
```

## Rename the functions from chap.4 with "private" keywords

```leo
// The function `mint_private` initializes a new record with the specified amount of tokens for the receiver.
transition mint_private(receiver: address, amount: u64) -> token {
    return token {
        owner: receiver,
        amount: amount,
    };
}

// The function `transfer_private` sends the specified token amount to the token receiver from the specified token record.
transition transfer_private(sender: token, receiver: address, amount: u64) -> (token, token) {
    // Checks the given token record has sufficient balance.
    // This `sub` operation is safe, and the proof will fail if an overflow occurs.
    // `difference` holds the change amount to be returned to sender.
    let difference: u64 = sender.amount - amount;

    // Produce a token record with the change amount for the sender.
    let remaining: token = token {
        owner: sender.owner,
        amount: difference,
    };

    // Produce a token record for the specified receiver.
    let transferred: token = token {
        owner: receiver,
        amount: amount,
    };

    // Output the sender's change record and the receiver's record.
    return (remaining, transferred);
}
```

## Define conversion function that converts from public to private and vice versa

### Step one: public to private function

// The function `transfer_public_to_private` turns a specified token amount from `account` into a token record for the specified receiver.
    // This function preserves privacy for the receiver's record, however it publicly reveals the caller and the specified token amount.
    transition transfer_public_to_private(public receiver: address, public amount: u64) -> token {
        // Produces a token record for the token receiver.
        let transferred: token = token {
            owner: receiver,
            amount: amount,
        };

        // Output the receiver's record.
        // Decrement the token amount of the caller publicly.
        return transferred then finalize(self.caller, amount);
    }

    finalize transfer_public_to_private(public sender: address, public amount: u64) {
        // Decrements `account[sender]` by `amount`.
        // If `account[sender]` does not exist, it will be created.
        // If `account[sender] - amount` underflows, `transfer_public_to_private` is reverted.
        let sender_amount: u64 = Mapping::get_or_use(account, sender, 0u64);
        Mapping::set(account, sender, sender_amount - amount);
    }

### Step two: private to public function

// The function `transfer_private_to_public` turns a specified token amount from a token record into public tokens for the specified receiver.
// This function preserves privacy for the sender's record, however it publicly reveals the token receiver and the token amount.
transition transfer_private_to_public(sender: token, public receiver: address, public amount: u64) -> token {
    // Checks the given token record has a sufficient token amount.
    // This `sub` operation is safe, and the proof will fail if an underflow occurs.
    // `difference` holds the change amount for the caller.
    let difference: u64 = sender.amount - amount;

    // Produces a token record with the change amount for the caller.
    let remaining: token = token {
        owner: sender.owner,
        amount: difference,
    };

    // Output the sender's change record.
    // Increment the token amount publicly for the token receiver.
    return remaining then finalize(receiver, amount);
}

finalize transfer_private_to_public(public receiver: address, public amount: u64) {
    // Increments `account[receiver]` by `amount`.
    // If `account[receiver]` does not exist, it will be created.
    // If `account[receiver] + amount` overflows, `transfer_private_to_public` is reverted.
    let receiver_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
    Mapping::set(account, receiver, receiver_amount + amount);
}

## Test && Deploy

### Test all functions

### Deploy on Testnet