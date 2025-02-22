// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FederatedLearningRewards {
    address public owner;
    uint256 public totalContributionScore;  // Sum of all contributions in current round
    uint256 public totalRewardPool;         // Reward pool available for distribution

    struct Participant {
        bool consentGiven;
        uint256 contributionScore;  // Accumulated performance score
        uint256 reward;             // Reward available to claim
        bool exists;
    }

    mapping(address => Participant) public participants;
    address[] public participantAddresses;  // To allow iteration over participants

    // Events to log contract activity
    event ConsentGiven(address indexed participant);
    event ConsentRevoked(address indexed participant);
    event UpdateSubmitted(address indexed participant, uint256 score);
    event RewardsDistributed(uint256 totalRewardPool);
    event RewardClaimed(address indexed participant, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Participant gives consent to contribute
    function giveConsent() public {
        if (!participants[msg.sender].exists) {
            participants[msg.sender] = Participant({
                consentGiven: true,
                contributionScore: 0,
                reward: 0,
                exists: true
            });
            participantAddresses.push(msg.sender);
        } else {
            require(!participants[msg.sender].consentGiven, "Consent already given");
            participants[msg.sender].consentGiven = true;
        }
        emit ConsentGiven(msg.sender);
    }

    // Participant can revoke consent
    function revokeConsent() public {
        require(participants[msg.sender].exists, "Participant not found");
        require(participants[msg.sender].consentGiven, "Consent already revoked");
        participants[msg.sender].consentGiven = false;
        emit ConsentRevoked(msg.sender);
    }

    // Participant submits a model update performance score
    // Here, score is scaled to an integer
    function submitUpdate(uint256 score) public {
        require(participants[msg.sender].exists, "Consent not given");
        require(participants[msg.sender].consentGiven, "Consent not given");
        participants[msg.sender].contributionScore += score;
        totalContributionScore += score;
        emit UpdateSubmitted(msg.sender, score);
    }

    // Owner deposits funds to create a reward pool (e.g., in wei)
    function depositRewardPool() public payable onlyOwner {
        totalRewardPool += msg.value;
    }

    // Distribute rewards proportionally based on contribution score
    // Only participants who gave consent and contributed will receive rewards.
    function distributeRewards() public onlyOwner {
        require(totalContributionScore > 0, "No contributions submitted");
        for (uint i = 0; i < participantAddresses.length; i++) {
            address participantAddr = participantAddresses[i];
            Participant storage participant = participants[participantAddr];
            if (participant.consentGiven && participant.contributionScore > 0) {
                uint256 rewardAmount = (totalRewardPool * participant.contributionScore) / totalContributionScore;
                participant.reward += rewardAmount;
            }
        }
        emit RewardsDistributed(totalRewardPool);
        // Reset for next round
        totalRewardPool = 0;
        totalContributionScore = 0;
    }

    // Participant claims their reward
    function claimReward() public {
        Participant storage participant = participants[msg.sender];
        uint256 rewardAmount = participant.reward;
        require(rewardAmount > 0, "No reward to claim");
        participant.reward = 0;
        payable(msg.sender).transfer(rewardAmount);
        emit RewardClaimed(msg.sender, rewardAmount);
    }
}
