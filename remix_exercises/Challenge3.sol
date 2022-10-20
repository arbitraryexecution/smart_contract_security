//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface Challenge3 {
    function callMe(uint) external;
}

contract Challenge3 {
    event Winner(address);
    private uint secret;

    constructor(uint _secret) {
	secret = _secret;
    }

    function callMe(uint _secret) external {
	require(msg.sender != tx.origin);
	require(_secret == secret);
	emit Winner(tx.origin);
    }
}
