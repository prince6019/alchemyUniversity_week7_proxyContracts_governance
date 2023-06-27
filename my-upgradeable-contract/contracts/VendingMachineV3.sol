// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV3 is Initializable {
    // these state variables and their values
    // will be preserved forever, regardless of upgrading
    uint public numSodas;
    address public owner;
    uint public numCookies;

    struct sodasNdCookies {
        uint sodas;
        uint cookies;
    }

    mapping(address => sodasNdCookies) public itemSold;

    function initialize(uint _numSodas, uint _numCookies) public initializer {
        numSodas = _numSodas;
        numCookies = _numCookies;
        owner = msg.sender;
    }

    function purchaseSoda() public payable {
        require(numSodas > 0);
        require(msg.value >= 1000 wei, "You must pay 1000 wei for a soda!");
        numSodas--;
        itemSold[msg.sender].sodas++;
        // challenge: add a mapping to keep track of user soda purchases!
    }

    function purchaseCookie() public payable {
        require(numCookies > 0);
        require(msg.value >= 3000 wei);
        numCookies--;
        itemSold[msg.sender].cookies++;
    }

    function withdrawProfits() public onlyOwner {
        require(
            address(this).balance > 0,
            "Profits must be greater than 0 in order to withdraw!"
        );
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }

    function setNewOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
}
