/// BranchID : "5bf4f6f2-c80c-49bc-a82d-fb164ca05e97"
/// CounterID : "05E707B7-D6E2-4A0A-A490-20E2BF0AC3FC"
/// UserID : "d7fadb4d-a582-47fb-83d6-0ea2d7e4c5fd"
/// OpeningBalance : 1000.50
/// OpeningBalanceDateTime : "2024-12-26T10:00:00"

class OpeningBalanceRequest {
  OpeningBalanceRequest({
      String? branchID, 
      String? counterID, 
      String? userID, 
      double? openingBalance, 
      String? openingBalanceDateTime,}){
    _branchID = branchID;
    _counterID = counterID;
    _userID = userID;
    _openingBalance = openingBalance;
    _openingBalanceDateTime = openingBalanceDateTime;
}

  OpeningBalanceRequest.fromJson(dynamic json) {
    _branchID = json['BranchID'];
    _counterID = json['CounterID'];
    _userID = json['UserID'];
    _openingBalance = json['OpeningBalance'];
    _openingBalanceDateTime = json['OpeningBalanceDateTime'];
  }
  String? _branchID;
  String? _counterID;
  String? _userID;
  double? _openingBalance;
  String? _openingBalanceDateTime;

  String? get branchID => _branchID;
  String? get counterID => _counterID;
  String? get userID => _userID;
  double? get openingBalance => _openingBalance;
  String? get openingBalanceDateTime => _openingBalanceDateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchID'] = _branchID;
    map['CounterID'] = _counterID;
    map['UserID'] = _userID;
    map['OpeningBalance'] = _openingBalance;
    map['OpeningBalanceDateTime'] = _openingBalanceDateTime;
    return map;
  }

}