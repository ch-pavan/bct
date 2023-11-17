// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TradeFinanceContract {
    address public exporter;
    address public importer;
    uint public tradeAmount;
    bool public paymentComplete;

    event PaymentMade(uint amount);

    constructor(address _importer, uint _tradeAmount) {
        exporter = msg.sender;
        importer = _importer;
        tradeAmount = _tradeAmount;
        paymentComplete = false;
    }

    modifier onlyExporter() {
    require(msg.sender == exporter, "Only the exporter can call this function.");
    _;
    }

    modifier onlyImporter() {
    require(msg.sender == importer, "Only the importer can call this function.");
    _;
    }

    function makePayment() public onlyImporter payable {
    require(!paymentComplete, "Payment has already been made.");
    require(msg.value == tradeAmount, "Payment amount does not match the trade amount.");

    // Transfer the payment to the exporter.
    payable(exporter).transfer(msg.value);

    paymentComplete = true;

    emit PaymentMade(msg.value);    
    }
}
