//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.5;

contract Storage {
    address public friend;
    address public behavior;
}

// In this example, Hero delegatecalls Behavior, which delegatecalls the GoodFriend
contract Hero is Storage {
    constructor(address _behavior, address _friend) {
        behavior = _behavior;
        (bool success, ) = behavior.delegatecall(abi.encodeWithSignature(
            "setFriend(address)", _friend
        ));
        require(success);
    }

    function sayHello() external {
        bytes memory payload = abi.encodeWithSignature("sayHello()");
        (bool success, ) = behavior.delegatecall(payload);
        require(success);
    }
}

contract Behavior is Storage {
    // This function has a vulnerability:
    // Anyone can call setFriend on the behavior directly
    // With this vulnerability, kind of damage can be done? 
    function setFriend(address _friend) external {
        friend = _friend;
    }

    function sayHello() external {
        bytes memory payload = abi.encodeWithSignature("sayHello()");
        (bool success, ) = friend.delegatecall(payload);
        require(success);
    }
}

contract GoodFriend {
    event Appreciated();

    function sayHello() external {
        emit Appreciated();
    }
}

// the Hero would never call this contract 
// but are we safe from the bad friend? 
contract BadFriend {
    function sayHello() external {
        selfdestruct(msg.sender);
    }
}