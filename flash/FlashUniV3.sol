// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import "@uniswap/v3-core/contracts/interfaces/callback/IUniswapV3FlashCallback.sol";
import "@uniswap/v3-core/contracts/libraries/LowGasSafeMath.sol";

import "@uniswap/v3-periphery/contracts/base/PeripheryPayments.sol";
import "@uniswap/v3-periphery/contracts/base/PeripheryImmutableState.sol";
import "@uniswap/v3-periphery/contracts/libraries/PoolAddress.sol";
import "@uniswap/v3-periphery/contracts/libraries/CallbackValidation.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

import "hardhat/console.sol";

contract FlashUniV3 is IUniswapV3FlashCallback, PeripheryImmutableState, PeripheryPayments {
    using LowGasSafeMath for uint256;
    using LowGasSafeMath for int256;
    uint24 public constant poolFee = 3000;
    address private constant _factory = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
    address private constant _router = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    address private constant _weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant _usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    ISwapRouter public immutable router = ISwapRouter(_router);

    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address payer;
        PoolAddress.PoolKey poolKey;
    }

    constructor() PeripheryImmutableState(_factory, _weth) { }

    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external override {
        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));
        CallbackValidation.verifyCallback(factory, decoded.poolKey);
        address token0 = decoded.poolKey.token0;
        address token1 = decoded.poolKey.token1;
        TransferHelper.safeApprove(token0, address(router), decoded.amount0);
        TransferHelper.safeApprove(token1, address(router), decoded.amount1);
        uint256 amount0Owed = LowGasSafeMath.add(decoded.amount0, fee0);
        uint256 amount1Owed = LowGasSafeMath.add(decoded.amount1, fee1);
        TransferHelper.safeApprove(token0, address(this), amount0Owed);
        TransferHelper.safeApprove(token1, address(this), amount1Owed);

        // your code here
        // e.g. pay back ether from contract using PeripheryPayments
        require(token1 == _weth);
        require(amount0Owed == 0);

        if (amount0Owed > 0)
            pay(token0, address(this), msg.sender, amount0Owed);
        if (amount1Owed > 0)
            pay(token1, address(this), msg.sender, amount1Owed);

        console.log("Flash Loan Success!");
    }

    function flashSwap(address token0, address token1, uint amount0, uint amount1) internal {
        PoolAddress.PoolKey memory poolKey = PoolAddress.PoolKey({
            token0: token0,
            token1: token1,
            fee: poolFee
        });
        IUniswapV3Pool pool = IUniswapV3Pool(PoolAddress.computeAddress(factory, poolKey));
        pool.flash(
            address(this),
            amount0,
            amount1,
            abi.encode(
                FlashCallbackData({
                    amount0: amount0,
                    amount1: amount1,
                    payer: msg.sender,
                    poolKey: poolKey
                })
            )
        );
    }

    function flashLoan(uint amount) external payable {
        flashSwap(_usdc, _weth, 0, amount);
    }
}
