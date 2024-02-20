// The 'token_private' program.
program token_private.aleo {
    
    record Token {
        // The token owner, any record must be defined with the `owner` field.
        owner: address,
        // Token balance of the user.
        balance: u32,
    }

    transition mint(amount: u32) -> Token {
        return Token {
            owner: self.caller,
            balance: amount,
        };
    }

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
}
