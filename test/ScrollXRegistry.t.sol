// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ScrollXRegistry.sol";

contract ScrollXRegistryTest is Test {
    ScrollXRegistry registry;

    function setUp() public {
        registry = new ScrollXRegistry();
    }

    function testRegisterRollup() public {
        address rollupAddress = address(1);
        registry.registerRollup(rollupAddress, "ZK-Rollup");
        (address owner, , , bool isActive, ) = registry.rollups(rollupAddress);
        assertEq(owner, address(this));
        assertTrue(isActive);
    }
}
