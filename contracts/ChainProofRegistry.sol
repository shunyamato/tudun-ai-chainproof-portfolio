// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChainProofRegistry {
    struct Proof {
        address issuer;
        uint256 registeredAt;
        string artifactType;
    }

    mapping(bytes32 => Proof) private proofs;

    event ProofRegistered(
        bytes32 indexed contentHash,
        address indexed issuer,
        uint256 registeredAt,
        string artifactType
    );

    function registerProof(
        bytes32 contentHash,
        string calldata artifactType
    ) external {
        require(contentHash != bytes32(0), "Hash is required");
        require(
            proofs[contentHash].registeredAt == 0,
            "Proof already registered"
        );

        proofs[contentHash] = Proof({
            issuer: msg.sender,
            registeredAt: block.timestamp,
            artifactType: artifactType
        });

        emit ProofRegistered(
            contentHash,
            msg.sender,
            block.timestamp,
            artifactType
        );
    }

    function isRegistered(
        bytes32 contentHash
    ) external view returns (bool) {
        return proofs[contentHash].registeredAt != 0;
    }

    function getProof(
        bytes32 contentHash
    )
        external
        view
        returns (
            address issuer,
            uint256 registeredAt,
            string memory artifactType
        )
    {
        Proof storage proof = proofs[contentHash];
        require(proof.registeredAt != 0, "Proof not found");

        return (
            proof.issuer,
            proof.registeredAt,
            proof.artifactType
        );
    }
}
