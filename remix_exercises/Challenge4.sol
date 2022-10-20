//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface Challenge4 {
    function callMe() external;
}

contract Challenge4 {
    event Winner(address);

    function callMe() external {
	require(block.number % 2 == 0);
	emit Winner(tx.origin);
    }
}
