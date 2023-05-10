// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.8.0;
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { Reentrance } from  "../../contracts/ethernaut/Reentrance.sol";
import { HackReentrance } from "../../contracts/solutions/HackReentrance.sol";

contract ReentranceTest is Test {
    Reentrance _reentrance;
    HackReentrance _hackReentrance;
    address private _deployer;
    address private _hacker;
    address private _rando;

    function setUp() public {
        _reentrance = new Reentrance();
        _hackReentrance = new HackReentrance(payable(address((_reentrance))));

        (_hacker, ) = makeAddrAndKey("hacker");
        (_rando, ) = makeAddrAndKey("rando");

        vm.deal(_hacker, 1 ether);
        vm.deal(_rando, 1 ether);

        vm.startPrank(_rando);
        (bool success,) = address(_reentrance).call{value: 10000000000}(
            abi.encodeWithSignature("donate(address)", _rando)
        );
        require(success, "ReentranceTest: failed to donate to reentrance");
        vm.stopPrank();
    }

    function test_attack() public {
        vm.startPrank(_hacker);

        (bool success,) = address(_hackReentrance).call{value: 200000000}(
            abi.encodeWithSignature("contribute()")
        );

        uint256 reentranceBalance = address(_reentrance).balance;
        assertEq(success, true, "ReentranceTest: failed to contribute to hackReentrance");

        _hackReentrance.beginAttack();

        assertEq(address(_reentrance).balance, 0, "ReentranceTest: failed to drain Reentrance");
        assertEq(address(_hackReentrance).balance, reentranceBalance, "ReentranceTest: failed capture Reentrance balance");
        vm.stopPrank();
    }

}

