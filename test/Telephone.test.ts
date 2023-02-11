import { expect } from "chai";
import { Contract, providers } from "Ethers";
import { describe, it } from "mocha";
import { ethers } from "hardhat";
import * as dotenv from 'dotenv';
import { time } from "@nomicfoundation/hardhat-network-helpers";

dotenv.config();

describe("Telephone", async () => {
    let telephoneContract: Contract, exploitTelephoneContract: Contract;
    let signerAddress: string;

    beforeEach('Setup', async () => {
        const contractFactory = await ethers.getContractFactory("Telephone");
        telephoneContract = await contractFactory.deploy();const signer = await ethers.provider.getSigner();
        signerAddress = await signer.getAddress();
        console.log(`Signer Address: ${signerAddress}`);
    });

    it("Change ownership of telephone contract", async () => {
        // Deploy the hack coin flip contract with a guess goal of 10
        const exploitFactory = await ethers.getContractFactory("HackTelephone");
        exploitTelephoneContract = await exploitFactory.deploy(telephoneContract.address, signerAddress);

        await exploitTelephoneContract.attack();
        
        expect(await telephoneContract.owner()).to.equal(signerAddress);
    });

});

