// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VotingSystem {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(uint => Candidate) public candidates;
    uint[] private candidateIds;
    mapping(address => bool) public voters;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) public onlyOwner {
        uint _candidateId = candidateIds.length;
        candidates[_candidateId] = Candidate(_candidateId, _name, 0);
        candidateIds.push(_candidateId);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "Vous avez deja vote");
        require(_candidateId < candidateIds.length, "Id non valable");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount += 1;
    }

    function getCandidate(uint _candidateId) public view returns (Candidate memory) {
        require(_candidateId < candidateIds.length, "Id non valable");
        return candidates[_candidateId];
    }

    function totalCandidates() public view returns (uint) {
        return candidateIds.length;
    }

    function getCandidateIds() public view returns (uint[] memory) {
        return candidateIds;
    }
}