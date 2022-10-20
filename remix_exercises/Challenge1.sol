//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface Challenge1 {
    function callMe() external;
}

contract Challenge1 {
    event Winner(address);

    function callMe() external {
	require(msg.sender != tx.origin);
	emit Winner(tx.origin);
    }
}
