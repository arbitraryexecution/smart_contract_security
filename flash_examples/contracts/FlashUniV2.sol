// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.6.6;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Callee.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

import "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IWETH.sol";

import "hardhat/console.sol";

contract FlashUniV2 is IUniswapV2Callee {
    address private constant factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private constant router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    IWETH immutable WETH;
    IUniswapV2Pair immutable pair;

    constructor() public {
        address weth = IUniswapV2Router01(router).WETH();
        WETH = IWETH(weth);
        pair = IUniswapV2Pair(UniswapV2Library.pairFor(factory, usdc, weth));
    }

    function doFlashLoan(uint amount) external {
        pair.swap(0, amount, address(this), abi.encode(msg.sender));
    }

    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external override {
        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();
        assert(msg.sender == IUniswapV2Factory(factory).getPair(token0, token1));
        require(amount0 == 0);
        require(token1 == address(WETH));
        uint fee = (amount1 * 3) / 997 + 1;
        uint amountToRepay = amount1 + fee;
        // your code here
        // e.g: just mint weth fee from contract's balance
        WETH.deposit{value: fee}();
        IERC20(token1).transfer(msg.sender, amountToRepay);
        console.log("Flashloan Success!");
    }

    receive() external payable {}
}
