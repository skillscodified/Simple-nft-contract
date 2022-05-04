//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';


contract SimpleContract is ERC721, Ownable {
 uint256 public Mintprice = 0.04 ether;
 uint256 public Totalsuppaly ;
 uint256 public MaxSuplly;
 bool public isMintEnable;
 mapping (address => uint ) public Mintdwallets;
  

  constructor () payable ERC721('Simple Mint','SIMPLEMINT'){
      MaxSuplly = 2;
  }

  function IsMintEnable() external onlyOwner{
               isMintEnable = !isMintEnable;

  }
  function SetMaxSupply (uint256 MaxSuplly_) external onlyOwner{
      MaxSuplly = MaxSuplly_;
  }

  function mint() external payable {
      require (isMintEnable,'Minting not Avlabile');
      require (Mintdwallets[msg.sender] > 1 , 'limit exussed per wallet');
      require (msg.value == Mintprice,'wrong price');
      require (MaxSuplly > Totalsuppaly,'Sold out');

      Mintdwallets[msg.sender]++;
      Totalsuppaly ++;
      uint256 TokenId = Totalsuppaly;
      _safeMint(msg.sender ,TokenId);


  }
}
