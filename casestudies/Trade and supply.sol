// SPDXLicenseIdentifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {

// Define the owner of the contract
address public owner;

// Define a product structure
	struct Product {
    	uint productId;
    	string name;
    	uint price;
    	ProductStatus status;
	}

	enum ProductStatus { Created, Shipped, Delivered }

// Mapping to track products
	mapping(uint => Product) public products;

// Event to log product creation
	event ProductCreated(uint productId, string name, uint price);

// Event to log product status change
	event ProductStatusChanged(uint productId, ProductStatus status);

	constructor() {
    	owner = msg.sender; // Set the contract creator as the owner
	}

// Create a new product
	function createProduct(uint _productId, string memory _name, uint _price) public {
    	require(msg.sender == owner, "Only the owner can create products");
    	require(products[_productId].productId == 0, "Product with this ID already exists");
   	 
    	products[_productId] = Product(_productId, _name, _price, ProductStatus.Created);
    	emit ProductCreated(_productId, _name, _price);
	}

// Ship a product
	function shipProduct(uint _productId) public {
    	require(msg.sender == owner, "Only the owner can change product status");
    	require(products[_productId].productId != 0, "Product with this ID does not exist");
    	require(products[_productId].status == ProductStatus.Created, "Product is not in 'Created' status");

    	products[_productId].status = ProductStatus.Shipped;
    	emit ProductStatusChanged(_productId, ProductStatus.Shipped);
	}

// Mark product as delivered
	function deliverProduct(uint _productId) public {
    	require(msg.sender == owner, "Only the owner can change product status");
    	require(products[_productId].productId != 0, "Product with this ID does not exist");
    	require(products[_productId].status == ProductStatus.Shipped, "Product is not in 'Shipped' status");

    	products[_productId].status = ProductStatus.Delivered;
    	emit ProductStatusChanged(_productId, ProductStatus.Delivered);
	}
}


