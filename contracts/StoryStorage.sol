pragma solidity ^0.8.3;

contract StoryStorage {
    
    mapping(uint => mapping(uint => Story)) stories;

    struct Story {
        uint id;
        string title;
        string body;
        string uploader;
        int netScore;
    }
    uint nextStoryId = 0;
    uint day = 0;
    
    function createStory(string memory _title, string memory _body, string memory _uploader) public {
        require(nextStoryId < 26);
        stories[day][nextStoryId] = Story(nextStoryId, _title, _body, _uploader, 0);
        ++nextStoryId;
    }

    // Function will return the list of stories for the day
    // Off chain we will compute the ten best stories for the day and store them in a list
    // That list will be the input to another function that pushes the stories to Filecoin
    function newDay() internal returns (Story[] memory) {
        nextStoryId = 0;
        Story[] memory dayStories;
        for (uint i = 0; i < 25; ++i) {
            dayStories[i] = stories[day][i];
        }
        day++;
        return dayStories;
    }
    
    // This function will take in an input of the top 10 stories from the previous day and
    // replace the <= 25 stories currently stored in the stories global variable
    function pushStories(Story[] memory _stories) public {
        for (uint i = 0; i < 10; ++i) {
            stories[day - 1][i] = _stories[i];
        }
    }
    
    // Need story getter function
}