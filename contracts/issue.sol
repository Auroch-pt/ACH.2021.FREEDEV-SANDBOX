//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Project.sol";
/*
contract Issue {
    //TODO: reduce the costs of this approach
    uint public id;
    address public author;
    Project public project;

    constructor(uint _id, address _author, Project _project){
        id = _id;
        author = _author;
        project = _project;
    }
}*/

struct Issue {
    uint256 id;
    address author;
    Project project;
}

contract IssueFactory {
    
    uint256 public issueCounter;
    
    function createIssue(address _author, Project _project) public returns (Issue memory){
        return Issue(issueCounter++, _author, _project);
    }
}