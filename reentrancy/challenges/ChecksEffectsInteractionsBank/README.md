# ChecksEffectsInteractionsBank Challenge

The [Checks-Effects-Interactions](https://docs.soliditylang.org/en/v0.8.4/security-considerations.html#use-the-checks-effects-interactions-pattern) pattern is a commonly used pattern to ensure that condition checks are done first, storage changing effects are done second, and interactions with other contracts are done last. 

This bank example currently does not follow the pattern and it has a significant vulnerability.

**Your task**:

Fix the `withdraw()` function in the `ChecksEffectsInteractionsBank.sol` contract using the Checks-Effects-Interactions pattern to prevent the `ChecksEffectsInteractionsThief.sol` contract from withdrawing more ETH than the thief deposited.
