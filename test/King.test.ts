import { expect } from "chai";
import { Contract, providers } from "Ethers";
import { describe, it } from "mocha";
import { ethers } from "hardhat";

describe("King", async () => {
    let kingContract: Contract, exploitKingContract: Contract;

    beforeEach('Setup', async () => {
        const contractFactory = await ethers.getContractFactory("King");
        kingContract = await contractFactory.deploy();

        const exploitFactory = await ethers.getContractFactory("HackKing");
        exploitKingContract = await exploitFactory.deploy(kingContract.address);
    });

    it('Attack contract', async () => {
        const transactionReceipt = await exploitKingContract.becomeKing({ value: await kingContract.prize() + 1 });
        await transactionReceipt.wait(1);
        expect(await kingContract.king()).to.equal(exploitKingContract.address);
    });

});