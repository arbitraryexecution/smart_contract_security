//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface Challenge0 {
    function callMe() external;
}

contract Challenge0 {
    event Winner(address);

    function callMe() external {
	emit Winner(msg.sender);
    }
}
