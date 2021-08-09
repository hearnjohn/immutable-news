pragma solidity ^0.8.3;

contract StoryStorage {

    // mapping(uint => int[]) storyVotes; // Keep votes in an int array mapped by day
    mapping(uint => Story[]) stories;

    struct Story {
        uint id;
        string title;
        string body;
        bytes32 uploader;
        int netScore;
    }
    uint lastStoryId = 1;
    uint day = 1;
    
    function createStory(string memory _title, string memory _body, bytes32 _uploader) public {
        require(stories[day].length <= 25);
        stories[day].push(Story(lastStoryId++, _title, _body, _uploader, 0));
    }

    // Function will return the list of stories for the day
    // Off chain we will compute the ten best stories for the day and store them in a list
    // That list will be the input to another function that pushes the stories to Filecoin
    function newDay() internal returns (Story[] memory) {
        lastStoryId = 0;
        return stories[day++];
    }
    
    // This function will take in an input of the top 10 stories from the previous day and
    // replace the <= 25 stories currently stored in the stories global variable
    function pushStories(Story[] memory _stories) public {
        stories[day - 1] = _stories;
    }
}