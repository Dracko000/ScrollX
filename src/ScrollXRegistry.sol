// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ScrollXRegistry {
    struct Rollup {
        address owner;
        address rollupAddress;
        bytes32 rollupType; // "ZK-Rollup", "Validium", "Volition" (disimpan sebagai bytes32)
        bool isActive;
        uint256 registeredAt;
    }

    mapping(address => Rollup) public rollups;
    address[] public rollupList;

    event RollupRegistered(address indexed owner, address indexed rollupAddress, bytes32 rollupType, uint256 timestamp);
    event RollupDeactivated(address indexed rollupAddress);

    modifier onlyOwner(address _rollupAddress) {
        require(rollups[_rollupAddress].owner == msg.sender, "Only owner can modify");
        _;
    }

    function registerRollup(address _rollupAddress, string memory _rollupType) external {
        require(_rollupAddress != address(0), "Invalid rollup address");
        require(rollups[_rollupAddress].owner == address(0), "Rollup already registered");

        bytes32 typeHash = keccak256(abi.encodePacked(_rollupType));

        rollups[_rollupAddress] = Rollup({
            owner: msg.sender,
            rollupAddress: _rollupAddress,
            rollupType: typeHash,
            isActive: true,
            registeredAt: block.timestamp
        });

        rollupList.push(_rollupAddress);
        emit RollupRegistered(msg.sender, _rollupAddress, typeHash, block.timestamp);
    }

    function deactivateRollup(address _rollupAddress) external onlyOwner(_rollupAddress) {
        rollups[_rollupAddress].isActive = false;
        emit RollupDeactivated(_rollupAddress);
    }

    function getRollups() external view returns (address[] memory) {
        return rollupList;
    }

    function getRollupInfo(address _rollupAddress) external view returns (Rollup memory) {
        return rollups[_rollupAddress];
    }
}
