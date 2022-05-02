# Hero Calls

This repository is a set of contract puzzles intended to work on `call` and `delegatecall`. 

Each solidity file corresponds to a test file with the same index on it. Go through each contract and complete the TODOs to pass the test cases in order to complete all the challenges.

For the sake of the challenges, do not change anything about the test cases before getting them to pass. After you pass the test cases, you're welcome to change them how you'd like!

## Challenge 1: Sidekick Call

Open `contracts/Contracts1.sol` to check out this first challenge. Inside the `Sidekick` contract, you'll see a TODO to alert the hero. Complete this `call` to successfully call the Hero's `alert` function. 

When you have completed this TODO, run the tests with `npx hardhat test test/test1.js`. 

## Challenge 2: Ambush

Open `contracts/Contracts2.sol` for the second challenge. This time the `Sidekick` will need to alert the `Hero` of the number of enemies to expect and whether they are armed or not (oh no)! 

When you have completed this TODO, run the tests with `npx hardhat test test/test2.js`

## Challenge 3: Delegating

Open `contracts/Contracts3.sol` for the third challenge. Notice that both the `Sidekick` and `Behavior` are sharing a storage layout in the `Storage` contract. For this challenge, use the `recordAmbush` function of the `Behavior` contract to change storage inside of the sidekick. Ensure that only the headquarters can warn of this ambush, otherwise revert. 

When you have completed this TODO, run the tests with `npx hardhat test test/test3.js`

## Challenge 4: Supercharge

Open `contracts/Contracts4.sol` for the fourth challenge. There's an issue here. The `Hero` can be hacked and **lose ownership** of their contract! If you take a look at the test cases you can see that the villian is taking over the contract and calling `destroy` to `selfdestruct` it!

How is this happening? Can you spot the bug here and fix it so the Hero can still `superCharge` without being vulnerable? 

When you have completed this TODO, run the tests with `npx hardhat test test/test4.js`

## Challenge 5: BadFriend

Open `contracts/Contracts5.sol` for the fifth challenge. For this challenge, your goal is to help the bad friend in their malicious plan to stop the Hero from connecting to the good friend. If the `Behavior` contract sent a `delegatecall` into the `BadFriend` contract, what kind of damage could be done?

When you have completed this TODO, run the tests with `npx hardhat test test/test5.js`
