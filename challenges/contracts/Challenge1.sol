//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Challenge1 {

    event Winner(address);
    constructor() {}

    function solveMe(uint guess) public {
        require(guess == 1234);
        emit Winner(msg.sender);
    }
    fallback() external {
        require(false, "Nope. Try again");
    }
}
