pragma solidity ^0.4.1;
contract letsPlayV7{
    
    string public playerName;
    string public challengerName;
    uint public betAmount;
    uint public recordId;
    uint public temp_recordId;
    
    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;
    
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
        address acctNo;
        //mapping(uint =>Bet) bets; 
        //Bets [] public bets;
    }
    
    struct BetRecord{
         BetInfo betDetails;
         Player player1;
         Player player2;
    }
    
    mapping (uint => BetRecord) bets;
    
    function letsPlayV7 (){
        recordId =0;
    }
    
    event gotDeposit(address player, uint startTime);

    function takeDeposit (
        string _bettorName,
        string _bettorEmail,
        string _assetName,
        uint _uniqueId,
        uint _startTime,
        uint _endTime
        //, uint _depositAmount
        )
        payable
    {
       //uint betNumber;
       //recordId = _uniqueId;
       BetInfo memory betDetails;
       Player memory player;
       Player memory challenger;
       if (_uniqueId == 0){ //New bet requested
           recordId = recordId + 1;
           betDetails.uniqueId = recordId;
           betDetails.startTime = _startTime;
           betDetails.endTime = _endTime;
           betDetails.depositAmount = msg.value; //_depositAmount;
           player.playerName = _bettorName;
           player.playerEmail = _bettorEmail;
           player.assetName = _assetName;
           player.bettor = true;
           player.acctNo =msg.sender;
           challenger.bettor = false;
           bets[recordId]= BetRecord(betDetails, player, challenger);
       }else{
           // Update challenger details
           BetRecord myBet = bets[_uniqueId];
           betDetails = myBet.betDetails;
           player = myBet.player1;
           if (player.acctNo != msg.sender && 
               betDetails.depositAmount == msg.value 
               //&& pendingReturns[msg.sender] ==0 // No pending refunds 
               )         {   
               challenger = myBet.player2;
               challenger.playerName = _bettorName;
               challenger.playerEmail = _bettorEmail;
               challenger.acctNo =msg.sender;
               bets[_uniqueId]= BetRecord(betDetails, player, challenger);
               }else{
               throw;
           }
        }
        gotDeposit(msg.sender, _startTime);
    }
    
    
    function withdraw(uint _uniqueId) returns (bool) {
        
         //TODO: Delete bet record based on account
        uint betAmount =0;
        string memory assetName= "";
        BetInfo memory betDetails;
        Player memory player;
        Player memory challenger;
        BetRecord myBet = bets[_uniqueId];
           betDetails = myBet.betDetails;
           player = myBet.player1;
           challenger =myBet.player2;
        
        if (player.acctNo != msg.sender && challenger.acctNo !=msg.sender  ){   
                throw;
            }
        
        if (player.acctNo == msg.sender){
            betAmount = betDetails.depositAmount;
            assetName = player.assetName;
        }
        
        if (challenger.acctNo == msg.sender){
            betAmount = betDetails.depositAmount;
            assetName = challenger.assetName;
        }
        
        //var amount = pendingReturns[msg.sender];
        
        if (betAmount > 0) {
        // It is important to set this to zero because the recipient
        // can call this function again as part of the receiving call
        // before `send` returns.
        pendingReturns[msg.sender] = 0;
        if (!msg.sender.send(betAmount)) {
        // No need to call throw here, just reset the amount owing
        pendingReturns[msg.sender] = betAmount;
        return false;
        }
     }
    }
    
    function showBetRecordsFor (uint _recordId)
    returns (string betString) 
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
           temp_recordId=_recordId;
           betAmount = betDetails.depositAmount;
    }
    
}
