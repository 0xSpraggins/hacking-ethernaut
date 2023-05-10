// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { Force } from "../../contracts/ethernaut/Force.sol";
import { HackForce } from "../../contracts/solutions/HackForce.sol";

contract ForceTest is Test {
    Force private _force;
    HackForce private _hackForce;

    function setUp() public {
        _force = new Force();
        _hackForce = new HackForce(address(_force));

        (bool success, ) = address(_hackForce).call{value: 1}(
            abi.encodeWithSignature("donate()")
        );

        assertEq(success, true, "Donation Failed");
    }

    function test_attack() public {
        _hackForce.attack();
        assertGt(address(_force).balance, 0);
    }
    
}