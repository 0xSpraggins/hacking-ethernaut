// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { Preservation, LibraryContract } from "../../contracts/ethernaut/Preservation.sol";
import { HackPreservation } from "../../contracts/solutions/HackPreservation.sol";

contract PreservationTest is Test {
    Preservation private _preservation;
    HackPreservation private _hackPreservation;
    address private _hacker;

    function setUp() public {
        address libOne = address(new LibraryContract());
        address libTwo = address(new LibraryContract());
        _preservation = new Preservation(libOne, libTwo);
        _hackPreservation = new HackPreservation();
        (_hacker, ) = makeAddrAndKey("hacker");
    }

    function test_attack() public {
        vm.startPrank(_hacker);
        _hackPreservation.attack(address(_preservation));
        assertEq(_preservation.owner(), _hacker);
    }
    
}