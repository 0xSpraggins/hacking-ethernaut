// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { GatekeeperOne } from "../../contracts/ethernaut/GatekeeperOne.sol";
import { HackGatekeeperOne } from "../../contracts/solutions/HackGatekeeperOne.sol";

contract GatekeeperOneTest is Test { 
    GatekeeperOne private _gatekeeperOne;
    HackGatekeeperOne private _hackGatekeeperOne;
    address private _hacker;
    event LogContract(address);

    function setUp() public {
        _gatekeeperOne = new GatekeeperOne();
        _hackGatekeeperOne = new HackGatekeeperOne(address(_gatekeeperOne));
		emit LogContract(address(this));

        (_hacker, ) = makeAddrAndKey('hacker');
    }

    function test_Attack() public {
        // Second parameter sets the tx.origin to the hacker address
        vm.startPrank(_hacker, _hacker);
        _hackGatekeeperOne.attack();
        vm.stopPrank();
    }
}