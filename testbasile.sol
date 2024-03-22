pragma solidity ^0.8.0;

contract VotingSystem {
    // Struct to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    // State variables
    mapping(uint => Candidate) public candidates;
    uint[] public candidateIds;
    mapping(address => bool) public voters;
    address public owner;
    
    // Constructor to set the owner
    constructor() {
        owner = msg.sender;
    }
    
    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this operation");
        _;
    }
    
    // Function to register a candidate
    function registerCandidate(uint _id, string memory _name) public onlyOwner {
        require(candidates[_id].id == 0, "Candidate with this ID already exists");
        
        Candidate memory newCandidate = Candidate(_id, _name, 0);
        candidates[_id] = newCandidate;
        candidateIds.push(_id);
    }
    
    // Function to vote for a candidate
    function vote(uint _candidateId) public {
        require(candidates[_candidateId].id != 0, "Candidate with this ID does not exist");
        require(!voters[msg.sender], "You have already voted");
        
        candidates[_candidateId].voteCount++;
        voters[msg.sender] = true;
    }
}