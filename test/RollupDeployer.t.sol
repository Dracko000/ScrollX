// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/RollupDeployer.sol";

contract RollupDeployerTest is Test {
    RollupDeployer deployer;

    function setUp() public {
        deployer = new RollupDeployer();
    }

    function testDeployRollup() public {
        // Dummy bytecode untuk pengujian
        bytes memory rollupBytecode = hex"6080604052348015600f57600080fd5b50600080";

        address rollupAddress = deployer.deployRollup("ZK-Rollup", rollupBytecode);
        assertTrue(rollupAddress != address(0), "Deployment failed");

        (address owner, address registeredAddress, string memory rollupType, bool isActive) = deployer.rollups(rollupAddress);

        assertEq(owner, address(this), "Owner mismatch");
        assertEq(registeredAddress, rollupAddress, "Rollup address mismatch");
        assertEq(rollupType, "ZK-Rollup", "Rollup type mismatch");
        assertTrue(isActive, "Rollup should be active");
    }
}
