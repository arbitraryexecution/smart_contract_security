//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Minion {
    function doWork(address[] calldata contracts,
                    bytes[] calldata operations) external {
        require(contracts.length == operations.length, "bad orders from emperor");
        for (uint i = 0 ; i < contracts.length; i++) {
            (bool ok,) = contracts[i].call(operations[i]);
            require(ok, "minion failed");
        }
    }
}

contract Emperor {
    Minion public minion;
    bool internal locked;
    mapping(address => uint) balances;

    modifier nonReentrant {
        if (msg.sender == address(minion)) {
            // allow minion to work for us
            _;
        } else {
            require(!locked, "reentrancy detected!");
            locked = true;
            _;
            locked = false;
        }
    }

    modifier onlyMinion {
        require(msg.sender == address(minion));
        _;
    }

    constructor() {
        minion = new Minion();
    }

    function withdraw(uint amount) external nonReentrant {
        address[] memory contracts = new address[](1);
        bytes[] memory operations = new bytes[](1);
        contracts[0] = address(this);
        operations[0] = abi.encodeWithSelector(
            this.doWithdraw.selector,
            msg.sender,
            amount
        );
        minion.doWork(contracts, operations);
    }

    function doWithdraw(address payable to, uint amount) external onlyMinion nonReentrant {
        require(balances[to] >= amount);
        (bool ok,) = to.call{value: balances[to]}("");
        require(ok, "withdraw failed");
        unchecked { balances[to] -= amount; }
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}


// CHALLENGE:
// - Deploy the Emperor contract
// - Make some deposits using your Remix wallet
// - Write a contract that steals all the funds

// CHALLENGE:
// Once your exploit is working:
// - Fix the contracts and confirm that your exploit no longer works
