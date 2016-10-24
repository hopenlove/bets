pragma solidity ^0.4.1;
contract letsPlayV4{
    
    string public playerName;
    uint public betAmount;
    
    uint public recordId;
    
    struct Bookie{
        string bettorName;
        string bettorEmail;
        string assetName;
        mapping(address =>Bet) bets; 
        //Bets [] public bets;
    }
    
    struct Bet{
        uint uniqueId;
        uint startTime;
        uint endTime;
        uint depositAmount;
        address challenger;
    }
    
    function letsPlayV4 (){
        recordId =0;
    }
    
    //mapping (address => uint256) public beneficiary;
    
    //mapping (address => Bet) public bets;
    
    mapping  (address => Bookie) public bookies;
    
    //Bookie [] public bookies;
    
    event gotDeposit(address player, uint startTime);

    function takeDeposit (
        string _bettorName,
        string _bettorEmail,
        string _assetName,
        uint _uniqueId,
        uint _startTime,
        uint _endTime,
        uint _depositAmount,
        address _challenger)
        {
        bool foundRecord = false;
        Bookie bookie = bookies[msg.sender];
        
        //address bookieAddress  =  getMyBet(bookie , _uniqueId) ;
        address betAddress  =  getMyBet(bookie , _uniqueId) ;
        
        Bet myBet = bookie.bets[betAddress];
            /*myBet.bettorName = _bettorName;
            myBet.bettorEmail= _bettorEmail;
            myBet.assetName = _assetName;
            myBet.uniqueId = recordId++;
            myBet.startTime = _startTime;
            myBet.endTime = _endTime;
            myBet.depositAmount = _depositAmount ; //msg.value;
            //myBet.challenger = _challenger;*/
            gotDeposit(msg.sender, _startTime);
        
    }
    
    function getMyBet(Bookie bookie, uint _uniqueId) internal
    returns (address) // , bool)
    {
        //Bookie bookie2 = bookies [msg.sender];
        address betsList  = bookie.bets;
        for (uint i = 0; i < betsList.length; i++) {
            if (betsList[i].uniqueId = _uniqueId){
              return (betsList[i]); //, true);
            }
        }
    }
    
    function showBetRecordsFor (address _player)
    returns (string betString) 
    {
        //string betString ;
        /*Bet myBet  = bets[_player];
        
        betString = myBet.bettorName ;
                    // "bettorEmail: "+ myBet.bettorEmail;
        
        playerName=betString;
        betAmount = myBet.depositAmount ;
        return betString;
        */
        /*assetName: _assetName,
        uniqueId: _uniqueId,
        startTime: _startTime,
        endTime: _endTime,
        depositAmount: msg.value,
        challenger:*/
        //Bet myBet = bets[_player];
    }
    
}

