
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {RaiseFunds} from '../src/raise-fund.sol';
import {Test,console} from 'forge-std/Test.sol';


//create a getter function for state varaible wen done

contract TestRaiseFund is Test{

struct FundRaiseInfo {
        string name;                  // Project name
        address payable owner;        // Owner of the project
        uint256 goal;                 // Funding goal
        uint256 totalRaised;          // Total ETH raised so far
        bool isActive;                // True if project is currently accepting funds
        bool isCompleted;             // True if goal is reached
        bool isRefunded;  
        bool exits;         // True if funds were refunded
    }

RaiseFunds raiseFunds;
 address testOwner = makeAddr('owner');
 uint256 testAccountBalance = 2 ether;
function setUp() external{
    vm.prank(testOwner);
 raiseFunds = new RaiseFunds();
 vm.deal(testOwner, testAccountBalance);


}



function testMinmumSendUsd()external view{

    assertEq(raiseFunds.MINIMUM_USD(),2e18);
}


function testOwnerAddress() external view{

    assertEq(raiseFunds.I_OWNER(), testOwner);
    console.log('here is the deployer', raiseFunds.I_OWNER(),'here is the other', testOwner);
}


function testCreateProject() external{

 

 vm.startPrank(testOwner);

raiseFunds.createproject('asipita',10000000000000000);
 vm.stopPrank();



}





}