# Hacking Ethernaut

Ethernaut is a game created by Open Zeppelin to practice hacking solidity smart contracts

## Repository Setup

- Contracts
  - Ethernaut: Contracts created by Open Zeppelin that have various vulernabilities within contract.
  - Solutions: Smart contracts created by me to exploit the vulernabilities within corresponding Ethernaut contracts.
- scripts: Scripts that when ran attack the Ethernaut level.
- test: Test cases to test if exploits works.
- lib: Github submodules used for Foundry
- foundry.toml: Config file which set up the Foundry developmeent environment as well as dependency remappings.

### Languages and Frameworks used

- Solidity
- Typescript
- Hardhat
- EthersJS
- Foundry

### How to

1. Create a .env file and add your RPC API Key, account private key, and the instance of the contract you are trying to hack. Example:

   ```
   SEPOLIA_RPC_URL=<Your API Key>
   ACCOUNT_PRIVATE_KEY=<Your Private Key>
   CONTRACT_INSTANCE_ADDRESS=<Contract Address>
   ```

2. Compile Contracts: `yarn hardhat compile`
3. Test Exploits: `yarn hardhat test`
4. Attack a level:

   ```bash
   // Scripts using hardhat
   yarn hardhat run <path to script> --network goerli

   // Scripts using foundry
   // step 1: import .env variables
   source .env
   // step 2: Run the script
   forge script <path to script>:<script contract name> --rpc-url $<name of url .env variable> --broadcast -vvvv
   ```

## Levels

### Level 0: Hello Ethernaut

This level teaches you the basics of playing the game, mainly how to interact with the game via the browser's console.

Important info: 
    - ```player``` returns the users address being used for a given level
    - ```await getBalance(address)``` returns the resolved promise of the balance of a given address
    - ```ethernaut``` returns a TruffleContract object that can be used to interact with the levels contract
    - ```contract``` allows a user to view the abi of the contract

Problem: View the contracts info and find the necessary info to complete the level.

Solution: When viewing the levels info ethernaut returns `You will find what you need in info1()`. When calling `info1` the attacker
    is told to call `info2` and pass "hello". The return value tells to user to go to the infoNum property to find the next method to call.
    When calling `infoNum` we get an array with the number 42 as only value in the array. There is an available method that matches this,
    `info42`. Once called it returns `theMethodName is the name of the next method`. This leads us to another method to call, `method7123949`.
    This tells us to solve the level we must submit the password to the `authenticate` function. When viewing the contract we see there
    is a public variable called `password`. The return value of this is `ethernaut0`. Passing this into `authenticate` will
    solve the level.

### Level 1: 

Problem: Gain ownership of the contract and reduce its balance to 0.

Vulnerability: There is a receive fallback function which sets the owner to msg.sender if the sender send a value greater than
    1 wei to the contract and has previously contributed to the contract. This exploit can be completed 100% within the 
    console. First the user must contribute some ether < .001 to the contract then they must send ether to the contracts address
    to trigger the fallback function. Once this occurs the attacker can call the `withdraw` function to steal the funds.

```js
// Contribute to the contract
await contract.contribute({'value': toWei('0.00000000001')});

// Send ether to the contract to gain ownership
await contract.sendTransaction({value: 1});

// Withdraw the contracts balance
await contract.withdraw();
```

### Level 2:

Problem: Gain ownership of the contract

Vulnerability: The contracts constructor has a typo in it and is `Fal1out` instead of `Fallout` this allows any user to call it instead of
    it being called upon contract deployment. In order to gain ownership all a user has to do is call `await contract.Fal1out();`.

### Level 3: Coin Flip

Problem: The base smart contract tracks the number of consecutive wins a user has when guessing a coin flip. The goal in this level is to predict the outcome 10 times in a row.

Vulnerability overview: The vulnerability is found within the randomness of the coinflip. It is truly not random because it does not use VRF Random Functions and instead uses the block number as the main element to calculate the result of the coin flip. Using this it is easy to always predict the correct answer.

### Level 4: Telephone

Problem: Gain ownership of the contract.

Vulnerability: Making sure tx.origin is not the sender is the only guard against changing ownership. This can easily be bypassed by creating a smart contract that calls the change owner function therefore making tx.orgin != msg.sender true and changing contract ownership.

### Level 5: Token

Problem: You are given 20 tokens to start. Try to gain access to as many tokens as possible

Vulnerability: Due to the token contract having no protection for integer overflow or underflow, if a user transfers a value 1 greater than their balance they will be able to increase their token balance to ` 2^256-1`. The _to parameter must be any address not equal to msg.sender.

```js
const amount: number = await contract.getBalance(player) + 1;
await contract.transfer('0x0000000000000000000000000000000000000000', amount);
```

### Level 6: Delegation

Problem: Gain ownership of the `Delegation` contract

