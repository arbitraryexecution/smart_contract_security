//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.5;

contract Storage {
    address public owner;
    address public behavior;
    bool public isSuperCharged;
}

// TODO: ensure the Hero can still superCharge, but can't be hacked!
contract Hero is Storage {
    // on deployment, store the behavior address and initialize the owner
    constructor(address _owner, address _behavior) {
        behavior = _behavior;
        (bool success, ) = behavior.delegatecall(abi.encodeWithSignature(
            "initialize(address)", _owner
        ));

        require(success);
    }

    fallback() external {
        if(msg.data.length > 0) {
            // proxy to behavior methods
            (bool success, ) = behavior.delegatecall(msg.data);
            require(success);
        }
    }

    // when the world no longer needs a Hero
    function destroy() external {
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }
}

contract Behavior is Storage {
    // this function is called on contract deployment to set the owner
    function initialize(address _owner) external {
        owner = _owner;
    }

    function superCharge() external {
        isSuperCharged = true;
    }
}
