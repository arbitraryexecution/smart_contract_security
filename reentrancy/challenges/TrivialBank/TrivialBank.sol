contract TrivialBank {
    mapping(address => uint) public balances;
    function withdraw(uint amount) external {
        require(balances[msg.sender] >= amount, "not enough money!");
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "couldn’t send eth!");
        unchecked { balances[msg.sender] -= amount; }
    }
    function deposit() payable external {
        balances[msg.sender] += msg.value;
    }
    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}

// CHALLENGE:
// - Deploy the TrivialBank contract
// - Make some deposits using your Remix wallet
// - Write a contract that robs the bank
// - You'll know when it works because the Bank's balance will be zero
//   and your exploit contract's balance will be larger :)

// CHALLENGE:
// - Once your exploit is working:
// - Apply the checks-effects-interaction pattern and confirm that it fails.
// - Do the same with a nonReentrant modifier.
