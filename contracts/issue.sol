//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Issue {
    
    uint public id;
    address public author;

    constructor(uint _id, address _author){
        id = _id;
        author = _author;
    }
}

contract IssueFactory {
    
    uint256 public issueCounter;
    
    function createIssue(address _author) public returns (Issue){
        return new Issue(issueCounter++, _author);
    }
}