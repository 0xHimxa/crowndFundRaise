// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {Script} from 'forge-std/Script.sol';
import {MockV3Aggregator} from '../test/mock/mockv3agg.sol';
contract HelperConfig is Script{

NetWorkActive public  activeNetwork;

struct NetWorkActive{
    address pricefeed;
}


constructor(){
    if(block.chainid == 11155111){
   activeNetwork = getSepoEthAddress();

    }
    else{
        activeNetwork = deployLocalMock();
    }
}



    function getSepoEthAddress() internal pure returns(NetWorkActive memory){

NetWorkActive memory prciefeedAddress = NetWorkActive({
    pricefeed:0x694AA1769357215DE4FAC081bf1f309aDC325306
});
        return prciefeedAddress ;
    }

    function deployLocalMock() internal returns( NetWorkActive memory){

vm.startBroadcast();
MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(8,3000e8);
vm.stopBroadcast();

NetWorkActive memory pricefeeds = NetWorkActive({
 pricefeed: address(mockV3Aggregator)   
});

return pricefeeds;

    }
}