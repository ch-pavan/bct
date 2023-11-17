// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract BorderSecurityContract {
    address public firstLineOfMilitary;
    address public secondLineOfMilitary;
    bool public isBorderCrossingDetected;
    string public operationProgress;


    struct SensorData {
        uint timestamp;
        string location;
        string sensorReadings;
    }


    SensorData public borderCrossingSensorData;


    event UnauthorizedBorderCrossingDetected(uint timestamp, string location, string action, string sensorReadings);
    event OperationProgressUpdated(uint timestamp, string progress);
    event NotificationSent(address indexed recipient, string message);


    constructor(address _firstLineOfMilitary, address _secondLineOfMilitary) {
        firstLineOfMilitary = _firstLineOfMilitary;
        secondLineOfMilitary = _secondLineOfMilitary;
        isBorderCrossingDetected = false;
        operationProgress = "Operation not yet initiated.";
    }


    function detectBorderCrossing(uint _timestamp, string memory _location, string memory _action, string memory _sensorReadings) public {
        require(!isBorderCrossingDetected, "Border crossing already detected.");


        isBorderCrossingDetected = true;
        borderCrossingSensorData = SensorData(_timestamp, _location, _sensorReadings);
        emit UnauthorizedBorderCrossingDetected(_timestamp, _location, _action, _sensorReadings);
        notifyMilitary("Unauthorized border crossing detected. Please take action.");
    }


    function updateOperationProgress(string memory _progress) public {
        require(isBorderCrossingDetected, "Border crossing must be detected first.");


        operationProgress = _progress;
        emit OperationProgressUpdated(block.timestamp, _progress);
    }


    function notifyMilitary(string memory message) internal {
        // Notify the first and second line of the military (in a real system, this could involve sending alerts).
        // For simplicity, we'll just log a message indicating notification.
        emit NotificationSent(firstLineOfMilitary, message);
        emit NotificationSent(secondLineOfMilitary, message);
    }
}


