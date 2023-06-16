// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { Recovery, SimpleToken } from "../../contracts/ethernaut/Recovery.sol";
import { HackRecovery } from "../../contracts/solutions/HackRecovery.sol";

contract RecoveryTest is Test {
    Recovery private _recovery;
    HackRecovery private _hackRecovery;
    address private _lostUser;
    address private _tokenAddress;

    function setUp() public {
        _lostUser = makeAddr("lost");
        _recovery = new Recovery();
        _hackRecovery = new HackRecovery();
        _tokenAddress = computeCreateAddress(address(_recovery), vm.getNonce(address(_recovery)));
        vm.startPrank(_lostUser);
        console.log("Token Address", _tokenAddress);
        _recovery.generateToken("test token", 1 ether);
        vm.stopPrank();
    }

    function testTokenAccountIsFound() public {
        assertEq(SimpleToken(payable(_tokenAddress)).balances(_lostUser), 1 ether);
    }

    function test_Attack() public {
        address hacker = makeAddr("hacker");
        vm.startPrank(hacker);
        _hackRecovery.attack(_tokenAddress);
        vm.stopPrank();

        assertEq(SimpleToken(payable(_tokenAddress)).balances(hacker), 0);
    }

}