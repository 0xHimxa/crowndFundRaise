// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {RaiseFunds} from "../src/raise-fund.sol";
import {Test, console} from "forge-std/Test.sol";

//create a getter function for state varaible wen done

contract TestRaiseFund is Test {
    RaiseFunds raiseFunds;
    address testOwner = makeAddr("owner");
    uint256 testAccountBalance = 30 ether;

    function setUp() external {
        vm.prank(testOwner);
        raiseFunds = new RaiseFunds();
        vm.deal(testOwner, testAccountBalance);
    }

    function testMinmumSendUsd() external view {
        assertEq(raiseFunds.MINIMUM_USD(), 2e18);
    }

    function testOwnerAddress() external view {
        assertEq(raiseFunds.I_OWNER(), testOwner);
        console.log(
            "here is the deployer",
            raiseFunds.I_OWNER(),
            "here is the other",
            testOwner
        );
    }

    function testCreateProject() external {
        vm.startPrank(testOwner);

        raiseFunds.createproject("asipita", 10000000000000000);
        vm.stopPrank();

        (
            string memory name,
            address owner,
            uint256 goal,
            uint256 totalRaised,
            bool isActive,
            bool isCompleted,
            bool isRefunded,
            bool exits
        ) = raiseFunds.getProjectInfo("asipita");
    assertEq(name,'asipita');
    assertEq(owner,testOwner);
     assertEq(goal,10000000000000000);
     assertEq(totalRaised,0);
     assertEq(isActive,true);
     assertEq(isCompleted,false);
     assertEq(isRefunded,false);
     assertEq(exits,true);






    }

    function testFundProjectFaild() external{

         vm.prank(testOwner);
raiseFunds.createproject("anabs", 10000000000000000);







 vm.prank(testOwner);
 //vm.expectRevert();

 raiseFunds.fundProject{value: 2e18}('anabs');
        console.log(address(raiseFunds).balance);




    }


    

}
