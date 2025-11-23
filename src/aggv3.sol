// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getEthPriceInUsd() internal view returns (uint256) {
        AggregatorV3Interface priceData = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );

        (, int256 price, , , ) = priceData.latestRoundData();

require(price > 0, "Invalid price");

        return uint256(price * 1e10);
    }

    function converterUsd(uint256 _ethamount) internal view returns (uint256) {
        uint256 price = getEthPriceInUsd();

        uint256 convert = (price * _ethamount) / 1e18;

        return convert;
    }
}
