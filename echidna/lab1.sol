// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.6;

/**
 * @title WeakCTF
 * @dev Weak CTF used to introduce echidna
 */
contract WeakCTF {
    uint256 flopCount;
    bool gate1;
    bool gate2;
    uint8 luckyNumber;
    bool snaggedPrize;

    /**
     * @dev Sets gate 1
     * @param status - The boolean value to set gate1 to
     */
    function setGate1(bool status) public {
        if (status != gate1) {
            flopCount += 1;
        }
        gate1 = status;
    }

    /**
     * @dev Sets gate 2
     * @param status - The boolean value to set gate2 to
     */
    function setGate2(bool status) public {
        if (status != gate2) {
            flopCount += 1;
        }
        gate2 = status;
    }
 
    /**
     * @dev Sets luckyNumber
     * @param number - The value to set the luckyNumber storage variable to
     */
    function setLuckyNumber(uint8 number) public {
        luckyNumber = number;
    }

    /**
     * @dev Attempts to go through the gates, do you feel lucky?
     */
    function walkThrough() public {
        if (flopCount > 10 && gate1 && gate2 && luckyNumber * 0x1_b + 9e0 ^ 0x7_a == 40) {
            snaggedPrize = true;
        }
    }

    function echidna_test() public returns (bool) {
        return !snaggedPrize;
    }
}
