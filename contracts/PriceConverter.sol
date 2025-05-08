// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() internal view returns (uint256) {
        // ABI

        // Address. 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);    
        ( ,int256 price, , , )  = priceFeed.latestRoundData();
        return uint256(price * 1e10); // ETH/USD price
    }        
        

    

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
        return priceFeed.version();
    }

    function getConversionRate(uint256 _ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (_ethAmount * ethPrice) / 1e18;
        return ethAmountInUSD;

    }

    
}