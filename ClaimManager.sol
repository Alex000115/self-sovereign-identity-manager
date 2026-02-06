// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ClaimManager {
    struct Claim {
        uint256 topic;
        uint256 scheme;
        address issuer;
        bytes signature; // Signed by Issuer
        bytes data;
        string uri;
    }

    mapping(bytes32 => Claim) public claims;
    mapping(uint256 => bytes32[]) public claimsByTopic;

    function addClaim(
        uint256 _topic,
        uint256 _scheme,
        address _issuer,
        bytes memory _signature,
        bytes memory _data,
        string memory _uri
    ) public returns (bytes32 claimId) {
        claimId = keccak256(abi.encodePacked(_issuer, _topic));
        claims[claimId] = Claim(_topic, _scheme, _issuer, _signature, _data, _uri);
        claimsByTopic[_topic].push(claimId);
    }
}
