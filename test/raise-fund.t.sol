// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {RaiseFunds} from "../src/raise-fund.sol";
import {Test, console} from "forge-std/Test.sol";
import { DeployRaiseFund} from '../script/raise-fund.s.sol';
//create a getter function for state varaible wen done

contract TestRaiseFund is Test {
    RaiseFunds raiseFunds;
    address testOwner = makeAddr("owner");
    uint256 testAccountBalance = 30 ether;

    function setUp() external {
  DeployRaiseFund  deployRaiseFund = new  DeployRaiseFund();

       // vm.prank(testOwner);
        (raiseFunds) = deployRaiseFund.run();
        vm.deal(testOwner, testAccountBalance);
    }

    function testMinmumSendUsd() external view {
        assertEq(raiseFunds.getMinimumUsd(), 2e18);
    }

    function testOwnerAddress() external view {
        assertEq(raiseFunds.I_OWNER(), msg.sender);
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

    function testFundProject() external{

         vm.prank(testOwner);
raiseFunds.createproject("anabs", 1000000000000000000);


 





 vm.prank(testOwner);

 raiseFunds.fundProject{value: 1 ether}('anabs');

       console.log(address(raiseFunds).balance);
assertEq(address(raiseFunds).balance,1 ether);



    }

 function testFasildFundProject() external{
         vm.prank(testOwner);
raiseFunds.createproject("anabs", 1000000000000000000);


 




vm.expectRevert();
 vm.prank(testOwner);
 raiseFunds.fundProject{value: 0.00001 ether}('anabs');

      



 }   


 function testVersion() external view{
    console.log(raiseFunds.getaggV());
    uint256 version = raiseFunds.getaggV();
    assertEq(version,4);

 }  



 function testWithdrawFunds() external{
 vm.prank(testOwner);
raiseFunds.createproject("anabs", 1000000000000000000);


 
vm.prank(testOwner);
 raiseFunds.fundProject{value: 2 ether}('anabs');




 vm.prank(testOwner);
 raiseFunds.withdrawFundRaised('anabs');

 assert(address(raiseFunds).balance != 2 ether);

 }



 function testWithdrawFundsfails() external{
 vm.prank(testOwner);
raiseFunds.createproject("anabs", 1000000000000000000);


 
vm.prank(testOwner);
 raiseFunds.fundProject{value: 2 ether}('anabs');




vm.expectRevert();
 vm.prank(address(1));
 raiseFunds.withdrawFundRaised('anabs');

 

 }



 function testFundersInfo() external{

vm.prank(testOwner);
raiseFunds.createproject("anabs", 1000000000000000000);


 
vm.prank(testOwner);
 raiseFunds.fundProject{value: 2 ether}('anabs');


 (address funderAdd, uint256 amount) = raiseFunds.getFundedAmount(0);

 assertEq(funderAdd,testOwner);
 assertEq(amount,2 ether);


 }


}
