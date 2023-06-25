// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { AlienCodex } from "../ethernaut/AlienCodex.sol";

contract HackAlienCodex {
    AlienCodex private _alienCodex;

    constructor(address alienCodex) {
        _alienCodex = AlienCodex(alienCodex);
    }

    function attack() {
        
    }
}