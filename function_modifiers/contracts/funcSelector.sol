//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Functions {
    address public owner;
    uint blockNumber = 1337;
    constructor() {
        owner = msg.sender;
    }

    function a(int num) public view returns (uint) {
        return 1;
    }

    function b(int num) public pure returns (uint) {
        return 2;
    }

    function c(int num) external view returns (uint) {
        return 3;
    }

    function d(int num) external pure returns (uint) {
        return 4;
    }

    function e(int num) internal pure returns (uint) {
        return 5;
    }

    function f(int num) internal view returns (uint) {
        return 6;
    }

    function g(int num) private pure returns (uint) {
        return 7;
    }

    function h(int num) private view returns (uint) {
        return 8;
    }

    function unused() internal returns (uint) {
        return 9;
    }

    function z() public payable returns (uint) {
        a(4919);
        b(4919);
        this.c(4919);
        this.d(4919);
        e(4919);
        f(4919);
        g(4919);
        g(4919);

        return 255;
    }
}
