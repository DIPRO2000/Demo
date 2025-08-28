// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery
{
    address owner;
    address public winner;
    address[] public players;
    uint public fee;

    constructor(uint amount)
    {
        owner=msg.sender;
        fee=amount * 1 ether;
    }

    receive() external payable 
    { 
        require(owner!=msg.sender,"Owner Cannot Participate");

        require(msg.value == fee,"Exact Ether amount is not given");

        players.push(msg.sender);
    }

    modifier onlyOwner(address checker)
    {
        require(checker == owner,"Permission Denied.You are not the Admin.");
        _;
    }

    function getRandomNumber() internal view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.timestamp,block.prevrandao,players)));
    }

    function PickWinner() public  onlyOwner(msg.sender)
    {
        require(players.length >=3 ,"Cannot Pick Winner As Very Less Participants has joined");

        uint len=players.length;
        uint index=getRandomNumber() % len ;
        winner=players[index];

        payable(winner).transfer(address(this).balance);

        delete players; 
    }

    function ResetGame() public onlyOwner(msg.sender)
    {
        require(players.length>0,"No participants joined");

        for(uint i=0;i<players.length;i++)
        {
            payable(players[i]).transfer(fee);
        }

        delete players;
    }
    function TotalStake() public view returns(uint)
    {
        return address(this).balance;
    }

}