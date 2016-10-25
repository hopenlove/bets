pragma solidity ^0.4.1;
contract letsPlayV5{
    
    string public playerName;
    string public challengerName;
    uint public betAmount;
    uint public recordId;
    
    struct BetInfo{
        uint uniqueId;
        uint startTime;
        uint endTime;
        uint depositAmount;
        //address challenger;
    }
    
    struct Player{
        string playerName;
        string playerEmail;
        string assetName;
        uint uniqueId;
        bool bettor;
        //mapping(uint =>Bet) bets; 
        //Bets [] public bets;
    }
    
    struct BetRecord{
         BetInfo betDetails;
         Player player1;
         Player player2;
    }
    
    uint betNumber;
    mapping (uint => BetRecord) bets;
    
    function letsPlayV4 (){
        recordId =0;
    }
    
    event gotDeposit(address player, uint startTime);

    function takeDeposit (
        string _bettorName,
        string _bettorEmail,
        string _assetName,
        uint _uniqueId,
        uint _startTime,
        uint _endTime,
        uint _depositAmount)
    {
       recordId = _uniqueId;
       BetInfo memory betDetails;
       Player memory player;
       Player memory challenger;
       if (recordId < 0){
           betNumber = recordId++;
           betDetails.uniqueId = betNumber;
           betDetails.startTime = _startTime;
           betDetails.endTime = _endTime;
           betDetails.depositAmount = _depositAmount;
           player.playerName = _bettorName;
           player.playerEmail = _bettorEmail;
           player.assetName = _assetName;
           player.bettor = true;
           challenger.bettor = false;
           bets[betNumber]= BetRecord(betDetails, player, challenger);
       }else{
           BetRecord myBet = bets[recordId];
           betDetails = myBet.betDetails;
           player = myBet.player1;
           challenger = myBet.player2;
           challenger.playerName = _bettorName;
           challenger.playerEmail = _bettorEmail;
           bets[recordId]= BetRecord(betDetails, player, challenger);
       }
        gotDeposit(msg.sender, _startTime);
    }
    
    function showBetRecordsFor (uint _recordId)
    returns (string betStringxx) 
    {
       BetInfo memory betDetails;
       Player memory player;
       Player memory challenger;
        BetRecord myBet = bets[_recordId];
        betDetails = myBet.betDetails;
           player = myBet.player1;
           playerName = player.playerName;
           challenger = myBet.player2;
           challengerName = challenger.playerName;
    }
    
}
pragma solidity ^0.4.1;
contract letsPlayV4{
    
    string public playerName;
    string public challengerName;
    uint public betAmount;
    uint public recordId;
    
    struct BetInfo{
        uint uniqueId;
        uint startTime;
        uint endTime;
        uint depositAmount;
        //address challenger;
    }
    
    struct Player{
        string playerName;
        string playerEmail;
        string assetName;
        uint uniqueId;
        bool bettor;
        //mapping(uint =>Bet) bets; 
        //Bets [] public bets;
    }
    
    struct BetRecord{
         BetInfo betDetails;
         Player player1;
         Player player2;
    }
    
    uint betNumber;
    mapping (uint => BetRecord) bets;
    
    function letsPlayV4 (){
        recordId =0;
    }
    
    event gotDeposit(address player, uint startTime);

    function takeDeposit (
        string _bettorName,
        string _bettorEmail,
        string _assetName,
        uint _uniqueId,
        uint _startTime,
        uint _endTime,
        uint _depositAmount)
    {
       recordId = _uniqueId;
       BetInfo memory betDetails;
       Player memory player;
       Player memory challenger;
       if (recordId == 0){ // New Bett
           betNumber = recordId++;
           betDetails.uniqueId = betNumber;
           betDetails.startTime = _startTime;
           betDetails.endTime = _endTime;
           betDetails.depositAmount = _depositAmount;
           player.playerName = _bettorName;
           player.playerEmail = _bettorEmail;
           player.assetName = _assetName;
           player.bettor = true;
           challenger.bettor = false;
           bets[betNumber]= BetRecord(betDetails, player, challenger);
       }else{
           BetRecord myBet = bets[recordId];
           betDetails = myBet.betDetails;
           player = myBet.player1;
           challenger = myBet.player2;
           challenger.playerName = _bettorName;
           challenger.playerEmail = _bettorEmail;
           bets[recordId]= BetRecord(betDetails, player, challenger);
       }
        gotDeposit(msg.sender, _startTime);
    }
    
    function showBetRecordsFor (uint _recordId)
    returns (string betStringxx) 
    {
       BetInfo memory betDetails;
       Player memory player;
       Player memory challenger;
        BetRecord myBet = bets[_recordId];
        betDetails = myBet.betDetails;
           player = myBet.player1;
           playerName = player.playerName;
           challenger = myBet.player2;
           challengerName = challenger.playerName;
           recordId = _recordId;
    }
    
}
