// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract StudentCertification {
    struct Certification {
        string studentName;
        string certificateHash; // You can store the certificate on IPFS or another decentralized storage and store the hash here.
        uint256 timestamp;
    }
    Certification[] public certifications;
    address public coordinator;
    modifier onlyCoordinator() {
        require(msg.sender == coordinator, "Only the coordinator can perform this operation.");
        _;
    }
    constructor() {
        coordinator = msg.sender;
    }
    function addCertification(string memory _studentName, string memory
    _certificateHash) public onlyCoordinator {
        uint256 timestamp = block.timestamp;
        Certification memory newCertification = Certification(_studentName,
        _certificateHash, timestamp);
        certifications.push(newCertification);
    }
    function getCertificationCount() public view returns (uint256) {
        return certifications.length;
    }
}