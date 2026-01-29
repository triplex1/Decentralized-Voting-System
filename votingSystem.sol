// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;


contract votingSystem{
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    Candidate[] public candidates;

    //add candidate
    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

}