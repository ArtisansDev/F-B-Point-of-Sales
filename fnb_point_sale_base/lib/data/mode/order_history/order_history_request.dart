/// RowsPerPage : 20
/// PageNumber : 1
/// CounterIDF : "0E75BFA1-AF7D-4182-835B-B815C2972591"
/// "OrderType": 0 , //0 for all, 1 for Dine in, 2 for Take away,
/// TrackingOrderID : ""
/// SearchValue : ""
/// FromDate : ""
/// ToDate : ""
/// "OrderSource": 0 , //0 for all, 1 App, 2 POS, 3 Web,
/// "PaymentStatus": null //S - success, P - Pending, F - Fail

class OrderHistoryRequest {
  OrderHistoryRequest({
    int? rowsPerPage,
    int? pageNumber,
    String? counterIDF,
    int? orderType, //0 for all, 1 for Dine in, 2 for Take away,
    String? trackingOrderID,
    String? searchValue,
    String? fromDate, //utc
    String? toDate,
    String? orderSource,
    String? paymentStatus,
  }) {
    _rowsPerPage = rowsPerPage;
    _pageNumber = pageNumber;
    _counterIDF = counterIDF;
    _orderType = orderType;
    _trackingOrderID = trackingOrderID;
    _searchValue = searchValue;
    _fromDate = fromDate;
    _toDate = toDate;
    _orderSource = orderSource;
    _paymentStatus = paymentStatus;
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
    _orderSource = json['OrderSource'];
    _paymentStatus = json['PaymentStatus'];
  }

  int? _rowsPerPage;
  int? _pageNumber;
  String? _counterIDF;
  int? _orderType;
  String? _trackingOrderID;
  String? _searchValue;
  String? _fromDate;
  String? _toDate;
  String? _orderSource;
  String? _paymentStatus;

  int? get rowsPerPage => _rowsPerPage;

  int? get pageNumber => _pageNumber;

  String? get counterIDF => _counterIDF;

  int? get orderType => _orderType;

  String? get trackingOrderID => _trackingOrderID;

  String? get searchValue => _searchValue;

  String? get fromDate => _fromDate;

  String? get toDate => _toDate;

  String? get orderSource => _orderSource;

  String? get paymentStatus => _paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RowsPerPage'] = _rowsPerPage;
    map['PageNumber'] = _pageNumber;
    map['CounterIDF'] = _counterIDF;
    map['OrderType'] = _orderType;
    map['OrderSource'] = _orderSource;
    map['PaymentStatus'] = _paymentStatus;
    if ((_trackingOrderID ?? "").isEmpty) {
      map['TrackingOrderID'] = null;
    } else {
      map['TrackingOrderID'] = _trackingOrderID;
    }
    if ((_searchValue ?? "").isEmpty) {
      map['SearchValue'] = null;
    } else {
      map['SearchValue'] = _searchValue;
    }
    if ((_fromDate ?? "").isEmpty) {
      map['FromDate'] = null;
    } else {
      map['FromDate'] = _fromDate;
    }
    if ((_toDate ?? "").isEmpty) {
      map['ToDate'] = null;
    } else {
      map['ToDate'] = _toDate;
    }
    return map;
  }

}