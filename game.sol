// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Game {
    address Owner;
    uint public bet;
    address[] public  players;
    mapping(address=>bool) public haswon;
    event NewPlayer(address player);
    event PlayGame(address player,uint256 value, bool hasWon);
    constructor() {
        Owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == Owner,"only owner can set a bet");
        _;
    }
    function setbet(uint betnum)public onlyOwner{
        bet  = betnum;
    }
    function play(uint guess) public  returns (bool){
        if (isnewgamer()){
            emit NewPlayer(msg.sender);
        }
        
        if (bet == guess){
            haswon[msg.sender]= true;
            emit PlayGame(msg.sender,guess,haswon[msg.sender]);
            return true;
        }else{
            haswon[msg.sender]=false;
            emit PlayGame(msg.sender,guess,haswon[msg.sender]);
            return false;
        }
    }
    function isnewgamer() public   returns (bool){
           for(uint i = 0;i<players.length;i++){
            if(players[i]==msg.sender){
                return false;
            }
        }
        players.push(msg.sender);
        return true;
        
    }

}
