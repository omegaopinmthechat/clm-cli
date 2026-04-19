// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract CounterLab {
    uint256 public count;

    constructor(uint256 initialCount) {
        count = initialCount;
    }

    function increment() public {
        count += 1;
    }

    function setCount(uint256 nextCount) public {
        count = nextCount;
    }

    function readCount() public view returns (uint256) {
        return count;
    }
}

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    uint public candidatesCount;
    address public admin;

    constructor() {
        admin = msg.sender;

        addCandidate("Alice");
        addCandidate("Bob");
    }

    modifier onlyAdmin(){
        require(msg.sender == admin, "Only admin allowed");
        _;
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            0
        );
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }

    function getCandidate(uint _id) public view returns (string memory, uint) {
        Candidate memory c = candidates[_id];
        return (c.name, c.voteCount);
    }
}
