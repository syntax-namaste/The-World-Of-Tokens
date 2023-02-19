// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import {ERC20} from "../ERC20.sol";

contract RektContract {
    ERC20 _someToken;

    constructor(address badToken_) {
        _someToken = ERC20(badToken_);
    }

    // this function simply gives back the player an amount of '_someTokens'
    // equivalent to the amount of ETH deposited.
    function play() external payable {
        _someToken.transfer(msg.sender, msg.value / 1 ether);
    }

    function getBadTokenBalanceOfContract() external view returns (uint256) {
        return _someToken.balanceOf(address(this));
    }
}
