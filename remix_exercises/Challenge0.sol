//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge0 {
    event Winner(address);

    function callMe() external payable {
        require(msg.value >= 0.1 ether, "This contract requires 0.1 ether!");
        emit Winner(msg.sender);
        payable(msg.sender).transfer(msg.value);
    }
}
