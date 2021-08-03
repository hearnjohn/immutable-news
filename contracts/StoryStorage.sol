pragma solidity ^0.8.3;

contract StoryStorage {

    mapping(uint => mapping(address => int)) storyVotes;
    mapping(uint => Story) stories;

    struct Story {
        uint id;
        int netScore;
    }

    uint lastStoryId = 0;
    
    function createStory() internal {
        require(lastStoryId < 25);
        lastStoryId++;
        stories[lastStoryId] = Story(lastStoryId, 0);
    }
}