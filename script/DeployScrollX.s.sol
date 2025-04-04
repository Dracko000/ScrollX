// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ScrollXRegistry.sol";

contract DeployScrollX is Script {
    function run() external {
        vm.startBroadcast();
        new ScrollXRegistry();
        vm.stopBroadcast();
    }
}
