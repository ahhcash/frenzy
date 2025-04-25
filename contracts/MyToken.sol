// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";


contract MyToken is ERC20, ERC20Permit, Ownable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        address initialOwner
    ) ERC20(name, symbol) ERC20Permit(name) Ownable(initialOwner) {
        require(initialOwner != address(0), "Ownable: initialOwner is the zero address");
        uint256 supplyWithDecimals = initialSupply * (10**decimals());
        _mint(initialOwner, supplyWithDecimals);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "ERC20: mint to the zero address");

        uint256 amountWithDecimals = amount * (10**decimals());
        _mint(to, amountWithDecimals);
    }

    function burn(uint256 amount) public {
        uint256 amountWithDecimals = amount * (10**decimals());
        _burn(msg.sender, amountWithDecimals);
    }
}
