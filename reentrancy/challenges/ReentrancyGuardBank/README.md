# ReentrancyGuardBank Challenge

If you want to remove the possibility of reentrancy completely, you can add a [re-entrancy guard](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.6.0/contracts/security/ReentrancyGuard.sol) to your function. While this prevents re-entering, it is still good practice to use the check-effects-interactions pattern as well!

**Your task**:

Fix the `withdraw()` function in the `ReentrancyGuardBank.sol` contract using a ReentrancyGuard to prevent the `ReentrancyGuardThief.sol` contract from withdrawing more ETH than the thief deposited.