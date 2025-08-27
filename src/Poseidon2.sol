// SPDX-License-Identifier: MIT
pragma solidity >=0.8.8;

import {Poseidon2Field} from "./Poseidon2Field.sol";
import {Poseidon2Lib} from "./Poseidon2Lib.sol";

contract Poseidon2 {
    using Poseidon2Field for *;

    /**
     * Main poseidon2 function matching TypeScript implementation
     * Takes 2 inputs and returns first element of permutation
     */
    function poseidon2(Poseidon2Field.Type x, Poseidon2Field.Type y) public pure returns (Poseidon2Field.Type) {
        Poseidon2Field.Type[2] memory inputs;
        inputs[0] = x;
        inputs[1] = y;
        return Poseidon2Lib.poseidon2Direct(inputs);
    }

    /**
     * Convenience function for uint256 inputs
     */
    function poseidon2Uint256(uint256 x, uint256 y) public pure returns (uint256) {
        Poseidon2Field.Type result = poseidon2(Poseidon2Field.toField(x), Poseidon2Field.toField(y));
        return Poseidon2Field.toUint256(result);
    }

    /**
     * Alternative hash functions using sponge construction
     */
    function hash_1(Poseidon2Field.Type x) public pure returns (Poseidon2Field.Type) {
        return Poseidon2Lib.hash_1(x);
    }

    function hash_2(Poseidon2Field.Type x, Poseidon2Field.Type y) public pure returns (Poseidon2Field.Type) {
        return Poseidon2Lib.hash_2(x, y);
    }

    function hash(Poseidon2Field.Type[] memory input) public pure returns (Poseidon2Field.Type) {
        return Poseidon2Lib.hash(input, input.length, false);
    }

    function hash(Poseidon2Field.Type[] memory input, uint256 std_input_length, bool is_variable_length)
        public
        pure
        returns (Poseidon2Field.Type)
    {
        return Poseidon2Lib.hash(input, std_input_length, is_variable_length);
    }

    /**
     * Direct access to permutation for testing
     * Takes 3 elements and returns 3 elements
     */
    function permutation(Poseidon2Field.Type[3] memory inputs) public pure returns (Poseidon2Field.Type[3] memory) {
        Poseidon2Lib.Constants memory constants = Poseidon2Lib.load();
        return Poseidon2Lib.poseidonPermutation(
            inputs,
            8,  // rFull
            56, // rPartial
            constants.round_constants,
            constants.mds_matrix
        );
    }

    /**
     * Helper function to convert uint256 arrays to Poseidon2Field.Type arrays
     */
    function convertToFieldArray(uint256[] memory input) public pure returns (Poseidon2Field.Type[] memory) {
        Poseidon2Field.Type[] memory Poseidon2FieldArray = new Poseidon2Field.Type[](input.length);
        for (uint256 i = 0; i < input.length; i++) {
            Poseidon2FieldArray[i] = Poseidon2Field.toField(input[i]);
        }
        return Poseidon2FieldArray;
    }

    /**
     * Convenient function for testing with uint256 inputs
     */
    function hashUint256(uint256[] memory input) public pure returns (uint256) {
        Poseidon2Field.Type[] memory Poseidon2FieldInput = convertToFieldArray(input);
        Poseidon2Field.Type result = hash(Poseidon2FieldInput);
        return Poseidon2Field.toUint256(result);
    }

    /**
     * Test vectors for verification (you can add expected outputs from TypeScript)
     */
    function testVector1() public pure returns (uint256) {
        // poseidon2(1, 2) - add expected result from TypeScript
        return poseidon2Uint256(1, 2);
    }

    function testVector2() public pure returns (uint256) {
        // poseidon2(0, 0) - add expected result from TypeScript
        return poseidon2Uint256(0, 0);
    }
}