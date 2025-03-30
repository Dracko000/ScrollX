// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ScrollXRegistry.sol";

contract RollupDeployer {
    event RollupDeployed(address indexed owner, address rollupAddress, string rollupType);

    ScrollXRegistry public registry;

    struct Rollup {
        address owner;
        address rollupAddress;
        string rollupType;
        bool isActive;
    }

    mapping(address => Rollup) public rollups;
    address[] public rollupList;

    constructor(address _registryAddress) {
        registry = ScrollXRegistry(_registryAddress);
    }

    function deployRollup(string memory _rollupType, bytes memory _bytecode) external returns (address) {
        address rollupAddress;
        assembly {
            rollupAddress := create(0, add(_bytecode, 0x20), mload(_bytecode))
        }
        require(rollupAddress != address(0), "Deployment failed");

        rollups[rollupAddress] = Rollup(msg.sender, rollupAddress, _rollupType, true);
        rollupList.push(rollupAddress);

        // **Daftarkan rollup ke ScrollXRegistry**
        registry.registerRollup(rollupAddress, _rollupType);

        emit RollupDeployed(msg.sender, rollupAddress, _rollupType);
        return rollupAddress;
    }

    function getRollups() external view returns (address[] memory) {
        return rollupList;
    }
}
