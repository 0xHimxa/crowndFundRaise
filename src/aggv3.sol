// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getEthPriceInUsd(AggregatorV3Interface _priceFeedAddress) internal view returns (uint256) {
        AggregatorV3Interface priceData = AggregatorV3Interface(
         _priceFeedAddress
        );

        (, int256 price, , , ) = priceData.latestRoundData();



        return uint256(price )* 1e10;
    }

    function converterUsd(uint256 _ethamount,AggregatorV3Interface _priceFeedAddress) internal view returns (uint256) {
        uint256 price = getEthPriceInUsd(_priceFeedAddress);

        uint256 convert = (price * _ethamount) / 1e18;

        return convert;
    }
}
