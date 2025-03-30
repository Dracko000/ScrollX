// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ScrollXRegistry {
    struct Rollup {
        address owner;
        address rollupAddress;
        string rollupType; // "ZK-Rollup", "Validium", "Volition"
        bool isActive;
    }

    mapping(address => Rollup) public rollups;
    address[] public rollupList;
    event RollupRegistered(address indexed owner, address rollupAddress, string rollupType);
    event RollupDeactivated(address indexed rollupAddress);

    function registerRollup(address _rollupAddress, string memory _rollupType) external {
        require(rollups[_rollupAddress].owner == address(0), "Rollup already registered");
        rollups[_rollupAddress] = Rollup(msg.sender, _rollupAddress, _rollupType, true);
        rollupList.push(_rollupAddress);
        emit RollupRegistered(msg.sender, _rollupAddress, _rollupType);
    }

    function deactivateRollup(address _rollupAddress) external {
        require(rollups[_rollupAddress].owner == msg.sender, "Only owner can deactivate");
        rollups[_rollupAddress].isActive = false;
        emit RollupDeactivated(_rollupAddress);
    }

    function getRollups() external view returns (address[] memory) {
        return rollupList;
    }
}
