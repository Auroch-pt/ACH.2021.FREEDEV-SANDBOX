//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Issue.sol";

contract Project {
    
    uint256 public id;
    address public author;
    
    Issue[] public issues;
    
    IssueFactory private issueFactory;
    mapping(address => bool) permissionMap;
    
    constructor(uint256 _id, address _author, IssueFactory _issueFactory) {
        id = _id;
        author = _author;
        issueFactory = _issueFactory;
    }
    
    function createIssue() public hasPermission {
        issues.push(issueFactory.createIssue(msg.sender, this));
    }

    function deleteIssue(uint256 _issueId) public hasPermission returns(bool success) {
        //TODO: Fix: this is behaving as a MAP
        
        for(uint256 i = 0; i < issues.length; i++) {
            if (issues[i].id == _issueId) {
                delete issues[id];
                return true;
            }
        }
        
        return false;
    }
    
    function givePermission(address _allowed) public onlyAuthor{
        permissionMap[_allowed] = true;
    }
    
    
    modifier onlyAuthor() {
        require (msg.sender == author);
        _;
    }
    
    modifier hasPermission(){
        require(msg.sender == author || permissionMap[msg.sender], "You lack permissions.");
        _;
    }
}

contract ProjectFactory {
    
    uint256 public projectCounter;
    
    function createProject(address _author, IssueFactory _issueFactory) public returns (Project){
        return new Project(projectCounter++, _author, _issueFactory);
    }
}