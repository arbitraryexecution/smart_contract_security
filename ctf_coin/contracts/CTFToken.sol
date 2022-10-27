// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";

contract CTFToken is ERC20BurnableUpgradeable, OwnableUpgradeable {

    event ChallengeSolved(address indexed winner, uint256 indexed levelNum);

    struct levelInfo {
        bool enabled;
        uint256 numWinners;
        mapping(address => bool) winners;
    }

    mapping(address => levelInfo) public levels;

    address public levelOne;
    address public levelTwo;
    address public levelThree;
    address public levelFour;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        string memory name,
        string memory symbol,
        address _levelOne,
        address _levelTwo,
        address _levelThree,
        address _levelFour
    ) public initializer {
        __ERC20_init(name, symbol);
        __Ownable_init();
        setLevelOneAddr(_levelOne);
        setLevelTwoAddr(_levelTwo);
        setLevelThreeAddr(_levelThree);
        setLevelFourAddr(_levelFour);
    }

    modifier isValidLevel(address contractAddr) {
        require(levels[contractAddr].enabled, "Not a valid caller!");
        _;
    }

    modifier alreadyClaimed(address winner) {
        require(levels[msg.sender].winners[winner] == false, "Already claimed!");
        _;
    }

    function solvedChallenge(address challengeAddr, address player) external view returns (bool) {
        return levels[challengeAddr].winners[player];
    }

    function determineWinnings(address challengeAddr) public view returns (uint256 amt) {
        // Proper operation of this function requires that this function preceeds adding a winner
        uint256 numWinners = levels[challengeAddr].numWinners;

        // First winner should receive 100 tokens
        // Second winner should receive 85 tokens
        // Third winner should receive 70 tokens
        // Any other winners should receive 50 tokens
        if (numWinners == 0) amt = 100;
        else if (numWinners == 1) amt = 85;
        else if (numWinners == 2) amt = 70;
        else amt = 50;
    }

    function challengeOneSolved(address winner)
        external
        isValidLevel(msg.sender)
        alreadyClaimed(winner)
    {
        require(msg.sender == levelOne, "Only the challenge can call this function!");

        uint256 amt = determineWinnings(levelOne);
        _mint(winner, amt);

        levelInfo storage l = levels[msg.sender];
        l.numWinners++;
        l.winners[winner] = true;

        emit ChallengeSolved(winner, 1);
    }

    function challengeTwoSolved(address winner)
        external
        isValidLevel(msg.sender)
        alreadyClaimed(winner)
    {
        require(msg.sender == levelTwo, "Only the challenge can call this function!");

        uint256 amt = determineWinnings(levelTwo);
        _mint(winner, amt);

        levelInfo storage l = levels[msg.sender];
        l.numWinners++;
        l.winners[winner] = true;

        emit ChallengeSolved(winner, 2);
    }

    function challengeThreeSolved(address winner)
        external
        isValidLevel(msg.sender)
        alreadyClaimed(winner)
    {
        require(msg.sender == levelThree, "Only the challenge can call this function!");

        uint256 amt = determineWinnings(levelThree);
        _mint(winner, amt);

        levelInfo storage l = levels[msg.sender];
        l.numWinners++;
        l.winners[winner] = true;

        emit ChallengeSolved(winner, 3);
    }

    function challengeFourSolved(address winner)
        external
        isValidLevel(msg.sender)
        alreadyClaimed(winner)
    {
        require(msg.sender == levelFour, "Only the challenge can call this function!");

        uint256 amt = determineWinnings(levelFour);
        _mint(winner, amt);

        levelInfo storage l = levels[msg.sender];
        l.numWinners++;
        l.winners[winner] = true;

        emit ChallengeSolved(winner, 4);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function setLevelOneAddr(address challenge) public onlyOwner {
        levelOne = challenge;
        levels[challenge].enabled = true;
    }

    function setLevelTwoAddr(address challenge) public onlyOwner {
        levelTwo = challenge;
        levels[challenge].enabled = true;
    }

    function setLevelThreeAddr(address challenge) public onlyOwner {
        levelThree = challenge;
        levels[challenge].enabled = true;
    }

    function setLevelFourAddr(address challenge) public onlyOwner {
        levelFour = challenge;
        levels[challenge].enabled = true;
    }
}
