// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC725.sol";

contract Identity is IERC725 {
    uint256 constant MANAGEMENT_KEY = 1;
    uint256 constant ACTION_KEY = 2;

    struct Key {
        uint256[] purposes;
        uint256 keyType; // 1 = ECDSA
        bytes32 key;
    }

    mapping(bytes32 => Key) private keys;
    uint256 private executionNonce;

    constructor() {
        bytes32 adminKey = keccak256(abi.encodePacked(msg.sender));
        keys[adminKey].key = adminKey;
        keys[adminKey].purposes.push(MANAGEMENT_KEY);
        keys[adminKey].keyType = 1;
    }

    function getKey(bytes32 _key) external view override returns (uint256[] memory, uint256, bytes32) {
        return (keys[_key].purposes, keys[_key].keyType, keys[_key].key);
    }

    function execute(address _to, uint256 _value, bytes calldata _data) external override returns (uint256) {
        // Only keys with ACTION_KEY or MANAGEMENT_KEY purpose can execute
        bytes32 senderKey = keccak256(abi.encodePacked(msg.sender));
        require(_hasPurpose(senderKey, ACTION_KEY) || _hasPurpose(senderKey, MANAGEMENT_KEY), "Unauthorized");

        (bool success, ) = _to.call{value: _value}(_data);
        require(success, "Execution failed");
        
        emit Executed(executionNonce, _to, _value, _data);
        return executionNonce++;
    }

    function _hasPurpose(bytes32 _key, uint256 _purpose) internal view returns (bool) {
        for (uint i = 0; i < keys[_key].purposes.length; i++) {
            if (keys[_key].purposes[i] == _purpose) return true;
        }
        return false;
    }
}
