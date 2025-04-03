/// BranchID : "5bf4f6f2-c80c-49bc-a82d-fb164ca05e97"
/// CounterID : "05E707B7-D6E2-4A0A-A490-20E2BF0AC3FC"
/// UserID : "D7FADB4D-A582-47FB-83D6-0EA2D7E4C5FD"
/// NewClosingBalance : "1000"
/// ClosingBalanceDateTime : "2024-12-26T18:50:00"
/// HistoryIDP : "DF5F57D4-0F99-448E-87FA-06F456BF10B0"
/// CashJson : {"cash_counter":[{"denomination":"0.1","Quantity":4},{"denomination":"0.5","Quantity":2},{"denomination":"1.0","Quantity":5},{"denomination":"5.0","Quantity":10},{"denomination":"10.0","Quantity":1},{"denomination":"20.0","Quantity":3},{"denomination":"50.0","Quantity":2},{"denomination":"100.0","Quantity":0}]}
/// Currency : "MYN"
/// Remark : null
/// OriginalBalance : null
/// IsMismatchBalance : null

class ClosingBalanceRequest {
  ClosingBalanceRequest({
    String? branchID,
    String? counterID,
    String? userID,
    String? newClosingBalance,
    String? closingBalanceDateTime,
    String? historyIDP,
    CashJson? cashJson,
    String? currency,
    String? remark,
    String? originalBalance,
    bool? isMismatchBalance,}){
    _branchID = branchID;
    _counterID = counterID;
    _userID = userID;
    _newClosingBalance = newClosingBalance;
    _closingBalanceDateTime = closingBalanceDateTime;
    _historyIDP = historyIDP;
    _cashJson = cashJson;
    _currency = currency;
    _remark = remark;
    _originalBalance = originalBalance;
    _isMismatchBalance = isMismatchBalance;
  }

  ClosingBalanceRequest.fromJson(dynamic json) {
    _branchID = json['BranchID'];
    _counterID = json['CounterID'];
    _userID = json['UserID'];
    _newClosingBalance = json['NewClosingBalance'];
    _closingBalanceDateTime = json['ClosingBalanceDateTime'];
    _historyIDP = json['HistoryIDP'];
    _cashJson = json['CashJson'] != null ? CashJson.fromJson(json['CashJson']) : null;
    _currency = json['Currency'];
    _remark = json['Remark'];
    _originalBalance = json['OriginalBalance'];
    _isMismatchBalance = json['IsMismatchBalance'];
  }
  String? _branchID;
  String? _counterID;
  String? _userID;
  String? _newClosingBalance;
  String? _closingBalanceDateTime;
  String? _historyIDP;
  CashJson? _cashJson;
  String? _currency;
  String? _remark;
  String? _originalBalance;
  bool? _isMismatchBalance;

  String? get branchID => _branchID;
  String? get counterID => _counterID;
  String? get userID => _userID;
  String? get newClosingBalance => _newClosingBalance;
  String? get closingBalanceDateTime => _closingBalanceDateTime;
  String? get historyIDP => _historyIDP;
  CashJson? get cashJson => _cashJson;
  String? get currency => _currency;
  String? get remark => _remark;
  String? get originalBalance => _originalBalance;
  bool? get isMismatchBalance => _isMismatchBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchID'] = _branchID;
    map['CounterID'] = _counterID;
    map['UserID'] = _userID;
    map['NewClosingBalance'] = _newClosingBalance;
    map['ClosingBalanceDateTime'] = _closingBalanceDateTime;
    map['HistoryIDP'] = _historyIDP;
    if (_cashJson != null) {
      map['CashJson'] = _cashJson?.toJson();
    }
    map['Currency'] = _currency;
    map['Remark'] = _remark;
    map['OriginalBalance'] = _originalBalance;
    map['IsMismatchBalance'] = _isMismatchBalance;
    return map;
  }

}

/// cash_counter : [{"denomination":"0.1","Quantity":4},{"denomination":"0.5","Quantity":2},{"denomination":"1.0","Quantity":5},{"denomination":"5.0","Quantity":10},{"denomination":"10.0","Quantity":1},{"denomination":"20.0","Quantity":3},{"denomination":"50.0","Quantity":2},{"denomination":"100.0","Quantity":0}]

class CashJson {
  CashJson({
    List<CashCounter>? cashCounter,}){
    _cashCounter = cashCounter;
  }

  CashJson.fromJson(dynamic json) {
    if (json['cash_counter'] != null) {
      _cashCounter = [];
      json['cash_counter'].forEach((v) {
        _cashCounter?.add(CashCounter.fromJson(v));
      });
    }
  }
  List<CashCounter>? _cashCounter;

  List<CashCounter>? get cashCounter => _cashCounter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cashCounter != null) {
      map['cash_counter'] = _cashCounter?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// denomination : "0.1"
/// Quantity : 4

class CashCounter {
  CashCounter({
    String? denomination,
    int? quantity,}){
    _denomination = denomination;
    _quantity = quantity;
  }

  CashCounter.fromJson(dynamic json) {
    _denomination = json['denomination'];
    _quantity = json['Quantity'];
  }
  String? _denomination;
  int? _quantity;

  String? get denomination => _denomination;
  int? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['denomination'] = _denomination;
    map['Quantity'] = _quantity;
    return map;
  }

}