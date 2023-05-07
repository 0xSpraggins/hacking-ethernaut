import { expect } from "chai";
import { Contract, providers } from "Ethers";
import { describe, it } from "mocha";
import { ethers } from "hardhat";

describe("Force", async () => {
    let forceContract: Contract, exploitForceContract: Contract;

    beforeEach('Setup', async () => {
        const contractFactory = await ethers.getContractFactory("Force");
        forceContract = await contractFactory.deploy();

        const exploitFactory = await ethers.getContractFactory("HackForce");
        exploitForceContract = await exploitFactory.deploy(forceContract.address);
    });

    it('Attack contract', async () => {
        await exploitForceContract.donate({ value: 1 });
        await exploitForceContract.attack();
        expect(await forceContract.provider.getBalance(forceContract.address)).to.be.greaterThan(0);
    });

});