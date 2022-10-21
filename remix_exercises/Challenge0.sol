//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge0 {
    event Winner(address);

    function callMe() external payable {
	require(msg.value >= 5 ether, "This contract requires 5 ether!");
	emit Winner(msg.sender);
    }
}
