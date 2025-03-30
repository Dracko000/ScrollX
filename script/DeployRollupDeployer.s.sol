// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/RollupDeployer.sol";

contract DeployRollupDeployer is Script {
    function run() external {
        vm.startBroadcast();

        address registryAddress = vm.envAddress("SCROLLX_REGISTRY"); // Ambil alamat ScrollXRegistry dari env
        new RollupDeployer(registryAddress);

        vm.stopBroadcast();
    }
}
