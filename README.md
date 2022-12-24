# Hacking Ethernaut

Ethernaut is a game created by Open Zeppelin to practice hacking solidity smart contracts

## Repository Setup

- Contracts
  - Ethernaut: Contracts created by Open Zeppelin that have various vulernabilities within contract.
  - Solutions: Smart contracts created by me to exploit the vulernabilities within corresponding Ethernaut contracts.
- test: Test cases to test if exploits works

### Languages and Frameworks used

- Solidity
- Typescript
- Hardhat
- EthersJS

## Levels

### Level 3: Coin Flip

Problem: The base smart contract tracks the number of consecutive wins a user has when guessing a coin flip. The goal in this level is to predict the outcome 10 times in a row.

Vulnerability overview: The vulnerability is found within the randomness of the coinflip. It is truly not random because it does not use VRF Random Functions and instead uses the block number as the main element to calculate the result of the coin flip. Using this it is easy to always predict the correct answer.
