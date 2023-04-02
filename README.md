# Hacking Ethernaut

Ethernaut is a game created by Open Zeppelin to practice hacking solidity smart contracts

## Repository Setup

- Contracts
  - Ethernaut: Contracts created by Open Zeppelin that have various vulernabilities within contract.
  - Solutions: Smart contracts created by me to exploit the vulernabilities within corresponding Ethernaut contracts.
- scripts: Scripts that when ran attack the Ethernaut level.
- test: Test cases to test if exploits works.

### Languages and Frameworks used

- Solidity
- Typescript
- Hardhat
- EthersJS

### How to

1. Create a .env file and add your RPC API Key, account private key, and the instance of the contract you are trying to hack. Example:

   ```
   GOERLI_ALCHEMY_API_URL=<Your API Key>
   GOERLI_PRIVATE_KEY=<Your Private Key>
   CONTRACT_INSTANCE_ADDRESS=<Contract Address>
   ```

2. Compile Contracts: `yarn hardhat compile`
3. Test Exploits: `yarn hardhat test`
4. Attack a level:

   ```
   yarn hardhat run <path to script> --network goerli
   ```

## Levels

### Level 3: Coin Flip \*Current Issue in Script

Problem: The base smart contract tracks the number of consecutive wins a user has when guessing a coin flip. The goal in this level is to predict the outcome 10 times in a row.

Vulnerability overview: The vulnerability is found within the randomness of the coinflip. It is truly not random because it does not use VRF Random Functions and instead uses the block number as the main element to calculate the result of the coin flip. Using this it is easy to always predict the correct answer.

### Level 4: Telephone

Problem: Gain ownership of the contract.

Vulnerability: Making sure tx.origin is not the sender is the only guard against changing ownership. This can easily be bypassed by creating a smart contract that calls the change owner function therfore making tx.orgin != msg.sender true and changing contract ownership.

### Level 5: Token

Problem: You are given 20 tokens to start. Try to gain access to as many tokens as possible

Vulnerability: Due to the token contract having no protection for integer overflow or underflow, if a user transfers a value 1 greater than their balance they will be able to increase their token balance to ` 2^256-1`. The _to parameter must be any address not equal to msg.sender.

```
// Typescript example
const amount: number = await contract.getBalance(player) + 1;
await contract.transfer('0x0000000000000000000000000000000000000000', amount);
```

### Level 6: Delegation

Problem: Gain ownership of the `Delegation` contract

Vulnerability: A `delegatecall` in solidity is a function that allows users to call a contract function in the context of the contract making the call. The `Delegation` contract has a `fallback` function that `delegatecalls` the `Delegate` contract with `msg.data` passed. Because of the open ended data being sent to the `Delegate` contract when the `fallback` function is triggered the hacker can call any function that exists within the `Delegate` contract. Within the `Delegate` contract the `pwn` function sets the owner to msg.sender. Since we are trying to take ownership of the `Delegation` contract we can all this `pwn` function within the context of the `Delegation` contract using the bug in the `fallback` function of allowing any data to be passsed. In order to call the `pwn` function we need to get its `Method ID`. To do this use the `keccak256` hash function to encode the input `"pwn()"` and then use the 4 for bytes of the output.

An example of how we do this with a simple call is below.

```
// Typescript example
// Method ID = 0xdd365b8b
await contract.sendTransaction({data: "0xdd365b8b"});
```
