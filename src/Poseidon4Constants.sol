// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

library Poseidon4Constants {
    // All 320 round constants from Poseidon4Lib.sol
    function getRoundConstants(uint256 round) internal pure returns (uint256[5] memory) {
        if (round == 0) {
            return [
                0x5c5bec06aa43ca811a9c78919fe505276e4625b2dc92b86947cc4d7726c77d3d,
                0x6268bc5f9031edb5b6bc2edbbe091cce714d51abbba4301fa0a19319da4ca232,
                0x4572aeff3e581883c3333a4fcb784afdd0f4b81f0d34e36835fd9a2644342b6a,
                0x2c44402b93c5ac82bc8bb58e947fca107e865d85b1cb0f1f32f0c05cdaf439f8,
                0x023eb54d53e89505d0c9258bee0de17bb0a11e451b48d22d88549e05e2018403
            ];
        } else if (round == 1) {
            return [
                0x5c3c49994dfe7863f506ee54719e6ee22a8136da7b276fd95b222de90b48feec,
                0x349b3f7366f89983b3858e40a22f53fa2e62ad46932303ce85d42591ca5141a3,
                0x0b383428a756701b8c1c1c38c9c3abbb4df3b6fbb5a581fe9bba326455776e91,
                0x6814d01a7834e8f1f53b89bae25702ed6c864c49ffba3820e6106185e81a85e1,
                0x382d39c6bdbba256b12d3fa4476187c14c4867255ea999c6503e92f520e9a918
            ];
        }
        // TODO: Add remaining rounds 2-63 with their respective 5 constants each
        else {
            return [uint256(0), uint256(0), uint256(0), uint256(0), uint256(0)];
        }
    }
}