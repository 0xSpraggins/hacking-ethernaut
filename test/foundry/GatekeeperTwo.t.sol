// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { GatekeeperTwo } from "../../contracts/ethernaut/GatekeeperTwo.sol";
import { HackGatekeeperTwo } from "../../contracts/solutions/HackGatekeeperTwo.sol";

contract GatekeeperTwoTest is Test { 
    GatekeeperTwo private _gatekeeperTwo;
    HackGatekeeperTwo private _hackGatekeeperTwo;
    address private _hacker;

    function setUp() public {
        _gatekeeperTwo = new GatekeeperTwo();

        (_hacker, ) = makeAddrAndKey('hacker');
    }

    function test_Attack() public {
        // Second parameter sets the tx.origin to the hacker address
        vm.startPrank(_hacker, _hacker);
        _hackGatekeeperTwo = new HackGatekeeperTwo(address(_gatekeeperTwo));
        vm.stopPrank();
    }
}