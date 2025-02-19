/// CounterIDF : "05E707B7-D6E2-4A0A-A490-20E2BF0AC3FC"
/// UserIDF : "D7FADB4D-A582-47FB-83D6-0EA2D7E4C5FD"
/// CounterBalanceHistoryIDF : "D7FADB4D-A582-47FB-83D6-0EA2D7E4C5FD"

class ShiftDetailsRequest {
  ShiftDetailsRequest({
      String? counterIDF, 
      String? userIDF, 
      String? counterBalanceHistoryIDF,}){
    _counterIDF = counterIDF;
    _userIDF = userIDF;
    _counterBalanceHistoryIDF = counterBalanceHistoryIDF;
}

  ShiftDetailsRequest.fromJson(dynamic json) {
    _counterIDF = json['CounterIDF'];
    _userIDF = json['UserIDF'];
    _counterBalanceHistoryIDF = json['CounterBalanceHistoryIDF'];
  }
  String? _counterIDF;
  String? _userIDF;
  String? _counterBalanceHistoryIDF;

  String? get counterIDF => _counterIDF;
  String? get userIDF => _userIDF;
  String? get counterBalanceHistoryIDF => _counterBalanceHistoryIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CounterIDF'] = _counterIDF;
    map['UserIDF'] = _userIDF;
    map['CounterBalanceHistoryIDF'] = _counterBalanceHistoryIDF;
    return map;
  }

}