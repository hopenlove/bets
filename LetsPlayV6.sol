pragma solidity ^0.4.1;
contract letsPlayV6{
    
    string public playerName;
    string public challengerName;
    uint public betAmount;
    uint public recordId;
    uint public temp_recordId;
    bool public transferSucessful;
    address constant companyAcct =0x13a359454306f20d840e8aca2cbaf300a66bc5ac;
    
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
    
    mapping (uint => BetRecord[]) betRecords;
    
    function letsPlayV6 (){
        recordId =0;
        //companyAcct=0x13a359454306f20d840e8aca2cbaf300a66bc5ac;
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
       BetInfo memory _betDetails;
       Player memory _player;
       Player memory _challenger;
       BetRecord memory _betRecord;
       
       if (_uniqueId == 0){ //New bet requested
           recordId = recordId + 1;
           /*_betDetails.uniqueId = recordId;
           _betDetails.startTime = _startTime;
           _betDetails.endTime = _endTime;
           _betDetails.depositAmount = msg.value; //_depositAmount;
           _player.playerName = _bettorName;
           _player.playerEmail = _bettorEmail;
           _player.assetName = _assetName;
           _player.bettor = true;
           _player.acctNo = msg.sender;
           _challenger.bettor = false;*/
           //betRecords[recordId]= BetRecord(betDetails, player, challenger);
           //betRecords[recordId]= BetRecord(_betDetails, _player, _challenger);
           
           _betDetails = BetInfo(recordId, _startTime, _endTime, msg.value);
           _player = Player(_bettorName,_bettorEmail,_assetName,recordId,true,msg.sender);
           _challenger = 
              Player("","",_assetName,recordId,false, companyAcct);
           
           _betRecord = BetRecord(_betDetails,_player,_challenger);
           betRecords[recordId].push(_betRecord);
           //betRecords[recordId].push(BetRecord({betails: _betDetails,  
           //player: _player,     
           //challenger: _challenger}));
           
       }else{
           // Update challenger details
           _betRecord = betRecords[_uniqueId][0]; //Get object ref
           _betDetails = _betRecord.betDetails;
           _player = _betRecord.player1;
           if (_player.acctNo != msg.sender && 
               _betDetails.depositAmount == msg.value 
               //&& pendingReturns[msg.sender] ==0 // No pending refunds 
               )         {   
               //_challenger = _betRecord.player2;
               //_challenger.playerName = _bettorName;
               //_challenger.playerEmail = _bettorEmail;
               //_challenger.acctNo =msg.sender;
               //betRecords[_uniqueId]= BetRecord(betDetails, 
               //player, challenger);
                //betRecords[recordId].push(BetRecord({
                //betDetails: _betDetails, 
                //player: _player, 
                //challenger: _challenger}));
                //_betDetails = BetInfo(recordId, _startTime, _endTime, msg.value);
          // _player = Player(_bettorName,_bettorEmail,_assetName,recordId,true,msg.sender);
           _challenger = 
              Player(_bettorName,_bettorEmail,_assetName,_uniqueId,false, msg.sender);
           
           _betRecord = BetRecord(_betDetails,_player,_challenger);
           betRecords[recordId].push(_betRecord);
                   
                   
                   
               }else{
               throw;
           }
        }
        transferSucessful=companyAcct.send(msg.value);
        gotDeposit(msg.sender, _startTime);
    }
    
    
    function withdraw(uint _uniqueId) constant returns (bool) {
        
         //TODO: Delete bet record based on account
         /*
        BetInfo memory betDetails;
        Player memory player;
        Player memory challenger;
        BetRecord myBet = bets[_uniqueId];
           betDetails = myBet.betDetails;
           player = myBet.player1;
           challenger =myBet.player2;
        */
        var amount = pendingReturns[msg.sender];
        
        if (amount > 0) {
        // It is important to set this to zero because the recipient
        // can call this function again as part of the receiving call
        // before `send` returns.
        pendingReturns[msg.sender] = 0;
        if (!msg.sender.send(amount)) {
        // No need to call throw here, just reset the amount owing
        pendingReturns[msg.sender] = amount;
        return false;
        }
     }
    }
    
    function showBetRecordsFor (uint _recordId)
    returns (string) 
    {
       BetInfo memory betDetails;
       Player memory player;
       Player memory challenger;
        BetRecord myBet = betRecords[_recordId][0];
        betDetails = myBet.betDetails;
           player = myBet.player1;
           playerName = player.playerName;
           challenger = myBet.player2;
           challengerName = challenger.playerName;
           temp_recordId=_recordId;
           betAmount = betDetails.depositAmount;
    }
    
}
