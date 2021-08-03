pragma solidity ^0.8.3;

import "./StoryStorage.sol";

contract UserStorage is StoryStorage {

    mapping (bytes32 => uint) usernames;
    mapping (address => User) addresses;

    struct User {
        uint id;
        bytes32 username;
        bytes32 country;
        uint membershipStart;
    }

    uint lastUserId = 0;

    function createUser(bytes32 _username, bytes32 _country) public payable {
        require(usernames[_username] == 0);
        require(addresses[msg.sender].id == 0);
        lastUserId++;
        usernames[_username] = lastUserId;
        addresses[msg.sender] = User(lastUserId, _username, _country, block.timestamp);
    }


    // Need to agree on upload fee, also not really sure how this is going to work.
    function uploadStory() public payable {
        
    }

    // Have the users cast their votes for the story here
    // We need to make sure that the web3 call keeps _vote from taking on a value other than 1 or -1
    function castVote(uint _storyId, int _vote) public {
        require(storyVotes[_storyId][msg.sender] == 0);
        stories[_storyId].netScore = (_vote == 1) ? stories[_storyId].netScore + 1 : stories[_storyId].netScore - 1;
        storyVotes[_storyId][msg.sender] = _vote;
    }

    function changeVote(uint _storyId, int _vote) public {
        require(storyVotes[_storyId][msg.sender] != 0);

        // Need to revert the net score of the story by subtracting the value of the last vote
        stories[_storyId].netScore = (storyVotes[_storyId][msg.sender] == 1) ?
                                      stories[_storyId].netScore - 1 :
                                      stories[_storyId].netScore + 1;

        // Need to adjust it for new vote value
        stories[_storyId].netScore = (_vote == 1) ?
                                      stories[_storyId].netScore + 1 :
                                      stories[_storyId].netScore - 1;
    }

    // User should be able to view story if their membership is active
    // *** Need to agree on a timeframe for membership. Week? Month? ***
    function viewStory() public view returns (bool) {
        return(86400 - (block.timestamp - addresses[msg.sender].membershipStart) > 0);
    }
}