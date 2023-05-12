// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { King } from "../../contracts/ethernaut/King.sol";
import { HackKing } from "../../contracts/solutions/HackKing.sol";

contract KingTest is Test {
    King private _king;
    HackKing private _hackKing;
    address private _hacker;
    address private _rando;

    function setUp() public {
        (address ethernaut, ) = makeAddrAndKey("ethernaut");

        vm.startPrank(ethernaut);
        _king = new King();
        vm.stopPrank();
    
        (_hacker, ) = makeAddrAndKey("hacker");
        (_rando, ) = makeAddrAndKey("rando"); 

        vm.deal(_hacker, 1 ether);
        vm.deal(_rando, 1 ether);

        vm.startPrank(_hacker);
        _hackKing = new HackKing(payable(address(_king)));

        (bool success, ) = address(_hackKing).call{ value: _king.prize() + 1 }(
            abi.encodeWithSignature("becomeKing()")
        );

        assertEq(success, true, "should be able to become king");

        vm.stopPrank();
    }

    function testFail_RevertWhenRandoTriesToDethrown() public {
        vm.startPrank(_rando);

        payable(_king).transfer(_king.prize() + 1);

        vm.stopPrank();
    }

    
}