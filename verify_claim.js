const { ethers } = require("ethers");

async function verifyClaim(issuerAddress, claimData, signature) {
    const messageHash = ethers.utils.keccak256(claimData);
    const recoveredAddress = ethers.utils.verifyMessage(ethers.utils.arrayify(messageHash), signature);
    
    return recoveredAddress.toLowerCase() === issuerAddress.toLowerCase();
}
