// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC725 {
    event KeyAdded(bytes32 indexed key, uint256 indexed purpose, uint256 indexed keyType);
    event KeyRemoved(bytes32 indexed key, uint256 indexed purpose, uint256 indexed keyType);
    event ExecutionRequested(uint256 indexed executionId, address indexed to, uint256 value, bytes data);
    event Executed(uint256 indexed executionId, address indexed to, uint256 value, bytes data);

    function getKey(bytes32 _key) external view returns (uint256[] memory purposes, uint256 keyType, bytes32 key);
    function execute(address _to, uint256 _value, bytes calldata _data) external returns (uint256 executionId);
}
