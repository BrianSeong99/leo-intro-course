# 5 Deployment

## Create Deployment Scripts
Create a bash script named `deploy.sh` outside of the token project directory and copy the following into the file

```bash
PROGRAM_ID="<Your Token Project Name>"

snarkos developer deploy \
--private-key <PRIVATEKEY> \
--query https://api.explorer.aleo.org/v1 \
--priority-fee 0 \
"${PROGRAM_ID}.aleo" \
--path ./build/ \
--broadcast https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast
```

## [screenshot required] Request for faucets

Follow [this](https://www.leo.app/blog/aleo-faucet) guide from Leo Wallet.

**Definitely Recommend install [Leo wallet](https://www.leo.app/) if you want to try out Aleo ecosystem!**

## [screenshot required] Deploy

Once you get your token for your account, Run the deploy script:

```bash
bash ./deploy.sh
```

## Test Mint and Transfer Function onchain

Mint Token
```bash
snarkos developer execute \
--broadcast https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast \
--private-key <PRIVATEKEY> \
--query https://api.explorer.aleo.org/v1 \
"${PROGRAM_ID}.aleo" mint 100u32
```

Transfer Token
```bash
snarkos developer execute \
--broadcast https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast \
--private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe \
--query https://api.explorer.aleo.org/v1 \
"${PROGRAM_ID}.aleo" transfer <recipient_address> 20u32 <token_record>
```
