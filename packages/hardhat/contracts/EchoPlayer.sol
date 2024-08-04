//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract EchoPlayer {
    struct Session {
        uint256 startTime;
        uint256 endTime;
    }

    mapping(address => Session) public sessions;

    event StartListening (address _user, string _message, uint256 _at);
    event StopListening (address _user, string _message, uint256 _at);
    
    function startListening() public {
        sessions[msg.sender].startTime = block.timestamp;
        sessions[msg.sender].endTime = 0;

        emit StartListening(msg.sender, "Start listening", block.timestamp);
    }

    function stopListening() public {
        require(sessions[msg.sender].startTime != 0, "Listening session not started");
        sessions[msg.sender].endTime = block.timestamp;

        emit StopListening(msg.sender, "Stop listening", block.timestamp);
    }

    function getListeningDurationInSeconds(address user) public view returns (uint256) {
        require(sessions[user].endTime != 0, "Listening session not stopped");
        return sessions[user].endTime - sessions[user].startTime;
    }

    function getListeningDurationInMinutes(address user) public view returns (uint256) {
        uint256 durationInSeconds = getListeningDurationInSeconds(user);
        return durationInSeconds / 60;
    }
}
