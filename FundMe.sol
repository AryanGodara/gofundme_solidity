// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 5e18;

    function fund() public payable {
        // Allow users to send $
        // Have a minimum $ sent
        // 1. How do we send ETH to this contract?
        require(msg.value > minimumUsd, "didn't send enough ETH"); //1e9 Wei = 1 ETH
        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
    }

    function getPrice() public view returns (uint256) {
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI: 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        return uint256(price*1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        // 1 ETH ? 
        // 2000_000000000000000
        uint256 ethPrice = getPrice();
        // (2000_000000000000000 * 1_000000000000000000) / 1e18
        // $2000 = 1 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // No decimals in solidity, prevent <1 divide
        return ethAmountInUsd;
    }

    // function withdraw() public {}
}