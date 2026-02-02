// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;


contract votingSystem{
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    mapping (address => bool) public hasVoted;
    Candidate[] public candidates;

    //add candidate
    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

    //vote function
    function vote(uint256 _candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");

        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

}