import '../../../../utils/num_utils.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"FullName":"Prashant Chauhan","CounterName":"Sarkhej Counter -2","OpeningBalanceDateTime":"2025-02-01T05:41:54","OpeningBalance":0.0,"ShiftClosingLimit":"2025-02-01T17:41:54","SalesCount":65,"DebitCardCount":23,"CreditCardCount":1,"QRCodeCount":4,"RefundCount":0,"VoucherGenerateCount":0,"CashPayment":5057.1,"DebitCardPayment":5347.5,"CreditCardPayment":319.0,"QRCodePayment":572.0,"ErrorMessage":null,"HasPendingPayments":true,"PaymentType":[{"Name":"Debit Card Payment","Count":23,"PaymentGatewayNo":5},{"Name":"Credit Card Payment","Count":1,"PaymentGatewayNo":6},{"Name":"QR Code Payment","Count":4,"PaymentGatewayNo":7}]}

class ShiftDetailsResponse {
  ShiftDetailsResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    ShiftDetailsData? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
  }

  ShiftDetailsResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'] != null ? ShiftDetailsData.fromJson(json['data']) : null;
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

/// FullName : "Prashant Chauhan"
/// CounterName : "Sarkhej Counter -2"
/// OpeningBalanceDateTime : "2025-02-01T05:41:54"
/// OpeningBalance : 0.0
/// ShiftClosingLimit : "2025-02-01T17:41:54"
/// SalesCount : 65
/// DebitCardCount : 23
/// CreditCardCount : 1
/// QRCodeCount : 4
/// RefundCount : 0
/// VoucherGenerateCount : 0
/// CashPayment : 5057.1
/// DebitCardPayment : 5347.5
/// CreditCardPayment : 319.0
/// QRCodePayment : 572.0
/// ErrorMessage : null
/// HasPendingPayments : true
/// PaymentType : [{"Name":"Debit Card Payment","Count":23,"PaymentGatewayNo":5},{"Name":"Credit Card Payment","Count":1,"PaymentGatewayNo":6},{"Name":"QR Code Payment","Count":4,"PaymentGatewayNo":7}]

class ShiftDetailsData {
  ShiftDetailsData({
    String? fullName,
    String? counterName,
    String? openingBalanceDateTime,
    double? openingBalance,
    String? shiftClosingLimit,
    int? salesCount,
    int? debitCardCount,
    int? creditCardCount,
    int? qRCodeCount,
    int? refundCount,
    int? voucherGenerateCount,
    double? cashPayment,
    double? debitCardPayment,
    double? creditCardPayment,
    double? qRCodePayment,
    dynamic errorMessage,
    bool? hasPendingPayments,
    List<PaymentType>? paymentType,}){
    _fullName = fullName;
    _counterName = counterName;
    _openingBalanceDateTime = openingBalanceDateTime;
    _openingBalance = openingBalance;
    _shiftClosingLimit = shiftClosingLimit;
    _salesCount = salesCount;
    _debitCardCount = debitCardCount;
    _creditCardCount = creditCardCount;
    _qRCodeCount = qRCodeCount;
    _refundCount = refundCount;
    _voucherGenerateCount = voucherGenerateCount;
    _cashPayment = cashPayment;
    _debitCardPayment = debitCardPayment;
    _creditCardPayment = creditCardPayment;
    _qRCodePayment = qRCodePayment;
    _errorMessage = errorMessage;
    _hasPendingPayments = hasPendingPayments;
    _paymentType = paymentType;
  }

