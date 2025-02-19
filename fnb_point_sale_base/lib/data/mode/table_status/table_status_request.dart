/// SeatIDP : "e5a27f36-da7e-41f9-b8bb-c411cd9d8939"
/// UserIDF : "b8f1a827-1234-4f9d-b8bb-c411cd9d8940"
/// TableStatus : "O"

class TableStatusRequest {
  TableStatusRequest({
      String? seatIDP, 
      String? userIDF, 
      String? trackingOrderID,
      String? tableStatus,}){
    _seatIDP = seatIDP;
    _userIDF = userIDF;
    _tableStatus = tableStatus;
    _trackingOrderID = trackingOrderID;
}

  TableStatusRequest.fromJson(dynamic json) {
    _seatIDP = json['SeatIDP'];
    _userIDF = json['UserIDF'];
    _tableStatus = json['TableStatus'];
    _trackingOrderID = json['TrackingOrderID'];
  }
  String? _seatIDP;
  String? _userIDF;
  String? _tableStatus;
  String? _trackingOrderID;

  String? get seatIDP => _seatIDP;
  String? get userIDF => _userIDF;
  String? get tableStatus => _tableStatus;
  String? get trackingOrderID => _trackingOrderID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SeatIDP'] = _seatIDP;
    map['UserIDF'] = _userIDF;
    map['TableStatus'] = _tableStatus;
    map['TrackingOrderID'] = _trackingOrderID;
    return map;
  }

}