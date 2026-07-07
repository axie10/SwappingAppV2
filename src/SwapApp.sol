// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "./interfaces/IV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SwapApp {
    address public V2Router02Address;

    using SafeERC20 for IERC20;
    

    event SwapTokens(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);

    constructor(address V2Router02Address_) {
        V2Router02Address = V2Router02Address_;
    }

    function swapTokens(uint256 amountIn, uint256 amountOutMin, address[] memory path, uint256 deadline) external {

        IERC20(path[0]).safeTransferFrom(msg.sender, address(this), amountIn);
        IERC20(path[0]).approve(V2Router02Address, amountIn);

        uint256[] memory amounts = IV2Router02(V2Router02Address).swapExactTokensForTokens(amountIn, amountOutMin, path, msg.sender, deadline);

        emit SwapTokens(path[0], path[path.length - 1], amountIn, amounts[amounts.length - 1]);
    }
}

// 0x4752ba5dbc23f44d87826276bf6fd6b1c372ad24
