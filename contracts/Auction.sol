pragma solidity ^0.4.19;
contract Auction {
  address public manager;
  address public seller;
  uint public latestBid;
  address public latestBidder;
  string public sss;
 
  constructor() public {
    manager = msg.sender;
    sss="candidate1";
  }
 
  function auction(uint bid) public {
    latestBid = bid * 1 ether; //1000000000000000000;
    seller = msg.sender;
  }
 
  function bid() public payable {
    require(msg.value > latestBid);
 
    if (latestBidder != 0x0) {
      latestBidder.transfer(latestBid);
    }
    latestBidder = msg.sender;
    latestBid = msg.value;
  }
 
  function finishAuction() restricted public {
    seller.transfer(address(this).balance);
  }
 
  modifier restricted() {
    require(msg.sender == manager);
    _;
  }
}