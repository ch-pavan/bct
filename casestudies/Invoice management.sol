pragma experimental ABIEncoderV2;
pragma solidity >=0.7.3;
contract invoiceContract {
uint public sellerCount;
uint public customerCount;
uint public itemCount;
uint public invoiceCount;
struct Customer {
uint customerId;
string name;
uint age;
string phoneNumber;
uint invoiceCount;
Invoice[] invoices;
}
struct Seller {
uint sellerId;
string name;
string sellerAddress;
string phoneNumber;
uint invoiceCount;
Invoice[] invoices;
}
struct Item {
uint itemId;
string name;
uint maximumRetailPrice;
uint tax;
uint totalCost;
}
struct Invoice {
uint invoiceId;
uint customerId;
uint sellerId;
string timestamp;
uint totalAmount;
uint invoiceItemCount;
InvoiceItem[] invoiceItems;
}
struct InvoiceItem {
uint itemId;
uint quantity;
uint cost;
}
event addItem(
uint itemId,
string name,
uint maximumRetailPrice,

7

uint tax,
uint totalCost
);
event addCustomer(
uint customerId,
string name,
uint age,
string phoneNumber
);
event addSeller(
uint sellerId,
string name,
string sellerAddress,
string phoneNumber
);
event addInvoice(
uint id,
uint customerId,
uint sellerId,
string timestamp
);
event addInvoiceItem(
uint id,
uint customerId,
uint sellerId
);
constructor() public {
sellerCount=0;
customerCount=0;
itemCount=0;
invoiceCount=0;
}
mapping (uint => Item) item;
mapping (uint => Customer) customer;
mapping (uint => Seller) seller;
mapping (uint => Invoice) invoice;
function setItem(string memory name,uint maximumRetailPrice, uint tax, uint totalCost) public {
itemCount++;
uint id = itemCount;
item[id].itemId=id;
item[id].name=name;
item[id].maximumRetailPrice=maximumRetailPrice;
item[id].tax=tax;
item[id].totalCost=totalCost;
emit addItem(id,name,maximumRetailPrice,tax,totalCost);
}
function setCustomer(string memory name,uint age,string memory phoneNumber) public {
customerCount++;
uint id = customerCount;

8

customer[id].customerId=id;
customer[id].name=name;
customer[id].age=age;
customer[id].phoneNumber=phoneNumber;
customer[id].invoiceCount=0;
emit addCustomer(id,name,age,phoneNumber);
}
function setSeller(string memory name,string memory sellerAddress,string memory phoneNumber)
public {
sellerCount++;
uint id = sellerCount;
seller[id].sellerId=id;
seller[id].name=name;
seller[id].sellerAddress=sellerAddress;
seller[id].phoneNumber=phoneNumber;
seller[id].invoiceCount=0;
emit addSeller(id,name,sellerAddress,phoneNumber);
}
function getItemCount() view public returns(uint) {
return (itemCount);
}
function getCustomerCount() view public returns(uint) {
return (customerCount);
}
function getSellerCount() view public returns(uint) {
return (sellerCount);
}
function getItem(uint id) view public returns (string memory,uint,uint,uint) {
return(item[id].name,item[id].maximumRetailPrice,item[id].tax,item[id].totalCost);
}
function getCustomer(uint id) view public returns (string memory,uint,string memory,uint,Invoice[]
memory) {
return(customer[id].name,customer[id].age,customer[id].phoneNumber,customer[id].invoiceC
ount,customer[id].invoices);
}
function getSeller(uint id) view public returns (string memory,string memory,string
memory,uint,Invoice[] memory) {
return(seller[id].name,seller[id].sellerAddress,seller[id].phoneNumber,seller[id].invoiceCount,s
eller[id].invoices);
}
function setInvoice(uint customerId,uint sellerId,string memory timestamp) public {
invoiceCount++;
uint id = invoiceCount;
invoice[id].invoiceId=id;
invoice[id].customerId=customerId;
invoice[id].sellerId=sellerId;

9

invoice[id].timestamp=timestamp;
invoice[id].totalAmount=0;
invoice[id].invoiceItemCount=0;
emit addInvoice(id,customerId,sellerId,timestamp);
}
function setInvoiceItem(uint invoiceId,uint itemId,uint quantity) public {
InvoiceItem memory temp;
temp.itemId=itemId;
temp.quantity=quantity;
temp.cost=quantity*item[itemId].totalCost;
invoice[invoiceId].invoiceItems.push(temp);
invoice[invoiceId].invoiceItemCount++;
invoice[invoiceId].totalAmount+=temp.cost;
emit addInvoiceItem(itemId,quantity,temp.cost);
}
function endInvoice(uint invoiceId,uint customerId,uint sellerId) public {
customer[customerId].invoices.push(invoice[invoiceId]);
customer[customerId].invoiceCount++;
seller[sellerId].invoices.push(invoice[invoiceId]);
seller[sellerId].invoiceCount++;
}
function getInvoice(uint id) view public returns (uint,uint,string memory,uint,uint,InvoiceItem[]
memory) {
return(invoice[id].customerId,invoice[id].sellerId,invoice[id].timestamp,invoice[id].totalAmount,i
nvoice[id].invoiceItemCount,invoice[id].invoiceItems);
}
}
