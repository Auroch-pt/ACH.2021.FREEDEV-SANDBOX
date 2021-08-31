//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FreedevToken is ERC20 ("FreeDEV", "FRDV") {
    
    constructor(uint256 initialSupply) {
        _mint(msg.sender, initialSupply);
    }
}