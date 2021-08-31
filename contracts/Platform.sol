//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FreedevToken.sol";
import "./Issue.sol";

contract Platform {
    
    IERC20 public token;
    Issue[] public issues;
    
    IssueFactory private issueFactory = new IssueFactory();
    
    constructor () {
        token = new FreedevToken(1000000);
    }
    
    function createIssue() public {
        issues.push(issueFactory.createIssue(msg.sender));   
    }
}