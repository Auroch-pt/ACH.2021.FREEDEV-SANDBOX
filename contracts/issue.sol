//SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract Issue {
    
    enum Category {CSS, HTML, NEW_FEATURE, BUG_FIX, REFACTOR, PERFORMANCE_IMPROV, TEST, AUDIT, ARCH_DESIGN }
    enum Field {BACKEND, FRONTEND, BLOCKCHAIN, SQL_DB, AI, BIG_DATA }
    enum Technology {JAVASCRIPT, TYPESCRIPT, NODE_JS, ANGULAR, REACT, SASS, JAVA, C_PLUS_PLUS, C_SHARP, T-SQL, MY-SQL, AWS};
    
    uint public id; //Maybe this should be the hash of the block plus the msg.sender, to generate a unique ID, or something similar.
    string public requirement;
    string public specifications;
    uint public points;
    uint public reward;
    
    Category public category;
    Field public field;
    Technology public technology;
}