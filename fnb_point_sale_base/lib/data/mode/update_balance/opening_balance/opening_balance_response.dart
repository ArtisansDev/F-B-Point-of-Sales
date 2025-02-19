/// error : false
/// statusCode : 200
/// statusMessage : "Opening balance updated successfully."
/// data : {"HistoryID":"FB310DC1-C0BC-4944-BC8E-93969C9AFB3E"}

class OpeningBalanceResponse {
  OpeningBalanceResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage,
    OpeningBalanceData? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  OpeningBalanceResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'] != null ? OpeningBalanceData.fromJson(json['data']) : null;
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  OpeningBalanceData? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  OpeningBalanceData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// HistoryID : "FB310DC1-C0BC-4944-BC8E-93969C9AFB3E"

class OpeningBalanceData {
  OpeningBalanceData({
      String? historyID,}){
    _historyID = historyID;
}

  OpeningBalanceData.fromJson(dynamic json) {
    _historyID = json['HistoryID'];
  }
  String? _historyID;

  String? get historyID => _historyID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['HistoryID'] = _historyID;
    return map;
  }

}