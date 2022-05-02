// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GreenFlag is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter public tokenIdCounter;
    bytes32 correctHash;

    constructor(bytes32 _correctHash) ERC721("GreenFlag", "MEANGREEN") {
        correctHash = _correctHash;
    }

    function mint(uint256 answer) isCorrect(answer) public returns(uint256) {
        uint256 tokenId = tokenIdCounter.current();
        tokenIdCounter.increment();
        _mint(tx.origin, tokenId);

        return tokenId;
    }

    modifier isCorrect(uint256 answer) {
        require(keccak256(abi.encode(answer)) == correctHash, "Wrong answer!");
        _;
    }
}