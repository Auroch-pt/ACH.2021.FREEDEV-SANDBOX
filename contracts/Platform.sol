//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FreedevToken.sol";
import "./Project.sol";

contract Platform {
    
    IERC20 public token;
    Project[] public projects;

    ProjectFactory private projectFactory = new ProjectFactory();
    IssueFactory private issueFactory = new IssueFactory();

    constructor () {
        token = new FreedevToken(1000000);
    }
    
    function createProject() public {
        projects.push(projectFactory.createProject(msg.sender, issueFactory));   
    }
}