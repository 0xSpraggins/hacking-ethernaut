// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** 
 * @notice When using this script set the compiler version to v0.8.12+commit.f00d7308
 * @notice Run with 1000 Optimization runs
 */

import "forge-std/Script.sol";

import { HackGatekeeperOne } from "../../contracts/solutions/HackGatekeeperOne.sol";

contract GatekeeperOneScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);

        HackGatekeeperOne hackGatekeeperOne = new HackGatekeeperOne(levelInstanceAddress);

        hackGatekeeperOne.attack();

        vm.stopBroadcast();

    }
}