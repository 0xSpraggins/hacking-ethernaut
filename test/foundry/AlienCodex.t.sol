// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { AlienCodex } from "../../contracts/ethernaut/AlienCodex.sol";
import { HackAlienCodex, ISolver } from "../../contracts/solutions/HackAlienCodex.sol";

contract AlienCodexTest is Test {
    AlienCodex private _alienCodex;
    HackAlienCodex private _hackAlienCodex;

    function setUp() public {
        _alienCodex = new AlienCodex();
        _hackAlienCodex = new HackAlienCodex(address(_alienCodex));
    }

    function test_Attack() public {
    }
}