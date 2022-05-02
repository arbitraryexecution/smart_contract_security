//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.5;

contract Storage {
    address headquarters;

    Ambush public ambush;

    struct Ambush {
        bool alerted;
        uint256 enemies;
        bool armed;
    }
}

contract Sidekick is Storage {
    address behavior;

    constructor(address _headquarters, address _behavior) {
        headquarters = _headquarters;
        behavior = _behavior;
    }

    function alert(uint256 enemies, bool armed) external {
        (bool success, ) = behavior.delegatecall(abi.encodeWithSignature("recordAmbush(uint256,bool)", enemies, armed));

        require(success);
    }
}

contract Behavior is Storage {
    function recordAmbush(uint256 enemies, bool armed) external {
        require(headquarters == msg.sender);

        ambush = Ambush(true, enemies, armed);
    }
}
