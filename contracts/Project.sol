//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Issue.sol";

contract Project {
    
    uint256 public id;
    address public author;
    
    mapping(uint256 => Issue) public issueMap;
    
    IssueFactory private issueFactory;
    mapping(address => bool) permissionMap;
    
    constructor(uint256 _id, address _author, IssueFactory _issueFactory) {
        id = _id;
        author = _author;
        issueFactory = _issueFactory;
    }
    
    function createIssue() public hasPermission {
        Issue memory issue = issueFactory.createIssue(msg.sender, this);
        issueMap[issue.id] = issue;
    }

    function updateIssueStatus(uint256 _issueId, Status _status) public hasPermission returns(bool success) {
        issueMap[_issueId].status = _status;
        return false;
    }
    
    function givePermission(address _allowed) public onlyAuthor{
        permissionMap[_allowed] = true;
    }
    
    function getIssueList(uint256 _numOfIssues) public view returns (Issue[] memory _issueList) {
        
        Issue[] memory issueList = new Issue[](_numOfIssues);
        
        for (uint256 i = 0; i < _numOfIssues; i++) {
            issueList[i] = (issueMap[i]);
        }
        
        return issueList;
    }
    
    function getActiveIssueList(uint256 _numOfIssues) public view returns (Issue[] memory _issueList) {

        Issue[] memory issueList = new Issue[](_numOfIssues);
        
        for (uint256 i = 0; i < _numOfIssues; i++) {
            
            if (issueMap[i].status == Status.ACTIVE) {
                issueList[i] = (issueMap[i]);
            }
        }
        
        return issueList;
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