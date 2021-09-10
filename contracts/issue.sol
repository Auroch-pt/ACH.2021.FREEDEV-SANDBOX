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
    
    function createIssue(uint256 _id, address _author, Project _project) public pure returns (Issue memory){
        return Issue(_id, _author, _project, Status.ACTIVE);
    }
}