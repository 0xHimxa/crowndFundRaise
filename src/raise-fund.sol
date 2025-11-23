// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
// be able to raise money 
// if target reached in USD withdraw
// if timer end and goal not reached refund Funders thier money 
// bolean that handle it state
 import {PriceConverter} from './aggv3.sol';


// Custom error definition for gas-efficient error handling
error IncreaseAmount(string _message);

contract RaiseFunds {
    address public immutable I_OWNER;


    constructor(){
        I_OWNER = payable ( msg.sender);
    }


    // Using a library for price conversions 
    using PriceConverter for uint256;

    // Minimum funding amount in USD (scaled to 18 decimals)
    uint256 public constant MINIMUM_USD = 2e18;

    // Mapping of project names to their fundraising info
    mapping (string projectname => FundRaiseInfo) public fundRaisingProjects;

   

    // Struct representing a funder and their contribution
    struct Funders {
        address funder;
        uint256 amount;
    }


     //funder test
    Funders[] public funderinfo;
    

    // Struct representing the details of a fundraising project
     struct  FundRaiseInfo {
        string name;                  // Project name
        address payable owner;        // Owner of the project
        uint256 goal;                 // Funding goal
        uint256 totalRaised;          // Total ETH raised so far
        bool isActive;                // True if project is currently accepting funds
        bool isCompleted;             // True if goal is reached
        bool isRefunded;  
        bool exits;         // True if funds were refunded
    }

    // Function to create a new fundraising project
    function createproject(string calldata _name, uint256 _goal) external {
        // Get storage reference for the project
        FundRaiseInfo storage project = fundRaisingProjects[_name];

        // Initialize project details
        project.name = _name;
        project.owner = payable(msg.sender);
        project.goal = _goal;
        project.isActive = true;
        project.isCompleted = false;
        project.isRefunded = false;
         project.exits = true;
        // Add the creator as the first funder with 0 contribution
      
       

        // Initialize total raised to 0
        project.totalRaised = 0;
    }

    // Function to fund a project
    function fundProject(string  calldata _name) public payable {
        // Check if sent ETH meets minimum USD requirement
        if (msg.value.converterUsd() < MINIMUM_USD) {
            revert IncreaseAmount('Sent ETH is below minimum requirement');
        }

        // Old require statement (commented out)
        // require(msg.value.converterUSD() > MINIMUM_USD,'please in crease money');

        // Logic to update project funding will go here (not implemented yet)
    FundRaiseInfo storage projectInfo = fundRaisingProjects[_name];
 

//this line  check if a project exits
   require(projectInfo.exits, "Project does not exist");


   require(projectInfo.isActive, "Project is not active");

    uint256 amount = msg.value;
    
    // Prevent overfunding
    

    // Record the fund
    projectInfo.totalRaised += amount;
    Funders memory funder = Funders({funder: msg.sender, amount: amount});
 
    funderinfo.push(funder);

    // Check if goal reached
    if(projectInfo.totalRaised >= projectInfo.goal){
        projectInfo.isCompleted = true;
        projectInfo.isActive = false;
    }
}




function withdrawFundRaised(string calldata _name) external {
    FundRaiseInfo storage projectInfo = fundRaisingProjects[_name];

    require(projectInfo.isCompleted, "Project is not completed");
 
    require(projectInfo.owner == msg.sender, "Only the project creator can withdraw funds");
    uint256 amount = projectInfo.goal;
    address owner = projectInfo.owner;
    uint256 payout = (amount * 98)/100;
    uint256 fee = amount -payout;
    (bool success,)=owner.call{value: payout}('');

     require( success, 'widthdrawal faild');
     (bool success1,)=I_OWNER.call{value:fee}('');

    require( success1, 'failde to send fee to owner');

    projectInfo.totalRaised = 0;
}



function getProjectInfo( string calldata _name) external view returns(FundRaiseInfo memory){
    FundRaiseInfo memory projectInfo = fundRaisingProjects[_name];
 return  projectInfo;

}


function getRaiseInfo() external pure returns (FundRaiseInfo memory){
    FundRaiseInfo memory fundRaiseInfo;
    return  fundRaiseInfo;
}


    }