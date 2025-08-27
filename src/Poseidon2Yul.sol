// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

contract Poseidon2Yul {
    fallback() external {
        assembly {
            let PRIME := 0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001

            // Sponge state (t=3) - matching poseidon2Direct structure
            let state0 := 0  // Initialize to 0 (capacity)
            let state1 := 0  // Will hold first input
            let state2 := 0  // Will hold second input

            // Absorb inputs - matching poseidon2Direct structure
            // state[0] = 0, state[1] = input1, state[2] = input2
            state1 := calldataload(0)     // First input to state1
            state2 := calldataload(0x20)  // Second input to state2

            // No initial linear layer - start directly with rounds

            // First half of full rounds (4 rounds: 0-3)
            
            // Full round 0
            // Add round constants
            state0 := add(state0, 0x6f007a551156b3a449e44936b7c093644a0ed33f33eaccc628e942e836c1a875)
            state1 := add(state1, 0x360d7470611e473d353f628f76d110f34e71162f31003b7057538c2596426303)  
            state2 := add(state2, 0x4b5fec3aa073df44019091f007a44ca996484965f7036dce3e9d0977edcdc0f6)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Full round 1
            // Add round constants
            state0 := add(state0, 0x67cf1868af6396c0b84cce715e539f849e06cd1c383ac5b06100c76bcc973a11)
            state1 := add(state1, 0x555db4d1dced819f5d3de70fde83f1c7d3e8c98968e516a23a771a5c9c8257aa)  
            state2 := add(state2, 0x2bab94d7ae222d135dc3c6c5febfaa314908ac2f12ebe06fbdb74213bf63188b)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Full round 2
            // Add round constants
            state0 := add(state0, 0x66f44be5296682c4fa7882799d6dd049b6d7d2c950ccf98cf2e50d6d1ebb77c2)
            state1 := add(state1, 0x150c93fef652fb1c2bf03e1a29aa871fef77e7d736766c5d0939d92753cc5dc8)  
            state2 := add(state2, 0x3270661e68928b3a955d55db56dc57c103cc0a60141e894e14259dce537782b2)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Full round 3
            // Add round constants
            state0 := add(state0, 0x073f116f04122e25a0b7afe4e2057299b407c370f2b5a1ccce9fb9ffc345afb3)
            state1 := add(state1, 0x409fda22558cfe4d3dd8dce24f69e76f8c2aaeb1dd0f09d65e654c71f32aa23f)  
            state2 := add(state2, 0x2a32ec5c4ee5b1837affd09c1f53f5fd55c9cd2061ae93ca8ebad76fc71554d8)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }
            
            // Partial rounds (56 rounds: 4-59)  
            
            // Partial round 4
            // Add round constants  
            state0 := add(state0, 0x5848ebeb5923e92555b7124fffba5d6bd571c6f984195eb9cfd3a3e8eb55b1d4)
            state1 := add(state1, 0x270326ee039df19e651e2cfc740628ca634d24fc6e2559f22d8ccbe292efeead)
            state2 := add(state2, 0x27c6642ac633bc66dc100fe7fcfa54918af895bce012f182a068fc37c182e274)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 5
            // Add round constants  
            state0 := add(state0, 0x1bdfd8b01401c70ad27f57396989129d710e1fb6ab976a459ca18682e26d7ff9)
            state1 := add(state1, 0x491b9ba6983bcf9f05fe4794adb44a30879bf8289662e1f57d90f672414e8a4a)
            state2 := add(state2, 0x162a14c62f9a89b814b9d6a9c84dd678f4f6fb3f9054d373c832d824261a35ea)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 6
            // Add round constants  
            state0 := add(state0, 0x2d193e0f76de586b2af6f79e3127feeaac0a1fc71e2cf0c0f79824667b5b6bec)
            state1 := add(state1, 0x46efd8a9a262d6d8fdc9ca5c04b0982f24ddcc6e9863885a6a732a3906a07b95)
            state2 := add(state2, 0x509717e0c200e3c92d8dca2973b3db45f0788294351ad07ae75cbb780693a798)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 7
            // Add round constants  
            state0 := add(state0, 0x7299b28464a8c94fb9d4df61380f39c0dca9c2c014118789e227252820f01bfc)
            state1 := add(state1, 0x044ca3cc4a85d73b81696ef1104e674f4feff82984990ff85d0bf58dc8a4aa94)
            state2 := add(state2, 0x1cbaf2b371dac6a81d0453416d3e235cb8d9e2d4f314f46f6198785f0cd6b9af)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 8
            // Add round constants  
            state0 := add(state0, 0x1d5b2777692c205b0e6c49d061b6b5f4293c4ab038fdbbdc343e07610f3fede5)
            state1 := add(state1, 0x56ae7c7a5293bdc23e85e1698c81c77f8ad88c4b33a5780437ad047c6edb59ba)
            state2 := add(state2, 0x2e9bdbba3dd34bffaa30535bdd749a7e06a9adb0c1e6f962f60e971b8d73b04f)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 9
            // Add round constants  
            state0 := add(state0, 0x2de11886b18011ca8bd5bae36969299fde40fbe26d047b05035a13661f22418b)
            state1 := add(state1, 0x2e07de1780b8a70d0d5b4a3f1841dcd82ab9395c449be947bc998884ba96a721)
            state2 := add(state2, 0x0f69f1854d20ca0cbbdb63dbd52dad16250440a99d6b8af3825e4c2bb74925ca)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 10
            // Add round constants  
            state0 := add(state0, 0x5dc987318e6e59c1afb87b655dd58cc1d22e513a05838cd4585d04b135b957ca)
            state1 := add(state1, 0x48b725758571c9df6c01dc639a85f07297696b1bb678633a29dc91de95ef53f6)
            state2 := add(state2, 0x5e565e08c0821099256b56490eaee1d573afd10bb6d17d13ca4e5c611b2a3718)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 11
            // Add round constants  
            state0 := add(state0, 0x2eb1b25417fe17670d135dc639fb09a46ce5113507f96de9816c059422dc705e)
            state1 := add(state1, 0x115cd0a0643cfb988c24cb44c3fab48aff36c661d26cc42db8b1bdf4953bd82c)
            state2 := add(state2, 0x26ca293f7b2c462d066d7378b999868bbb57ddf14e0f958ade801612311d04cd)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 12
            // Add round constants  
            state0 := add(state0, 0x4147400d8e1aaccf311a6b5b762011ab3e45326e4d4b9de26992816b99c528ac)
            state1 := add(state1, 0x6b0db7dccc4ba1b268f6bdcc4d372848d4a72976c268ea30519a2f73e6db4d55)
            state2 := add(state2, 0x17bf1b93c4c7e01a2a830aa162412cd90f160bf9f71e967ff5209d14b24820ca)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 13
            // Add round constants  
            state0 := add(state0, 0x4b431cd9efedbc94cf1eca6f9e9c1839d0e66a8bffa8c8464cac81a39d3cf8f1)
            state1 := add(state1, 0x35b41a7ac4f3c571a24f8456369c85dfe03c0354bd8cfd3805c86f2e7dc293c5)
            state2 := add(state2, 0x3b1480080523c439435927994849bea964e14d3beb2dddde72ac156af435d09e)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 14
            // Add round constants  
            state0 := add(state0, 0x2cc6810031dc1b0d4950856dc907d57508e286442a2d3eb2271618d874b14c6d)
            state1 := add(state1, 0x6f4141c8401c5a395ba6790efd71c70c04afea06c3c92826bcabdd5cb5477d51)
            state2 := add(state2, 0x25bdbbeda1bde8c1059618e2afd2ef999e517aa93b78341d91f318c09f0cb566)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 15
            // Add round constants  
            state0 := add(state0, 0x392a4a8758e06ee8b95f33c25dde8ac02a5ed0a27b61926cc6313487073f7f7b)
            state1 := add(state1, 0x272a55878a08442b9aa6111f4de009485e6a6fd15db89365e7bbcef02eb5866c)
            state2 := add(state2, 0x631ec1d6d28dd9e824ee89a30730aef7ab463acfc9d184b355aa05fd6938eab5)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 16
            // Add round constants  
            state0 := add(state0, 0x4eb6fda10fd0fbde02c7449bfbddc35bcd8225e7e5c3833a0818a100409dc6f2)
            state1 := add(state1, 0x2d5b308b0cf02cdfefa13c4e60e26239a6ebba011694dd129b925b3c5b21e0e2)
            state2 := add(state2, 0x16549fc6af2f3b72dd5d293d72e2e5f244dff42f18b46c56ef38c57c311673ac)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 17
            // Add round constants  
            state0 := add(state0, 0x42332677ff359c5e8db836d9f5fb54822e39bd5e22340bb9ba975ba1a92be382)
            state1 := add(state1, 0x49d7d2c0b449e5179bc5ccc3b44c6075d9849b5610465f09ea725ddc97723a94)
            state2 := add(state2, 0x64c20fb90d7a003831757cc4c6226f6e4985fc9ecb416b9f684ca0351d967904)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 18
            // Add round constants  
            state0 := add(state0, 0x59cff40de83b52b41bc443d7979510d771c940b9758ca820fe73b5c8d5580934)
            state1 := add(state1, 0x53db2731730c39b04edd875fe3b7c882808285cdbc621d7af4f80dd53ebb71b0)
            state2 := add(state2, 0x1b10bb7a82afce39fa69c3a2ad52f76d76398265344203119b7126d9b46860df)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 19
            // Add round constants  
            state0 := add(state0, 0x561b6012d666bfe179c4dd7f84cdd1531596d3aac7c5700ceb319f91046a63c9)
            state1 := add(state1, 0x0f1e7505ebd91d2fc79c2df7dc98a3bed1b36968ba0405c090d27f6a00b7dfc8)
            state2 := add(state2, 0x2f313faf0d3f6187537a7497a3b43f46797fd6e3f18eb1caff457756b819bb20)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 20
            // Add round constants  
            state0 := add(state0, 0x3a5cbb6de450b481fa3ca61c0ed15bc55cad11ebf0f7ceb8f0bc3e732ecb26f6)
            state1 := add(state1, 0x681d93411bf8ce63f6716aefbd0e24506454c0348ee38fabeb264702714ccf94)
            state2 := add(state2, 0x5178e940f50004312646b436727f0e80a7b8f2e9ee1fdc677c4831a7672777fb)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 21
            // Add round constants  
            state0 := add(state0, 0x3dab54bc9bef688dd92086e253b439d651baa6e20f892b62865527cbca915982)
            state1 := add(state1, 0x4b3ce75311218f9ae905f84eaa5b2b3818448bbf3972e1aad69de321009015d0)
            state2 := add(state2, 0x06dbfb42b979884de280d31670123f744c24b33b410fefd4368045acf2b71ae3)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 22
            // Add round constants  
            state0 := add(state0, 0x068d6b4608aae810c6f039ea1973a63eb8d2de72e3d2c9eca7fc32d22f18b9d3)
            state1 := add(state1, 0x4c5c254589a92a36084a57d3b1d964278acc7e4fe8f69f2955954f27a79cebef)
            state2 := add(state2, 0x6cbac5e1700984ebc32da15b4bb9683faabab55f67ccc4f71d9560b3475a77eb)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 23
            // Add round constants  
            state0 := add(state0, 0x4603c403bbfa9a17738a5c6278eaab1c37ec30b0737aa2409fc4898069eb983c)
            state1 := add(state1, 0x6894e7e22b2c1d5c70a712a6345ae6b192a9c833a9234c31c56aacd16bc2f100)
            state2 := add(state2, 0x5be2cbbc44053ad08afa4d1eabc7f3d231eea799b93f226e905b7d4d65c58ebb)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 24
            // Add round constants  
            state0 := add(state0, 0x58e55f287b453a9808624a8c2a353d528da0f7e713a5c6d0d7711e47063fa611)
            state1 := add(state1, 0x366ebfafa3ad381c0ee258c9b8fdfccdb868a7d7e1f1f69a2b5dfcc5572555df)
            state2 := add(state2, 0x45766ab728968c642f90d97ccf5504ddc10518a819ebbcc4d09c3f5d784d67ce)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 25
            // Add round constants  
            state0 := add(state0, 0x39678f65512f1ee404db3024f41d3f567ef66d89d044d022e6bc229e95bc76b1)
            state1 := add(state1, 0x463aed1d2f1f955e3078be5bf7bfc46fc0eb8c51551906a8868f18ffae30cf4f)
            state2 := add(state2, 0x21668f016a8063c0d58b7750a3bc2fe1cf82c25f99dc01a4e534c88fe53d85fe)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 26
            // Add round constants  
            state0 := add(state0, 0x39d00994a8a5046a1bc749363e98a768e34dea56439fe1954bef429bc5331608)
            state1 := add(state1, 0x4d7f5dcd78ece9a933984de32c0b48fac2bba91f261996b8e9d1021773bd07cc)
            state2 := add(state2, 0x1f9dbdc3f84312636b203bbe12fb3425b163d41605d39f99770c956f60d881b3)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 27
            // Add round constants  
            state0 := add(state0, 0x027745a9cddfad95e5f17b9e0ee0cab6be0bc829fe5e66c69794a9f7c336eab2)
            state1 := add(state1, 0x1cec0803c504b635788d695c61e932122fa43fe20a45c78d52025657abd8aee0)
            state2 := add(state2, 0x123523d75e9fabc172077448ef87cc6eed5082c8dbf31365d3872a9559a03a73)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 28
            // Add round constants  
            state0 := add(state0, 0x1723d1452c9cf02df419b848e5d694bf27feba35975ee7e5001779e3a1d357f4)
            state1 := add(state1, 0x557b5af29163a60034ec4ae1e358e471e188a398288014f1747906449058077a)
            state2 := add(state2, 0x1739d180a16010bdfcc0573d7e61369421c3f776f572836d9dab1ee4dcf96622)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 29
            // Add round constants  
            state0 := add(state0, 0x2d4e6354da9cc554acce32391794b627fafa96fbeb0ab89370290452042d048d)
            state1 := add(state1, 0x153ee6142e535e334a869553c9d007f88f3bd43f99260621670bcf6f8b485dcd)
            state2 := add(state2, 0x71773e86c806833f827f654f2c5a7ab5ad1935dc98e086797aae750c35afccb6)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 30
            // Add round constants  
            state0 := add(state0, 0x0c45bfd3a69aaa65635ef7e7a430b486968ad4424af83700d258d2e2b7782172)
            state1 := add(state1, 0x0adfd53b256a6957f2d56aec831446006897ac0a8ffa5ff10e5633d251f73307)
            state2 := add(state2, 0x41d52090ea5b43402b1a9adfd5e2f5f2f1d1dc75259d25229d2fb88eae087a1f)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 31
            // Add round constants  
            state0 := add(state0, 0x4ecdf55bd36d423a334ecd13f72e69bd4d93d12cbb53a10fc0ba7f3e9ec396f1)
            state1 := add(state1, 0x315d2ac8ebdbac3c8cd1726b7cbab8ee3f87b28f1c1be4bdac9d36a8b7516d63)
            state2 := add(state2, 0x49261a5d6cfd4a9f2a051d9906066d04a21709c9411cee63cc015562c9226432)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 32
            // Add round constants  
            state0 := add(state0, 0x40153234da114723048f6dcb7b695b69f7a7cfca052ff51526f3898cce337817)
            state1 := add(state1, 0x6e986d063d9fffc8121bc3c2c4ac3e76cf808cefbeccb1bdd3c0d64738f61bad)
            state2 := add(state2, 0x5283f80e81fc4e4d1c24a4cbc7693894eec452eedf44871de8f67534ca273948)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 33
            // Add round constants  
            state0 := add(state0, 0x552576887491b06d69aef8aac5710e8d844f896957a41921b12a066274c5a3f4)
            state1 := add(state1, 0x59332dc761e3ad275048a1198b73d5c3a99ba75b7b7e5995378338df48d6e398)
            state2 := add(state2, 0x1b8472712d02eef4cfaec23d2b16883fc9bb60d1f6959879299ce44ea423d8e1)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 34
            // Add round constants  
            state0 := add(state0, 0x4945c4c7c62282f08e36b59ab0e33001759e70e01221c74d5505586ae95eab68)
            state1 := add(state1, 0x6f7d34b9199bf60a87b4b06539a1554c413bd07c7430f7a54c0176c94c1b9e95)
            state2 := add(state2, 0x3c1cd07efda6ff24bd0b70fa2255eb6f367d2c54e36928c9c4a5404198adf70c)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 35
            // Add round constants  
            state0 := add(state0, 0x72ed857fbb581d2d92932995e80188c7ad9eb5c8c084d5d829394841274c91d2)
            state1 := add(state1, 0x136052d26bb3d373687f4e51b2e1dcd34a16073f738f7e0cbbe523aef9ab107a)
            state2 := add(state2, 0x623f02ec818792941c4894438841d441653ec1e760cc09f5ad102f014b6658c7)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 36
            // Add round constants  
            state0 := add(state0, 0x51c0b9b1022de4d0fea7ad49bf6d814ded9541807df5a911589583ba658d4348)
            state1 := add(state1, 0x42c1e81b61b7fc0b04b48024c56f83108dc800179ca7530868724ec3239f8463)
            state2 := add(state2, 0x42ce8d45e3f7bbf7f10a8fc71ab6d7c30bcf843897bc6823208202d2e31fd072)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 37
            // Add round constants  
            state0 := add(state0, 0x6e53bfc3ec7be39c064e2f0fdee7a37b0b93965712e431394bcce9c75c22f738)
            state1 := add(state1, 0x16c96beef6a0a848c1bdd859a1232a1d7b3cfbb873032681676c36c24ef967dd)
            state2 := add(state2, 0x284b38c57ff65c262ab7fed8f499a9fb012387bab4f1662d067eec7f2d6340c4)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 38
            // Add round constants  
            state0 := add(state0, 0x70cb7ad7798e307ef85d4bdfc76f837420ea23a9fe16273d60bfc6cebebb5ac1)
            state1 := add(state1, 0x0c5993d175e81f6639e242198897d17cfc06772c1c0411a6af1dff204c922f86)
            state2 := add(state2, 0x03bf7a3f7bd043dafcda655d1ba9c8f9f24887ad48e17759bbf53f67b1f87b15)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 39
            // Add round constants  
            state0 := add(state0, 0x3188fe4ee9f9fafbb0cf999567f00e734c8f9cbe69f0e8279b5cd09e36d8be62)
            state1 := add(state1, 0x171f528ccf6584375a39768c480d61e13af5bf77c1c42652afea99a2ec6c595a)
            state2 := add(state2, 0x12f4175c4ab45afc196e41859b35ef88812c3286ee7000675a0563b9b8e9f1d5)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 40
            // Add round constants  
            state0 := add(state0, 0x3a509e155cb7ebfd8f8fdcf800a9ac697e23e1aabe96cfab0e74d4d369118b79)
            state1 := add(state1, 0x10f2a685df4a27c81a89920e2504c3b3984bc8f2e4c1b69e98712c65678cfd30)
            state2 := add(state2, 0x4959043e2135e0389ed8c6f81104cb6390af37d616015a881ed3363404687f05)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 41
            // Add round constants  
            state0 := add(state0, 0x52bd4073f5f900448262e371dbafcbba1edc155f03bf7f871c47f08dae05fddd)
            state1 := add(state1, 0x09e5f49790c8a0e21d8d93d54ab91a0e54573c9333c56321e8a16728cc9d4918)
            state2 := add(state2, 0x352d69bed80ee3e52bf35705d9f84a3442d17ed6ee0fab7e609a740347cf5fea)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 42
            // Add round constants  
            state0 := add(state0, 0x058ee73ba9f3f293491562faf2b190d3c634debd281b76a63a758af6fa84e0e8)
            state1 := add(state1, 0x6184c223124d658cd4760ab3c3b9668947b12f279437ccd375ef855b3d999798)
            state2 := add(state2, 0x6ea989c63c451341c91afa790b6f84c0fff8d09680344bc7434998dfc696c115)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 43
            // Add round constants  
            state0 := add(state0, 0x57f4ac045fb78ade81f9196c9db8a7abf8de139c4a488a0613685982e8121812)
            state1 := add(state1, 0x6dbfdc64a545237a88ee79c1752a74ce767352b5071a0d317c5b49e259491b94)
            state2 := add(state2, 0x232f99cc911eddd9cd0f1fc55b1a3250092cb92119bc76be621a132510a43904)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 44
            // Add round constants  
            state0 := add(state0, 0x201beed7b8f3ab8186c22c6c5d4869f0f9efd52ca6bc2961c3b97c1e301bc213)
            state1 := add(state1, 0x4b99c756e1e0b9491a082e28c55458ccd5e97eb59381fc872223d9e77ef87b2d)
            state2 := add(state2, 0x1376dce6580030c6a1c9291d58602f5129388842744a1210bf6b3431ba94e9bc)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 45
            // Add round constants  
            state0 := add(state0, 0x1793199e6fd6ba342b3356c38238f761072ba8b02d92e7226454843c5486d7b3)
            state1 := add(state1, 0x5048857b8872cc1de188947dc3ee984e217d264c7975256fbfc74c8721472d98)
            state2 := add(state2, 0x5c772c20fc285d3e1854e3ededdd52942cd9b61c7755fe46dade9f89de8b3bbf)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 46
            // Add round constants  
            state0 := add(state0, 0x6e40d518ae3ce6cad092e810909a916c60fe77dfe7bbb86b5bfcceba1ae18879)
            state1 := add(state1, 0x22de7a7488dcc7359fee9c20c87a67df3c66160dc62aacac06a3f1d3b433311b)
            state2 := add(state2, 0x3514d5e9066bb160df8ff37fe2d8edf8dbe0b77fae77e1d030d6e3fd516b47a8)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 47
            // Add round constants  
            state0 := add(state0, 0x30cd3006931ad636f919a00dabbf5fa5ff453d6f900f144a19377427137a81c7)
            state1 := add(state1, 0x6203ad60b0341baa14e5c48b915f6b41e4959835d1a839996dcfc378b662c474)
            state2 := add(state2, 0x71e8d0ac035e59bf8007c0f3af24de07b674dae77042ae7dce7ae94770d76254)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 48
            // Add round constants  
            state0 := add(state0, 0x253d1a5c5293412741f81a5cf613c8df8f9e4b2cae2ebb515b6a74220692b506)
            state1 := add(state1, 0x035b461c02d79d19a35e9613e7f5fe92851b3a59c990fafc73f666cb86a48e8e)
            state2 := add(state2, 0x44476886a8f10f589800c8e3956f5f26648da4de0e86f19d35b334977c0fecc5)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 49
            // Add round constants  
            state0 := add(state0, 0x23a9928079d175bd5bc00eedd56b93e092b1283c2d5fccde7cfbf86a3aa04780)
            state1 := add(state1, 0x13a7785ae134ea92f1594a0763c611abb5e2ea3436eef957f1e4ccd73fa00a82)
            state2 := add(state2, 0x39fce308b7d43c574962ae3c0da17e313889c57863446d88bbf04f5252de4279)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 50
            // Add round constants  
            state0 := add(state0, 0x1aae18833f8e1d3ac0fdf01662f60d22bef00a08c6ed38d23b57e34489b53fad)
            state1 := add(state1, 0x1a761ce82400af018b2e80c064fd83ed27c1b3fd8f85d8a855513e033398513f)
            state2 := add(state2, 0x64df4c0ecc132a1ebf553cf334d88ed8a7ef1ec487821005a4e385d6fae179f0)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 51
            // Add round constants  
            state0 := add(state0, 0x47940c32599822d67897c4062665e15687220d2c5ce5713ca1ae44cdbf452141)
            state1 := add(state1, 0x275a03e45adda7c316dd1a87ca22e1ccdcf6af2830a502875244ca749b73e481)
            state2 := add(state2, 0x2e5a10f08b5ab8bbeb08e47e5feabcf807e561453fc5648b58a253cfb6a95786)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 52
            // Add round constants  
            state0 := add(state0, 0x6b4216c76c229946eba0b6ca567a5e01efef1919cd3424a161477bd2d2cdf30d)
            state1 := add(state1, 0x1459cb8587208473b84e9c333b2932f1c141a5b6d594bec4e033d82cefe78ce3)
            state2 := add(state2, 0x193ae5921d78b5de7b92ce810e14a40052f9332fbffcfbbd5cec7e7b338fbe1b)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 53
            // Add round constants  
            state0 := add(state0, 0x3097898a5d0011a489111fb2c4660281374384f4a072820560224be67248e82c)
            state1 := add(state1, 0x378d97bf8c864ae7571782fd96ce54b41979b2d1c465b4d9549980de862930f5)
            state2 := add(state2, 0x47e939590928513aaea5ca5fda898a41734378eabcda9b48adc35ce03f59d08e)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 54
            // Add round constants  
            state0 := add(state0, 0x2eb04ea7c01d97ec88136287ce376b08dbc7f5cb4609342137ea32a971d17884)
            state1 := add(state1, 0x668a95bddfb878732be2633ada541e1d1e163418f3ebf82316f64b24ab49cf05)
            state2 := add(state2, 0x57ff77ffd3ab3372985f839e7cd61fae628a683f22ab245256260a46ba14b26d)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 55
            // Add round constants  
            state0 := add(state0, 0x4e185328f8228371b8957c496316b4fcfd3c1786cec9a1b8f855edd27597e7af)
            state1 := add(state1, 0x36425347ea03f6412302a1c22e49baec861cbda476804e6cead3726f1af2e7b0)
            state2 := add(state2, 0x51b825d33b31b018ca3d3590dcc9ca41afe09f699191c41acdb5b3ef7e617b78)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 56
            // Add round constants  
            state0 := add(state0, 0x26b72df47408ad42cc996cd85c98a1d83f5b5ca5a19a9701ecd627e59590d09e)
            state1 := add(state1, 0x629f82ef3b843d15e5e67fbab2857f7665e39a2289df756ef82eda0e3baef82d)
            state2 := add(state2, 0x57da05c9a95902aea1b804e493ea27d661a36e5bd630fbc5b2565b42c81678df)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 57
            // Add round constants  
            state0 := add(state0, 0x65bb185aa22d4a6d0b9741e936b955bc6322fb749f73c9e95466747ca7d79dec)
            state1 := add(state1, 0x130180e44e2924db1f05636c610b89aade01212ee4588f8959bece31f0a31e95)
            state2 := add(state2, 0x219e97737d3979ba73275acaed5f579cdf7793cc89e5b52f9ea8e7bc79263550)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 58
            // Add round constants  
            state0 := add(state0, 0x4043fd3082574e5773a8654e32dd4190a6728be3fc54fab3644532e1c79a1800)
            state1 := add(state1, 0x5784e5360ffb6781d9cbc1df6bd8549c71d81f000d5c4d2f071dc0f28a21c720)
            state2 := add(state2, 0x3cdb93598a5ca5283461363f81c489a23b0672dd7d42cbb49c12635df251d153)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Partial round 59
            // Add round constants  
            state0 := add(state0, 0x0e59e6f332d7ed3720724b927a0ca81c4ad0447045a7c5aa2861ce16f219d5a9)
            state1 := add(state1, 0x57afcf069f3680a6ddcb3424ff2ab8d138a48f0fa72fc06286718f66cfe1df08)
            state2 := add(state2, 0x51ba5d4899d7835ec1a17fb1bc7101690828fd09ec92e732769a61f5f0c66085)
            
            // S-box only first element
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            // MDS matrix multiplication
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }
            
            // Second half of full rounds (4 rounds: 60-63)
            
            // Full round 60
            // Add round constants
            state0 := add(state0, 0x1b064342d51a42753d7369467222697a172cc07b9d33fbf943b0a3fcff2036bd)
            state1 := add(state1, 0x54aef45559da8b2c7472c3ad5a0d33086da6e4df67ef4ede874adebb2902df82)
            state2 := add(state2, 0x30b82a998cbd8e8a2f363c55b2882e0b78fa9fb9171221b73eb310228a0e5f6c)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication  
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Full round 61
            // Add round constants
            state0 := add(state0, 0x523a56f81ba90ef3a40ebdf2c848c8ab1a6c9889ac6c78eca8147a560db320c5)
            state1 := add(state1, 0x4fc581cc0a10b8c1d357e215fe5c7ec1d3a0931cad9a575da613b282fb1fd4b4)
            state2 := add(state2, 0x23e4ab37183acba463df7a76e858a4aa8ad71ea715be0573e46f6d4298740107)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication  
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Full round 62
            // Add round constants
            state0 := add(state0, 0x2795d5c5fa4280225d33094e0beda75bacfe14640de044f2fca995e2b59914a1)
            state1 := add(state1, 0x3001ca401e89601cd765f26dd03f4c45a6687c3df16c8fe4c26d909dee8b53c0)
            state2 := add(state2, 0x0072e45cc676b08ef7bf86e89280827fe84b5bebae4e501de7fea6bdf3471380)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication  
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Full round 63
            // Add round constants
            state0 := add(state0, 0x522338e1bf861c22cf8eeaa5d060db37420d3020e1713cf6fff6f239e30cbfa7)
            state1 := add(state1, 0x6fde059ef86c70e457aabb383afa5baf09088f95fd8322f957b618dd020277ff)
            state2 := add(state2, 0x13de705484874bb5e2abe4c518ce599eb64829e2d40e41bdd0c54ddeb26b86c0)
            
            // S-box all elements
            
            // S-box all elements
            
            {
                let intr := state0
                state0 := mulmod(intr, intr, PRIME)
                state0 := mulmod(state0, state0, PRIME)
                state0 := mulmod(state0, intr, PRIME)
            }
            
            {
                let intr := state1
                state1 := mulmod(intr, intr, PRIME)
                state1 := mulmod(state1, state1, PRIME)
                state1 := mulmod(state1, intr, PRIME)
            }
            
            {
                let intr := state2
                state2 := mulmod(intr, intr, PRIME)
                state2 := mulmod(state2, state2, PRIME)
                state2 := mulmod(state2, intr, PRIME)
            }
            
            // MDS matrix multiplication  
            
            {
                // MDS matrix multiplication (3x3)
                let t0 := mulmod(0x44d46fa01da5117cf3fbdba05adc0a64af6c34a56f1e3c6cba01b7a582af8839, state0, PRIME)
                t0 := addmod(t0, mulmod(0x3fe667e00c2b55cab44507505bba0e3a626e1ae605378c995a65a784ff14b250, state1, PRIME), PRIME)
                t0 := addmod(t0, mulmod(0x63ce26c4206c020d51deaa55ffd4bb75f2331516053550b2ab85fd269bd880d9, state2, PRIME), PRIME)
                
                let t1 := mulmod(0x42ef9cc13681afd5b00dec34395420d789050302f55bfdf81467c45c79019119, state0, PRIME)
                t1 := addmod(t1, mulmod(0x0e5584fa583dbae95ce13fb6befa8c6a8726033dc2ef49a2935a0c875e4e70b3, state1, PRIME), PRIME)
                t1 := addmod(t1, mulmod(0x5e8641d1c62a0c9d1d2fdb568dd5e25159d2f0c278522abe614e27d5df217a8d, state2, PRIME), PRIME)
                
                let t2 := mulmod(0x16582a527dd2eaa72fb34e6404e4c5a3778673b33370e0c1613548961eba050f, state0, PRIME)
                t2 := addmod(t2, mulmod(0x0b69c4e8a57aea1a6666cf14bbc5781c279d6386d13ffe4db266295b4d8f7953, state1, PRIME), PRIME)
                t2 := addmod(t2, mulmod(0x42d7e3dffaf0722a5079353abbcfb0458b44cad327804ef6780e71fe3a3d9a2a, state2, PRIME), PRIME)
                
                state0 := t0
                state1 := t1
                state2 := t2
            }

            // Return state[0] (matching poseidon2Direct)
            state0 := mod(state0, PRIME)
            mstore(0, state0)
            return (0, 32)
        }
    }
}