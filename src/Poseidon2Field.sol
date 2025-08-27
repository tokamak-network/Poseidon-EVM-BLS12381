// SPDX-License-Identifier: MIT
pragma solidity >=0.8.8;

library Poseidon2Field {
    type Type is uint256;

    // BLS12-381 scalar Poseidon2Field 
    uint256 constant PRIME = 0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001;
    uint256 constant PRIME_DIV_2 = 0x39f6d3a994cea741999ce0405809a0d42a9da201ffff2dff7fffffff80000000;

    function checkField(Poseidon2Field.Type a) internal pure {
        require(Poseidon2Field.Type.unwrap(a) < PRIME, "Poseidon2Field: input is too large");
    }

    function toFieldUnchecked(uint256 a) internal pure returns (Poseidon2Field.Type b) {
        b = Poseidon2Field.Type.wrap(a);
    }

    function toField(uint256 a) internal pure returns (Poseidon2Field.Type b) {
        b = Poseidon2Field.Type.wrap(a);
        checkField(b);
    }

    function toFieldUnchecked(bytes32 a) internal pure returns (Poseidon2Field.Type b) {
        assembly {
            b := a
        }
    }

    function toField(bytes32 a) internal pure returns (Poseidon2Field.Type b) {
        assembly {
            b := a
        }
        checkField(b);
    }

    function toBytes32(Poseidon2Field.Type a) internal pure returns (bytes32 b) {
        assembly {
            b := a
        }
    }

    function toUint256(Poseidon2Field.Type a) internal pure returns (uint256 b) {
        assembly {
            b := a
        }
    }

    function toAddress(Poseidon2Field.Type a) internal pure returns (address b) {
        require(Poseidon2Field.Type.unwrap(a) < (1 << 160), "Poseidon2Field: input is too large");
        assembly {
            b := a
        }
    }

    function toArr(Poseidon2Field.Type a) internal pure returns (bytes32[] memory b) {
        b = new bytes32[](1);
        b[0] = toBytes32(a);
    }

    function toField(address a) internal pure returns (Poseidon2Field.Type b) {
        assembly {
            b := a
        }
    }

    function toField(int256 a) internal pure returns (Poseidon2Field.Type) {
        if (a < 0) {
            require(uint256(-a) < PRIME, "Poseidon2Field: input is too large");
            return Poseidon2Field.Type.wrap(PRIME - uint256(-a));
        } else {
            require(uint256(a) < PRIME, "Poseidon2Field: input is too large");
            return Poseidon2Field.Type.wrap(uint256(a));
        }
    }

    function into(Poseidon2Field.Type[] memory a) internal pure returns (bytes32[] memory b) {
        assembly {
            b := a
        }
    }

    function add(Poseidon2Field.Type a, Poseidon2Field.Type b) internal pure returns (Poseidon2Field.Type c) {
        assembly {
            c := addmod(a, b, PRIME)
        }
    }

    function mul(Poseidon2Field.Type a, Poseidon2Field.Type b) internal pure returns (Poseidon2Field.Type c) {
        assembly {
            c := mulmod(a, b, PRIME)
        }
    }

    function add(Poseidon2Field.Type a, uint256 b) internal pure returns (Poseidon2Field.Type c) {
        assembly {
            c := addmod(a, b, PRIME)
        }
    }

    function mul(Poseidon2Field.Type a, uint256 b) internal pure returns (Poseidon2Field.Type c) {
        assembly {
            c := mulmod(a, b, PRIME)
        }
    }

    function mulNoModulo(Poseidon2Field.Type a, Poseidon2Field.Type b) internal pure returns (Poseidon2Field.Type c) {
        // Multiply WITHOUT modulo to match TypeScript bug
        // WARNING: This can overflow and should only be used for compatibility
        assembly {
            c := mul(a, b)
        }
    }

    function mulNoModulo(Poseidon2Field.Type a, uint256 b) internal pure returns (Poseidon2Field.Type c) {
        // Multiply WITHOUT modulo to match TypeScript bug
        // WARNING: This can overflow and should only be used for compatibility
        assembly {
            c := mul(a, b)
        }
    }

    function pow(Poseidon2Field.Type a, uint256 exponential) internal pure returns (Poseidon2Field.Type c) {
        // Compute a^exponential mod PRIME
        assembly {
            c := 1
            let base := a
            let exponent := exponential

            for {} gt(exponent, 0) {} {
                if and(exponent, 1) { c := mulmod(c, base, PRIME) }
                base := mulmod(base, base, PRIME)
                exponent := shr(1, exponent)
            }
        }
    }

    function powNoModulo(Poseidon2Field.Type a, uint256 exponential) internal pure returns (Poseidon2Field.Type c) {
        // Compute a^exponential WITHOUT modulo to match TypeScript bug
        // WARNING: This can overflow and should only be used for compatibility
        assembly {
            c := 1
            let base := a
            let exponent := exponential

            for {} gt(exponent, 0) {} {
                if and(exponent, 1) { c := mul(c, base) }
                base := mul(base, base)
                exponent := shr(1, exponent)
            }
        }
    }

    function eq(Poseidon2Field.Type a, Poseidon2Field.Type b) internal pure returns (bool c) {
        assembly {
            c := eq(a, b)
        }
    }

    function isZero(Poseidon2Field.Type a) internal pure returns (bool c) {
        assembly {
            c := eq(a, 0)
        }
    }

    function signed(Poseidon2Field.Type a) internal pure returns (bool positive, uint256 scalar) {
        uint256 raw = Poseidon2Field.Type.unwrap(a);
        if (raw > PRIME_DIV_2) {
            return (false, PRIME - raw);
        } else {
            return (true, raw);
        }
    }
}