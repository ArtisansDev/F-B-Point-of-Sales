/// RowsPerPage : 20
/// PageNumber : 1
/// CounterIDF : "0E75BFA1-AF7D-4182-835B-B815C2972591"
/// OrderType : 0
/// TrackingOrderID : ""
/// SearchValue : ""
/// FromDate : ""
/// ToDate : ""

class OrderHistoryRequest {
  OrderHistoryRequest({
      int? rowsPerPage, 
      int? pageNumber, 
      String? counterIDF,
      int? orderType, //0 for all, 1 for Dine in, 2 for Take away,
      String? trackingOrderID, 
      String? searchValue, 
      String? fromDate, //utc
      String? toDate,}){
    _rowsPerPage = rowsPerPage;
    _pageNumber = pageNumber;
    _counterIDF = counterIDF;
    _orderType = orderType;
    _trackingOrderID = trackingOrderID;
    _searchValue = searchValue;
    _fromDate = fromDate;
    _toDate = toDate;
}

  OrderHistoryRequest.fromJson(dynamic json) {
    _rowsPerPage = json['RowsPerPage'];
    _pageNumber = json['PageNumber'];
    _counterIDF = json['CounterIDF'];
    _orderType = json['OrderType'];
    _trackingOrderID = json['TrackingOrderID'];
    _searchValue = json['SearchValue'];
    _fromDate = json['FromDate'];
    _toDate = json['ToDate'];
  }
  int? _rowsPerPage;
  int? _pageNumber;
  String? _counterIDF;
  int? _orderType;
  String? _trackingOrderID;
  String? _searchValue;
  String? _fromDate;
  String? _toDate;

  int? get rowsPerPage => _rowsPerPage;
  int? get pageNumber => _pageNumber;
  String? get counterIDF => _counterIDF;
  int? get orderType => _orderType;
  String? get trackingOrderID => _trackingOrderID;
  String? get searchValue => _searchValue;
  String? get fromDate => _fromDate;
  String? get toDate => _toDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RowsPerPage'] = _rowsPerPage;
    map['PageNumber'] = _pageNumber;
    map['CounterIDF'] = _counterIDF;
    map['OrderType'] = _orderType;
    map['TrackingOrderID'] = _trackingOrderID;
    map['SearchValue'] = _searchValue;
    map['FromDate'] = _fromDate;
    map['ToDate'] = _toDate;
    return map;
  }

}