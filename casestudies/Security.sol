// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing OpenZeppelin's SafeMath library to prevent integer overflow and underflow
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// Importing OpenZeppelin's Ownable contract to restrict access to certain functions
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureVault is Ownable {
    using SafeMath for uint256;

    // State variables
    mapping(address => uint256) private _balances;

    // Events
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Modifier to check the condition before executing the function
    modifier hasSufficientBalance(uint256 amount) {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send some ether");
        _balances[msg.sender] = _balances[msg.sender].add(msg.value);
        emit Deposited(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the contract
    function withdraw(uint256 amount) external hasSufficientBalance(amount) {
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Function to check the Ether balance of a user in the contract
    function balanceOf(address user) external view returns (uint256) {
        return _balances[user];
    }

    // Secure function to withdraw all funds from the contract, accessible only by the owner
    function emergencyWithdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
