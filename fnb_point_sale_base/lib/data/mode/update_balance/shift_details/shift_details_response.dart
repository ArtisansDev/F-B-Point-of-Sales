import 'package:fnb_point_sale_base/utils/num_utils.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"FullName":"Test Operator","CounterName":"Sarkhej Counter -2","OpeningBalanceDateTime":"2025-01-06T08:59:40.897","ShiftClosingLimit":"2025-01-06T20:59:40.897","SalesCount":3,"RefundCount":0,"VoucherGenerateCount":0,"CashPayment":323.08,"ErrorMessage":""}

class ShiftDetailsResponse {
  ShiftDetailsResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    ShiftDetailsData? data,
  }) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
  }

  ShiftDetailsResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data =
    json['data'] != null ? ShiftDetailsData.fromJson(json['data']) : null;
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  ShiftDetailsData? _data;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  ShiftDetailsData? get data => _data;

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

/// FullName : "Test Operator"
/// CounterName : "Sarkhej Counter -2"
/// OpeningBalanceDateTime : "2025-01-06T08:59:40.897"
/// ShiftClosingLimit : "2025-01-06T20:59:40.897"
/// SalesCount : 3
/// RefundCount : 0
/// VoucherGenerateCount : 0
/// CashPayment : 323.08
/// ErrorMessage : ""
/// HasPendingPayments : true

class ShiftDetailsData {
  ShiftDetailsData({
    String? fullName,
    String? counterName,
    String? openingBalanceDateTime,
    String? shiftClosingLimit,
    int? salesCount,
    int? refundCount,
    int? voucherGenerateCount,
    double? cashPayment,
    String? errorMessage,
    bool? hasPendingPayments,
  }) {
    _fullName = fullName;
    _counterName = counterName;
    _openingBalanceDateTime = openingBalanceDateTime;
    _shiftClosingLimit = shiftClosingLimit;
    _salesCount = salesCount;
    _refundCount = refundCount;
    _voucherGenerateCount = voucherGenerateCount;
    _cashPayment = cashPayment;
    _errorMessage = errorMessage;
    _hasPendingPayments = hasPendingPayments;
  }

  ShiftDetailsData.fromJson(dynamic json) {
    _fullName = json['FullName'];
    _counterName = json['CounterName'];
    _openingBalanceDateTime = json['OpeningBalanceDateTime'];
    _shiftClosingLimit = json['ShiftClosingLimit'];
    _salesCount = getInValue(json['SalesCount']);
    _refundCount = getInValue(json['RefundCount']);
    _voucherGenerateCount = getInValue(json['VoucherGenerateCount']);
    _cashPayment = getDoubleValue(json['CashPayment']);
    _errorMessage = json['ErrorMessage'] ?? '';
    _hasPendingPayments = json['HasPendingPayments'] ?? false;
  }

  String? _fullName;
  String? _counterName;
  String? _openingBalanceDateTime;
  String? _shiftClosingLimit;
  int? _salesCount;
  int? _refundCount;
  int? _voucherGenerateCount;
  double? _cashPayment;
  String? _errorMessage;
  bool? _hasPendingPayments;

  String? get fullName => _fullName;

  String? get counterName => _counterName;

  String? get openingBalanceDateTime => _openingBalanceDateTime;

  String? get shiftClosingLimit => _shiftClosingLimit;

  int? get salesCount => _salesCount;

  int? get refundCount => _refundCount;

  int? get voucherGenerateCount => _voucherGenerateCount;

  double? get cashPayment => _cashPayment;

  String? get errorMessage => _errorMessage;

  bool? get hasPendingPayments => _hasPendingPayments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FullName'] = _fullName;
    map['CounterName'] = _counterName;
    map['OpeningBalanceDateTime'] = _openingBalanceDateTime;
    map['ShiftClosingLimit'] = _shiftClosingLimit;
    map['SalesCount'] = _salesCount;
    map['RefundCount'] = _refundCount;
    map['VoucherGenerateCount'] = _voucherGenerateCount;
    map['CashPayment'] = _cashPayment;
    map['ErrorMessage'] = _errorMessage;
    map['HasPendingPayments'] = _hasPendingPayments;
    return map;
  }
}
