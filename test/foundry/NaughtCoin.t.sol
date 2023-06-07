// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { NaughtCoin } from "../../contracts/ethernaut/NaughtCoin.sol";
import { HackNaughtCoin } from "../../contracts/solutions/HackNaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin private _naughtCoin;
    HackNaughtCoin private _hackNaughtCoin;
    address private _hacker;

    function setUp() public {
        (_hacker,) = makeAddrAndKey("hacker");
        vm.startPrank(_hacker);

        _naughtCoin = new NaughtCoin(_hacker);
        _hackNaughtCoin = new HackNaughtCoin(address(_naughtCoin));
    }

    function test_attack() public {
        _naughtCoin.approve(address(_hackNaughtCoin), type(uint256).max);
        _hackNaughtCoin.attack(address(1));

        vm.stopPrank();
        
        assertEq(_naughtCoin.balanceOf(_hacker), 0);
    }
    
}