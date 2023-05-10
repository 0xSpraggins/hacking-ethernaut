// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { Telephone } from "../../contracts/ethernaut/Telephone.sol";
import { HackTelephone } from "../../contracts/solutions/HackTelephone.sol";

contract TelephoneTest is Test {
    Telephone private _telephone;
    HackTelephone private _hackTelephone;
    address private _hacker;

    function setUp() public {
        (_hacker, ) = makeAddrAndKey("hacker");

        _telephone = new Telephone();
        _hackTelephone = new HackTelephone(address(_telephone));
    }

    function test_attack() public {
        _hackTelephone.attack(_hacker);
        assertEq(_telephone.owner(), _hacker);
    }
}