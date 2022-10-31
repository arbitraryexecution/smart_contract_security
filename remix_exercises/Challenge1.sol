//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge1 {
    event Winner(address);

    function callMe() external {
        require(msg.sender != tx.origin, "Must be called from a contract!");
        emit Winner(tx.origin);
    }
}