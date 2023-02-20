// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import {ERC20} from "../ERC20.sol";

contract ContractRektByReentrant {
    ERC20 _someToken;

    function assignToken(address reentryToken) external {
        _someToken = ERC20(reentryToken);
    }

    function getTokenBalance() public view returns (uint256) {
        return _someToken.balanceOf(address(this));
    }

    function hackFunc() external {
        require(getTokenBalance() >= 100 ether, "low balance");
        _someToken.transfer(msg.sender, 100 ether);
    }

}
