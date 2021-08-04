pragma solidity ^0.8.3;

import "./StoryStorage.sol";

contract UserStorage is StoryStorage {

    mapping (bytes32 => uint) usernames;
    mapping (address => User) addresses;
    
    struct User {
        uint id;
        bytes32 username;
        uint membershipStart;
    }

    uint lastUserId = 0;

    // *** Need to agree on a timeframe for membership. Week? Month? ***
    modifier activeMembership() {
        require(86400 - (block.timestamp - addresses[msg.sender].membershipStart) > 0);
        _;
    }

    function createUser(bytes32 _username) public payable {
        require(usernames[_username] == 0);
        require(addresses[msg.sender].id == 0);
        ++lastUserId;
        usernames[_username] = lastUserId;
        addresses[msg.sender] = User(lastUserId, _username, block.timestamp);
    }


    // Need to agree on upload fee, also is submission by link the best way to go about this?
    function uploadStory(string memory _url) public payable activeMembership() {
        createStory(_url, addresses[msg.sender].username);
    }
    
    // Have the users cast their votes for the story here
    // We need to make sure that the web3 call keeps _vote from taking on a value other than 1 or -1
    function castVote(uint _storyId, int _vote) public activeMembership() {
        require(storyVotes[_storyId][msg.sender] == 0);

        stories[day][_storyId].netScore = (_vote == 1) ? stories[day][_storyId].netScore + 1 :
                                                         stories[day][_storyId].netScore - 1;
        storyVotes[_storyId][msg.sender] = _vote;
    }

    function changeVote(uint _storyId, int _vote) public activeMembership() {
        require(storyVotes[_storyId][msg.sender] != 0);

        // Need to revert the net score of the story by subtracting the value of the last vote
        stories[day][_storyId].netScore = (storyVotes[_storyId][msg.sender] == 1) ?
                                      stories[day][_storyId].netScore - 1 :
                                      stories[day][_storyId].netScore + 1;
        // Need to adjust it for new vote value
        stories[day][_storyId].netScore = (_vote == 1) ?
                                      stories[day][_storyId].netScore + 1 :
                                      stories[day][_storyId].netScore - 1;
    }
}