  ShiftDetailsData.fromJson(dynamic json) {
    _fullName = json['FullName'];
    _counterName = json['CounterName'];
    _openingBalanceDateTime = json['OpeningBalanceDateTime'];
    _openingBalance = json['OpeningBalance'];
    _shiftClosingLimit = json['ShiftClosingLimit'];
    _salesCount = json['SalesCount'];
    _debitCardCount = json['DebitCardCount'];
    _creditCardCount = json['CreditCardCount'];
    _qRCodeCount = json['QRCodeCount'];
    _refundCount = json['RefundCount'];
    _voucherGenerateCount = json['VoucherGenerateCount'];
    _cashPayment = json['CashPayment'];
    _debitCardPayment = json['DebitCardPayment'];
    _creditCardPayment = json['CreditCardPayment'];
    _qRCodePayment = json['QRCodePayment'];
    _errorMessage = json['ErrorMessage'];
    _hasPendingPayments = json['HasPendingPayments'];
    if (json['PaymentType'] != null) {
      _paymentType = [];
      json['PaymentType'].forEach((v) {
        _paymentType?.add(PaymentType.fromJson(v));
      });
    }
  }
  String? _fullName;
  String? _counterName;
  String? _openingBalanceDateTime;
  double? _openingBalance;
  String? _shiftClosingLimit;
  int? _salesCount;
  int? _debitCardCount;
  int? _creditCardCount;
  int? _qRCodeCount;
  int? _refundCount;
  int? _voucherGenerateCount;
  double? _cashPayment;
  double? _debitCardPayment;
  double? _creditCardPayment;
  double? _qRCodePayment;
  dynamic _errorMessage;
  bool? _hasPendingPayments;
  List<PaymentType>? _paymentType;

  String? get fullName => _fullName;
  String? get counterName => _counterName;
  String? get openingBalanceDateTime => _openingBalanceDateTime;
  double? get openingBalance => _openingBalance;
  String? get shiftClosingLimit => _shiftClosingLimit;
  int? get salesCount => _salesCount;
  int? get debitCardCount => _debitCardCount;
  int? get creditCardCount => _creditCardCount;
  int? get qRCodeCount => _qRCodeCount;
  int? get refundCount => _refundCount;
  int? get voucherGenerateCount => _voucherGenerateCount;
  double? get cashPayment => _cashPayment;
  double? get debitCardPayment => _debitCardPayment;
  double? get creditCardPayment => _creditCardPayment;
  double? get qRCodePayment => _qRCodePayment;
  dynamic get errorMessage => _errorMessage;
  bool? get hasPendingPayments => _hasPendingPayments;
  List<PaymentType>? get paymentType => _paymentType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FullName'] = _fullName;
    map['CounterName'] = _counterName;
    map['OpeningBalanceDateTime'] = _openingBalanceDateTime;
    map['OpeningBalance'] = _openingBalance;
    map['ShiftClosingLimit'] = _shiftClosingLimit;
    map['SalesCount'] = _salesCount;
    map['DebitCardCount'] = _debitCardCount;
    map['CreditCardCount'] = _creditCardCount;
    map['QRCodeCount'] = _qRCodeCount;
    map['RefundCount'] = _refundCount;
    map['VoucherGenerateCount'] = _voucherGenerateCount;
    map['CashPayment'] = _cashPayment;
    map['DebitCardPayment'] = _debitCardPayment;
    map['CreditCardPayment'] = _creditCardPayment;
    map['QRCodePayment'] = _qRCodePayment;
    map['ErrorMessage'] = _errorMessage;
    map['HasPendingPayments'] = _hasPendingPayments;
    if (_paymentType != null) {
      map['PaymentType'] = _paymentType?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Name : "Debit Card Payment"
/// Count : 23
/// PaymentGatewayNo : 5
/// Amount : 5

class PaymentType {
  PaymentType({
    String? name,
    int? count,
    int? paymentGatewayNo,
    double? amount,
  }){
    _name = name;
    _count = count;
    _paymentGatewayNo = paymentGatewayNo;
    _amount = amount;
  }

  PaymentType.fromJson(dynamic json) {
    _name = json['Name'];
    _count = json['Count'];
    _paymentGatewayNo = json['PaymentGatewayNo'];
    _amount = getDoubleValue(json['Amount']);
  }
  String? _name;
  int? _count;
  int? _paymentGatewayNo;
  double? _amount;

  String? get name => _name;
  int? get count => _count;
  int? get paymentGatewayNo => _paymentGatewayNo;
  double? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Count'] = _count;
    map['PaymentGatewayNo'] = _paymentGatewayNo;
    map['Amount'] = _amount;
    return map;
  }

}