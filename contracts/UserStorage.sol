pragma solidity ^0.8.3;

import "./StoryStorage.sol";

contract UserStorage is StoryStorage {

    mapping (string => uint) usernames;
    mapping (address => uint) addresses;
    mapping (uint => User) ids;
    mapping (uint => mapping(address => mapping(uint => int))) storyVotes;

    struct User {
        uint id;
        string username;
        uint membershipStart;
    }

    uint lastUserId = 0;

    // *** Need to agree on a timeframe for membership. Week? Month? ***
    modifier activeMembership() {
        require(2592000 - (block.timestamp - ids[addresses[msg.sender]].membershipStart) > 0);
        _;
    }

    function createUser(string memory _username) public payable {
        require(usernames[_username] == 0);
        require(addresses[msg.sender] == 0);
        require(msg.value == 0.005 ether, "A 30-day membership costs 0.005 ether!");
        ++lastUserId;
        usernames[_username] = lastUserId;
        addresses[msg.sender] = lastUserId;
        ids[lastUserId] = User(lastUserId, _username, block.timestamp);
    }

    // Need to agree on upload fee, also is submission by link the best way to go about this?
    function uploadStory(string memory _title, string memory _body) public payable activeMembership() {
        require(msg.value == .01 ether, "Uploading a story costs 0.01 ether!");
        createStory(_title, _body, ids[addresses[msg.sender]].username);
    }
    
    // Have the users cast their votes for the story here
    // We need to make sure that the web3 call keeps _vote from taking on a value other than 1 or -1
    function castVote(uint _storyId, int _vote) public activeMembership() {
        require(storyVotes[day][msg.sender][_storyId] == 0 && _storyId < nextStoryId);

        stories[day][_storyId].netScore = (_vote == 1) ? stories[day][_storyId].netScore + 1 :
                                                         stories[day][_storyId].netScore - 1;
        storyVotes[day][msg.sender][_storyId] = _vote;
    }

    function changeVote(uint _storyId, int _vote) public activeMembership() {
        require(storyVotes[day][msg.sender][_storyId] != 0);

        // Need to revert the net score of the story by subtracting the value of the last vote
        stories[day][_storyId].netScore = (storyVotes[day][msg.sender][_storyId] == 1) ?
                                      stories[day][_storyId].netScore - 1 :
                                      stories[day][_storyId].netScore + 1;
        // Need to adjust it for new vote value
        stories[day][_storyId].netScore = (_vote == 1) ?
                                      stories[day][_storyId].netScore + 1 :
                                      stories[day][_storyId].netScore - 1;
    }

    // The user will be responsible for claiming the payout once their story has been scored
    // Can't claim reward for story until the day is over
    function payout(uint _day, uint _storyId) public payable {
        require(keccak256(bytes(ids[addresses[msg.sender]].username)) == keccak256(bytes(stories[_day][_storyId].uploader)));
        if (stories[_day][_storyId].netScore > 0 && address(this).balance >= .015 ether) {
            stories[_day][_storyId].netScore = -1;
            payable(msg.sender).transfer(.015 ether);
        }
    }
}