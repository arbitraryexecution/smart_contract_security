//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge4 {
    event Winner(address);

    function callMe() external {
        require(block.number % 2 == 0, "Can only be called on an even block!");
        emit Winner(tx.origin);
    }
}
