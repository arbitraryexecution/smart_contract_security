// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.6;

/**
 * @title ArrayUtil
 * @dev Utilities for uint256 arrays
 */
contract ArrayUtil {
    /**
     * @dev Search for the index of target in array starting from the beginning (left to right)
     * @param target - The element we are looking for in the array
     * @param array - The array which holds the elements to search
     */
    function indexOf(uint256 target, uint256[] calldata array) public pure returns (int256){
        require(array.length < 0xffffffffffffffff, "Array must not be larger than most positive int256");

        // start from the front and search to the end
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == target) {
                return int256(i);
            }
        }
        return -1;
    }

    /**
     * @dev Search for the index of target in array starting from the end (right to left)
     * @param target - The element we are looking for in the array
     * @param array - The array which holds the elements to search
     */
    function indexOfFromEnd(uint256 target, uint256[] calldata array) public pure returns (int256){
        require(array.length < 0xffffffffffffffff, "Array must not be larger than most positive int256");

        // start from end and search to the front
        for (uint256 i = array.length - 1; i >= 0; i++) {
            if (array[i] == target) {
                return int256(i);
            }
        }
        return -1;
    }

    /**
     * @dev Check if the array has any duplicate elements
     * @param array - The array we are checking for duplicates
     */
    function duplicates(uint256[] calldata array) public pure returns (bool){
        require(array.length < 0xffffffffffffffff, "Array must not be larger than most positive int256");

        // only have to check to 1 less since looking for duplicates
        for (uint256 i = 0; i < array.length - 1; i++) {
            for (uint256 j = i + 1; j < array.length - 1; j++) {
                if (array[i] == array[j]) {
                    return true;
                }
            }
        }
        return false;
    }

    /*
     * Imagine a bunch more array utility functions in the library implemented here
     */


    // *** ECHIDNA FUZZING BELOW ***
    bool mismatch = false;

    function testBehavior(uint256[] calldata array) public {
        bool indexDiff = false;

        for (uint256 i = 0; i < array.length; i++) {
            if (indexOf(i, array) != indexOfFromEnd(i, array)) {
                indexDiff = true;
                break;
            }
        }

        mismatch = duplicates(array) != indexDiff;
    }

    function echidna_test() public returns (bool){
        return mismatch == false;
    }
}
