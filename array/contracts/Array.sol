// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;


contract Array {
    address public owner = msg.sender;
    bytes32[] public array;

    constructor () public payable {
    }

    function push(bytes32 _content) public {
        array.push(_content);
    }

    function pop() public {
        array.length--;
    }

    function edit(uint256 i, bytes32 _content) public {
        array[i] = _content;
    }

    function withdraw_all() only_owner public {
        (bool sent,) = owner.call.value(address(this).balance)("");
        require(sent, "Failed to send Ether");
    }

    modifier only_owner() {
        require(msg.sender == owner, "Must be owner to call");
        _;
    }
}
