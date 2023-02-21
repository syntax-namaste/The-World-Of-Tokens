// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

contract ReentrantToken is ERC777 {
    constructor(
        uint256 initialSupply
    ) ERC777("ReentrantToken", "REENT", new address[](0)) {
        console.log("sender ", msg.sender);
        _mint(msg.sender, initialSupply, "", "");
    }
}
