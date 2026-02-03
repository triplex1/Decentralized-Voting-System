// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;
import "@openzeppelin/contracts/access/Ownable.sol";

contract VotingSystem is Ownable {
    constructor() Ownable(msg.sender) {}  // <-- Fix added here 

    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(address => bool) public hasVoted;
    mapping(string => bool) private _candidateNames;
    Candidate[] public candidates;

    event CandidateAdded(string name, uint256 index);
    event Voted(address voter, uint256 candidateIndex);

    function addCandidate(string memory _name) public onlyOwner {
        require(!_candidateNames[_name], "Candidate already exists");
        _candidateNames[_name] = true;
        candidates.push(Candidate(_name, 0));
        emit CandidateAdded(_name, candidates.length - 1);
    }

    function vote(uint256 _candidateIndex) public virtual {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate");
        candidates[_candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, _candidateIndex);
    }

    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }

    function leadingCandidate() public view returns (uint256) {
        uint256 maxVotes = 0;
        uint256 leadingIndex = 0;

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                leadingIndex = i;
            }
        }

        return leadingIndex;
    }
    }