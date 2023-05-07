import { expect } from "chai";
import { Contract, providers } from "Ethers";
import { describe, it } from "mocha";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { ethers } from "hardhat";
import { time } from "@nomicfoundation/hardhat-network-helpers";

describe("Coin Flip", async () => {
    let coinFlipContract: Contract, exploitFlipContract: Contract;
    let numOfGuesses: number;

    beforeEach('Setup', async () => {
        const contractFactory = await ethers.getContractFactory("CoinFlip");
        coinFlipContract = await contractFactory.deploy();
    });

    it("Attack Contract with 10 guesses", async () => {
        numOfGuesses = 10;
        // Deploy the hack coin flip contract with a guess goal of 10
        const exploitFactory = await ethers.getContractFactory("HackCoinFlip");
        exploitFlipContract = await exploitFactory.deploy(coinFlipContract.address);

        for (let i = 0; i < numOfGuesses; i++) {
            await exploitFlipContract.guaranteeGuess();
            await time.increase(900);
        }

        const winsInARow = await coinFlipContract.consecutiveWins();
        console.log(`Consecutive Wins: ${winsInARow}`);
    });

    it("Attack Contract with 1000 guesses", async () => {
        numOfGuesses = 1000;
        // Deploy the hack coin flip contract with a guess goal of 10
        const exploitFactory = await ethers.getContractFactory("HackCoinFlip");
        exploitFlipContract = await exploitFactory.deploy(coinFlipContract.address);

        for (let i = 0; i < numOfGuesses; i++) {
            await exploitFlipContract.guaranteeGuess();
            await time.increase(1);
        }

        const winsInARow = await coinFlipContract.consecutiveWins();
        console.log(`Consecutive Wins: ${winsInARow}`);
    });
});