Vulnerability: A `delegatecall` in solidity is a function that allows users to call a contract function in the context of the contract making the call. The `Delegation` contract has a `fallback` function that `delegatecalls` the `Delegate` contract with `msg.data` passed. Because of the open ended data being sent to the `Delegate` contract when the `fallback` function is triggered the hacker can call any function that exists within the `Delegate` contract. Within the `Delegate` contract the `pwn` function sets the owner to msg.sender. Since we are trying to take ownership of the `Delegation` contract we can all this `pwn` function within the context of the `Delegation` contract using the bug in the `fallback` function of allowing any data to be passsed. In order to call the `pwn` function we need to get its `Method ID`. To do this use the `keccak256` hash function to encode the input `"pwn()"` and then use the 4 for bytes of the output.

An example of how we do this with a simple call is below.

```js
// Method ID = 0xdd365b8b
await contract.sendTransaction({data: "0xdd365b8b"});
```

### Level 7: Force

Problem: Make the contracts balance greater than 0.

Vulnerability: The contract has no code in it, so there is no fallback methods to accept Ether. Because of this both `send` and `transfer` will both revert. In order to be able to send ETH to the contract you can create a exploit 
    contract, donate ETH to said contract, and utilize the self-destruct feature to send all the Ether from the exploit contract to the `Force` contract. 
    

### Level 8: Vault

Problem: Unlock the vault

Vulnerability: The only protection against users trying to `unlock` the vault is checking if the password matches the `bytes32 private password` variable. Even though `password` is private everything on the blockchain is public and can be seen. Using `getStorageAt` from `web3.eth` private variables can be accessed. Below is an example of how to unlock the vault.

```js
// Get the password.
// Position 1 in storage slot due to being the second slot
const password = await web3.eth.getStorageAt(contract.address, 1);
await contract.unlock(password);
```

### Level 9: King

Problem: In a game where whoever sends the most Eth to the contract becomes the king and the overthrown king gets paid a prize. Break the game so that when the level reclaims kingship you can avoid being overthrown.

Vulnerability: Because this game involves sending Eth to the previous kings address using `transfer` it assumes the king will either be an `EOA` or a contract containing a `receive` or `fallback` function. This flawed logic allows us to break the game by creating a smart contract with no `receive` or `fallback` function. Once this contract is king it will never be dethrowned due to the `King` contracts `receive` function reverting whenever Eth is transfered to the expoit contract.


### Level 10: Reentrancy

Problem: Steal all the funds from the contract

Vulnerability: In the `withdraw` function the balances are updated after Eth is sent to `msg.sender` because of this an attacker can utilize a fallback function to reenter the withdraw contracts before balances are updated thus drain the entire contract.


### Level 11: Elevator

Problem: Reach the top floor of the building

Vulnerability: Because the `isLastFloor` from the `Building` interface contains a function with just and external type it allows a hacker to create a contract that uses the function to change state. This is problematic because a user can create a smart contract that calls manipulates state variables to get the `Elevator` contract to sent the elevator to the top floor, which its not suppose to do. In this repo, the `HackElevator` contract is a `Building` which has a `isLastFloor` function that behaves in different manner depending on how many times it has been called and what floor is being called. This can be used to reach the top floor of the building.

### Level 12: Privacy 

Problem: Unlock the contract

Vulnerability: Just like in Level 8 the vulnerability lies in the fact that the key to `unlock` the contract is a private state variable. Because of the different size of the data types that make up the state variables, finding the storage slot isnt as easy as just counting the order of the variables. Instead we must map them out ourself. Once we do that we see that `data[2]` fills up the entire storage slot at index 5. Once we get all the data from storage slot 5 we then need to slice the first 16 bytes of the data due to `_key = bytes16(data[2])`. Once we have this we simply pass the result into the `unlock` function to solve the level.

```js
const data2 = await web3.eth.getStorageAt(contract.address, 5);
const key = data2.slice(0,34);
await contract.unlock(key);
```

Level 13: GatekeeperOne

Problem: Get through all the gates and set the `entrant` state variable to your EOA.

Vulnerability: This contract relies on three modifiers to safe guard the enter function. Each of these functions can be manipulated in a way to easily bypass the require statements. The first gate checks if `tx.orign != msg.sender`. This can be passed by creating a smart contract to act like a middle man between calls. The next gate can be passed easily by calculating how much gas is spent on the first gate check and then adding that to a multiple of `8191` to use for the amount of gas you send along with the `enter` call. The final gate allows anyone to pass through due to key relying on the `tx.origin`. By using bit masking and the & bitwise operator a hacker can easily manipulate their address into a valid key. 

*** Important ***
The current testing configuration uses the standard compile settings in Foundry. If you want to run the script to execute an attack on chain please check the `HackGatekeeperOne` contract. If the compiler settings for your contract are `v0.8.12+commit.f00d7308` with `1000` optimization runs, add this within the `foundry.toml`.

```
optimizer_runs = 1000
solc_version = '0.8.12'
```

