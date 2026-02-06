# Self-Sovereign Identity Manager

This repository provides a standardized way to manage digital identities on-chain. It separates the "Identity" (the contract acting as a proxy) from the "Keys" (authorized controllers) and "Claims" (verifiable statements about the identity).

## Core Standards
* **ERC-725:** A proxy contract that can execute transactions and hold data. It acts as the "face" of the identity.
* **ERC-735:** A standard for adding, removing, and holding claims issued by third parties.

## Key Components
* **Key Management:** Multi-purpose keys (Management, Action, Claim, Encryption).
* **Claim Validation:** Logic to verify that a claim was indeed signed by a trusted issuer.
* **Proxy Execution:** The identity contract can interact with other dApps, effectively allowing you to "Log in with your Identity."



## Usage Flow
1. **Identity Deployment:** User deploys their personal `Identity.sol`.
2. **Claim Issuance:** A trusted Issuer signs a data package (e.g., "User is 18+").
3. **Claim Addition:** The user adds this signed claim to their contract.
4. **Verification:** A 3rd party dApp reads the claim and verifies the Issuer's signature.
