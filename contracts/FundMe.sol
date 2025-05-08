// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";


error NotOwner();
contract FundMe {

    using PriceConverter for uint256;

    // It is immutable because it is instantiated in the constructor and does not change
    address public immutable i_owner;

    // Marked as constant because its value does not change when it is set at run time
    uint256 public constant minimumUsd = 50 * 10e18;


    address[] public funders;
    mapping(address => uint256) addressAmountFunded;

    constructor() {
        i_owner = msg.sender;
    }

    // Get Funds from users
    function fund() public payable {
        // Getting the sender address
        address mySender = msg.sender;

        // Requiring minimum is always sent
        require(
            msg.value.getConversionRate() >= minimumUsd,
            "Didn't send enough!"
        );
        funders.push(mySender);

        // Updting mapping
        addressAmountFunded[mySender] = msg.value;
    }

    // Withdraw funds
    function withdraw() public onlyOwner {
        // Loop through with our starting index being uint256=>0, up to the funders.length
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            // Address of the funder
            address funder = funders[funderIndex];
            addressAmountFunded[funder] = 0;
        }

        // Reseting the funders
        funders = new address[](0);

        // Actual withdrawal

        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Send failed");
    }

    modifier onlyOwner(){
        // require(msg.sender == i_owner, "Only the owner can withdraw");
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        _;

    }


    // receive() <- at most once in a contract
    receive() external payable {
        fund();
     }

    // fallback()

    fallback() external payable { 
        fund();
    }


}
