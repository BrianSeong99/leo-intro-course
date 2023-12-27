# 4 Create and Test Your Token


Here we will create a token program of our own.

## [screenshot required] Create a token contract

For this demo, our desired features are following:

- Mint Function: Able to mint user specific `amount` of `token` to the one who called the mint function.
- Transfer Function: Able to transfer other user (`recipient`) specific `amount` of the `token` that was minted using mint function.

### Step one: define your token record

Define a token struct with an owner and balance

```leo
record Token {
    owner: address,
    balance: u32,
}
```

### Step two: define mint function
Define a mint transition that takes a balance and returns a token record.

```leo
transition mint(amount: u32) -> Token {
    return Token {
        owner: self.caller,
        balance: amount,
    };
}
```

### Step three: define transfer function
Define a transfer transition that takes a receiver, amount and token and returns two tokens records

```leo
transition transfer(receiver: address, transfer_amount: u32, input: Token) -> (Token, Token) {
    let sender_balance: u32 = input.balance - transfer_amount;
    let recipient: Token = Token {
        owner: receiver,
        balance: transfer_amount,
    };

    let sender: Token  = Token {
        owner: self.caller,
        balance: sender_balance
    };

    return (recipient, sender);
}
```

## Test Program

### Define input for testing
In the ./inputs/project_name.in file, we need to define the inputs for our program. For this demo we will be using the following inputs:

```
// The program input for deploy_workshop/src/main.leo
[mint]
balance: u32 = 100u32;

[transfer]
receiver: address = <recipient address>;
amount: u32 = 10u32;
input: Token = Token {
  owner: <aleo...>,
  balance: 100u32,
  _nonce: <just paste the one from terminal>
};
```

Remember to replace:
- recipient address field to actual address of the recipient.
- input token record should be the one that is returned after you minted. 
- the record logged on terminal usually has ".private", ".public" keywords after all properties of the record. Those are just indicators to show whether certain properties of the record is public or private.

### [screenshot required] Test Mint function

Run `leo run mint` to test the mint function, you can also specify the amount of token you want to mint in cmd, `leo run mint 1000u32`. If you don't include the parameter, then leo cli will go to input file to fetch inputs.

### [screenshot required] Test Transfer function

Run `leo run transfer` to test the transfer function.