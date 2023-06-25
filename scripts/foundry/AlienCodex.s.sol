// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** 
 * @notice When using this script set the compiler version to v0.8.12+commit.f00d7308
 * @notice Run with 1000 Optimization runs
 */

import "forge-std/Script.sol";

import { HackAlienCodex } from "../../contracts/solutions/HackAlienCodex.sol";

contract MagicNumScript is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);

        HackAlienCodex hackAlienCodex = new HackAlienCodex(levelInstanceAddress);
        
        vm.stopBroadcast();

    }
}