// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { CoinFlip } from "../../contracts/ethernaut/CoinFlip.sol";
import { HackCoinFlip } from "../../contracts/solutions/HackCoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip private _coinFlip;
    HackCoinFlip private _hackCoinFlip;


    function setUp() public {
        _coinFlip = new CoinFlip();
        _hackCoinFlip = new HackCoinFlip(address(_coinFlip));
    }

    function test_attackWith10Guesses() public {

        for (uint256 i = 0; i < 10; i++) {
            _hackCoinFlip.guaranteeGuess();
            vm.roll(block.number + 1);
        }

        assertEq(_coinFlip.consecutiveWins(), 10, "CoinFlipTest: failed to win 10 times in a row");
    }

}