//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Issue.sol";

contract Project {
    
    uint256 public id;
    address public author;
    
    Issue[] public issues;
    IssueFactory private issueFactory;
    
    constructor(uint256 _id, address _author, IssueFactory _issueFactory) {
        id = _id;
        author = _author;
        issueFactory = _issueFactory;
    }
    
    function createIssue() public {
        issues.push(issueFactory.createIssue(author, this));
    }
}

contract ProjectFactory {
    
    uint256 public projectCounter;
    
    function createProject(address _author, IssueFactory _issueFactory) public returns (Project){
        return new Project(projectCounter++, _author, _issueFactory);
    }
}