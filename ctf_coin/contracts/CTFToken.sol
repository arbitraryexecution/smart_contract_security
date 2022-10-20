// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "hardhat/console.sol";

contract CTFToken is Initializable, ERC20Upgradeable, OwnableUpgradeable {

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
    address public levelFive;

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
        address _levelFour,
        address _levelFive
    ) public initializer {
        __ERC20_init(name, symbol);
        __Ownable_init();
        setLevelOneAddr(_levelOne);
        setLevelTwoAddr(_levelTwo);
        setLevelThreeAddr(_levelThree);
        setLevelFourAddr(_levelFour);
        setLevelFiveAddr(_levelFive);
    }

    modifier isValidLevel(address contractAddr) {
        require(levels[msg.sender].enabled, "Not a valid caller!");
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
        if (numWinners == 0) return 100;
        else if (numWinners == 1) return 85;
        else if (numWinners == 2) return 70;

        return 50;
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
    }

    function challengeFiveSolved(address winner)
        external
        isValidLevel(msg.sender)
        alreadyClaimed(winner)
    {
        require(msg.sender == levelFive, "Only the challenge can call this function!");

        uint256 amt = determineWinnings(levelFive);
        _mint(winner, amt);

        levelInfo storage l = levels[msg.sender];
        l.numWinners++;
        l.winners[winner] = true;
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

    function setLevelFiveAddr(address challenge) public onlyOwner {
        levelFive = challenge;
        levels[challenge].enabled = true;
    }
}
