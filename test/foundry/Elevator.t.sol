// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import { Elevator } from "../../contracts/ethernaut/Elevator.sol";
import { HackElevator } from "../../contracts/solutions/HackElevator.sol";

contract ElevatorTest is Test {
    Elevator private _elevator;
    HackElevator private _hackElevator;
    uint private _topFloorInBuilding = 5;

    function setUp() public {
        _elevator = new Elevator();
        _hackElevator = new HackElevator(address(_elevator), _topFloorInBuilding);
    }

    function test_Attack() public {
        _hackElevator.attack();
        assertTrue(_elevator.top());
    }
}