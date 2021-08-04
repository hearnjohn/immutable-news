pragma solidity ^0.8.3;

contract StoryStorage {

    mapping(uint => mapping(address => int)) storyVotes;

    // We're gonna map the day to a mapping of stories by their storyId
    mapping(uint => mapping(uint => Story)) stories;

    struct Story {
        string url;
        bytes32 uploader;
        int netScore;
    }

    uint lastStoryId = 0;
    uint day = 1;
    
    function createStory(string memory _url, bytes32 _uploader) public {
        require(lastStoryId < 25);
        stories[day][++lastStoryId] = Story(_url, _uploader, 0);
    }

    // Function to put the day's top stories in storage and start the next day's process, increment the day variable
    function newDay() internal {
        ++day;
        lastStoryId = 0;
    }

    // Function to pay successful publishers, should only be called by resetStories() method
    // TODO: figure out what the payout will be. Does contract owner take a cut?
    // Also do we loop through the stories to pay everyone out? Very gas-intensive
    function payout() internal {

    }
}