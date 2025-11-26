// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import{Script} from "forge-std/Script.sol";
import {RaiseFunds} from '../src/raise-fund.sol';
import {HelperConfig} from './helper.s.sol';
contract DeployRaiseFund is Script{



function run() external returns(RaiseFunds){

HelperConfig helperconfig = new HelperConfig();
(address pricefeed) = helperconfig.activeNetwork();

 vm.startBroadcast();
 RaiseFunds raisefund = new RaiseFunds(pricefeed);
 vm.stopBroadcast();

return raisefund;
}


}