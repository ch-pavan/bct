// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract RealEstateTransaction {
address public seller;
address public buyer;
uint256 public price;
bool public isTransactionComplete;
bool public isConfirmedByBuyer;
bool public isConfirmedBySeller;

event TransactionCompleted(address indexed seller, address indexed buyer,
uint256 price);
event Confirmation(address indexed user, bool isConfirmed);

constructor(address _seller, uint256 _price) {
seller = _seller;
buyer = msg.sender;
price = _price;
isTransactionComplete = false;
isConfirmedByBuyer = false;
isConfirmedBySeller = false;
}

modifier onlySeller() {
require(msg.sender == seller, "Only the seller can execute this.");
_;

}

modifier onlyBuyer() {
require(msg.sender == buyer, "Only the buyer can execute this.");
_;
}

function confirmTransaction() public {
require(msg.sender == buyer || msg.sender == seller, "Only the buyer or seller
can confirm.");

if (msg.sender == buyer) {
isConfirmedByBuyer = true;
} else {
isConfirmedBySeller = true;
}

emit Confirmation(msg.sender, true);

if (isConfirmedByBuyer && isConfirmedBySeller) {
isTransactionComplete = true;
emit TransactionCompleted(seller, buyer, price);
}
}
}
