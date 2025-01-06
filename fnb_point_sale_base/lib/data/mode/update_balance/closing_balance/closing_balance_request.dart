/// BranchID : "5bf4f6f2-c80c-49bc-a82d-fb164ca05e97"
/// CounterID : "05E707B7-D6E2-4A0A-A490-20E2BF0AC3FC"
/// UserID : "d7fadb4d-a582-47fb-83d6-0ea2d7e4c5fd"
/// NewClosingBalance : "1000"
/// ClosingBalanceDateTime : "2024-12-26T18:00:00"

class ClosingBalanceRequest {
  ClosingBalanceRequest({
      String? branchID, 
      String? counterID, 
      String? userID, 
      String? newClosingBalance, 
      String? closingBalanceDateTime,}){
    _branchID = branchID;
    _counterID = counterID;
    _userID = userID;
    _newClosingBalance = newClosingBalance;
    _closingBalanceDateTime = closingBalanceDateTime;
}

  ClosingBalanceRequest.fromJson(dynamic json) {
    _branchID = json['BranchID'];
    _counterID = json['CounterID'];
    _userID = json['UserID'];
    _newClosingBalance = json['NewClosingBalance'];
    _closingBalanceDateTime = json['ClosingBalanceDateTime'];
  }
  String? _branchID;
  String? _counterID;
  String? _userID;
  String? _newClosingBalance;
  String? _closingBalanceDateTime;

  String? get branchID => _branchID;
  String? get counterID => _counterID;
  String? get userID => _userID;
  String? get newClosingBalance => _newClosingBalance;
  String? get closingBalanceDateTime => _closingBalanceDateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchID'] = _branchID;
    map['CounterID'] = _counterID;
    map['UserID'] = _userID;
    map['NewClosingBalance'] = _newClosingBalance;
    map['ClosingBalanceDateTime'] = _closingBalanceDateTime;
    return map;
  }

}