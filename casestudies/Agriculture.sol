// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;


contract RipeNegotiation {


    // The two parties involved in the negotiation
    address public party1;
    address public party2;


    // The terms of the negotiation
    uint256 public price;
    uint256 public quantity;
    string public deliveryDate;
    string public paymentTerms;


    // The status of the negotiation
    enum Status {
        Pending,
        Accepted,
        Rejected
    }
    Status public status;


    constructor(address _party1, address _party2) {
        party1 = _party1;
        party2 = _party2;
        status = Status.Pending;
    }


    // Party 1 can set the terms of the negotiation
    function setTerms(uint256 _price, uint256 _quantity, string memory _deliveryDate, string memory _paymentTerms) public {
        require(msg.sender == party1);
        price = _price;
        quantity = _quantity;
        deliveryDate = _deliveryDate;
        paymentTerms = _paymentTerms;
    }


    // Party 2 can accept or reject the terms of the negotiation
    function acceptTerms() public {
        require(msg.sender == party2);
        status = Status.Accepted;
    }


    function rejectTerms() public {
        require(msg.sender == party2);
        status = Status.Rejected;
    }


    // If the terms of the negotiation are accepted, the contract is executed
    function execute() public view{
        require(status == Status.Accepted);


        // TODO: Implement the execution of the contract, including
        // - Sending the agreed-upon price from party2 to party1
        // - Shipping the agreed-upon quantity of goods from party1 to party2
    }
}
