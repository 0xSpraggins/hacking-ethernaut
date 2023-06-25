// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { MagicNum } from "../../contracts/ethernaut/MagicNum.sol";
import { HackMagicNum, ISolver } from "../../contracts/solutions/HackMagicNum.sol";

contract MagicNumTest is Test {
    MagicNum private _magicNum;
    HackMagicNum private _hackMagicNum;
    ISolver private _solver;

    function setUp() public {
        _magicNum = new MagicNum();
        _hackMagicNum = new HackMagicNum(address(_magicNum));
        _solver = ISolver(_magicNum.solver());

    }

    function test_Attack() public {
        assertEq(_solver.whatIsTheMeaningOfLife(), 42);
    }
}