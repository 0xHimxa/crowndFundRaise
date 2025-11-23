// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import{Script} from "forge-std/Script.sol";
import {RaiseFunds} from '../src/raise-fund.sol';

contract DeployRaiseFund is Script{



function run() external{
 vm.startBroadcast();
 new RaiseFunds();
 vm.stopBroadcast();


}


}