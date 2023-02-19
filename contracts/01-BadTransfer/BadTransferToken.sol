// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ERC20} from "../ERC20.sol";

contract BadTransferToken is ERC20 {
    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_, 0, 200) {}

    // calling this transfer function drains all badTransfer tokens of the msg.sender
    function transfer(address to, uint256 amt) public override returns (bool) {
        while (_balances[msg.sender] >= amt) {
            super.transfer(to, amt);
        }

        return true;
    }

    // safe way to transfer tokens, with no hack involved
    function safeTransfer(address to, uint256 amt) public returns (bool) {
        return super.transfer(to, amt);
    }
}
