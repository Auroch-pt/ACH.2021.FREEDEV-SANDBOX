//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Issue.sol";

contract Project {
    
    uint256 public id;
    address public author;
    
    mapping(uint256 => Issue) public issueMap;
    uint256 counter;
    
    IssueFactory private issueFactory;
    mapping(address => bool) permissionMap;
    
    constructor(uint256 _id, address _author, IssueFactory _issueFactory) {
        id = _id;
        author = _author;
        issueFactory = _issueFactory;
    }
    
    function createIssue() public hasPermission returns (Issue memory _issue) {
        Issue memory issue = issueFactory.createIssue(counter++ ,msg.sender, this);
        issueMap[issue.id] = issue;
        return issue;
    }

    function updateIssueStatus(uint256 _issueId, Status _status) public hasPermission returns(bool success) {
        issueMap[_issueId].status = _status;
        return false;
    }
    
    function givePermission(address _allowed) public onlyAuthor{
        permissionMap[_allowed] = true;
    }
    
    function getIssueList() public view returns (Issue[] memory _issueList) {
        
        Issue[] memory issueList = new Issue[](counter);
        
        for (uint256 i = 0; i < issueList.length; i++) {
            issueList[i] = (issueMap[i]);
        }
        
        return issueList;
    }
    
    function getIssueList(uint256 _startingPoint, uint256 _numOfRequestedIssues) public view isWithinLimit(_startingPoint) returns (Issue[] memory _issueList) {
        
        //uint256 x = counter - _startingPoint > _numOfRequestedIssues;
        
        Issue[] memory issueList = new Issue[](setCounterAsLimit(_numOfRequestedIssues) - _startingPoint);

        for (uint256 i = _startingPoint; i <= issueList.length; i++) {
            issueList[i - _startingPoint] = (issueMap[i]);
        }
        
        return issueList;//indexes: 1, 2, 3, 4
    }
    
    function getActiveIssueList(uint256 _numOfRequestedIssues) public view returns (Issue[] memory _issueList){

        Issue[] memory issueList = new Issue[](setCounterAsLimit(_numOfRequestedIssues));
        
        for (uint256 i = 0; i < issueList.length; i++) {
            
            if (issueMap[i].status == Status.ACTIVE) {
                issueList[i] = (issueMap[i]);
            }
        }
        
        return issueList;
    }
    
    function setCounterAsLimit(uint256 _numOfRequestedIssues) private view returns (uint256) {
        return _numOfRequestedIssues > counter ? counter : _numOfRequestedIssues;
    }
    
    
    modifier isWithinLimit (uint256 _startingPoint) {
        require(_startingPoint <= counter, "Starting point is greater than the total issues.");
        _;
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