//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Project.sol";

struct Issue {
    uint256 id;
    address author;
    Project project;
    Status status;
}

enum Status {ACTIVE, COMPLETE, CANCELLED}

contract IssueFactory {
    
    uint256 public issueCounter;
    
    function createIssue(address _author, Project _project) public returns (Issue memory){
        return Issue(issueCounter++, _author, _project, Status.ACTIVE);
    }
}