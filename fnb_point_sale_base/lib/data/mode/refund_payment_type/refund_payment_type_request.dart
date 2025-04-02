/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// TrackingOrderID : "4766392791"
/// PaymentGatewayIDF : "8FE2B7F2-666D-491A-9C88-6F0207A5286F"
/// PaymentGatewaySettingIDF : "B3FB9D34-97A8-4583-8940-0FB52748D14A"
/// UserIDF : "a35ca135-4c38-42a2-8aec-da4d4746aad9"
/// reasonForRefund : "mistake select payment type"
/// RequestData : {"DebitCard":{"CardNumber":5544}}

class RefundPaymentTypeRequest {
  RefundPaymentTypeRequest({
    String? restaurantIDF,
    String? branchIDF,
    String? counterIDF,
    String? counterBalanceHistoryIDF,
    String? trackingOrderID,
    String? paymentGatewayIDF,
    String? paymentGatewaySettingIDF,
    String? userIDF,
    String? reasonForRefund,
    String? refundedReferenceID,
    String? requestData,
    String? generalManagerUserID,
    String? payAmountCash,
    String? dueAmountCash,
    String? returnAmountCash,
  }) {
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _counterIDF = counterIDF;
    _counterBalanceHistoryIDF = counterBalanceHistoryIDF;
    _trackingOrderID = trackingOrderID;
    _paymentGatewayIDF = paymentGatewayIDF;
    _paymentGatewaySettingIDF = paymentGatewaySettingIDF;
    _userIDF = userIDF;
    _reasonForRefund = reasonForRefund;
    _refundedReferenceID = refundedReferenceID;
    _requestData = requestData;
    _payAmountCash = payAmountCash;
    _dueAmountCash = dueAmountCash;
    _returnAmountCash = returnAmountCash;
    _generalManagerUserID = generalManagerUserID;
  }

  RefundPaymentTypeRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _counterIDF = json['CounterIDF'];
    _counterBalanceHistoryIDF = json['CounterBalanceHistoryIDF'];
    _trackingOrderID = json['TrackingOrderID'];
    _paymentGatewayIDF = json['PaymentGatewayIDF'];
    _paymentGatewaySettingIDF = json['PaymentGatewaySettingIDF'];
    _userIDF = json['UserIDF'];
    _reasonForRefund = json['ReasonForRefund'];
    _refundedReferenceID = json['RefundedReferenceID'];
    _requestData = json['RequestData'];
    _payAmountCash = json['PayAmountCash'];
    _dueAmountCash = json['DueAmountCash'];
    _returnAmountCash = json['ReturnAmountCash'];
    _generalManagerUserID = json['GeneralManagerUserID'];
  }

  String? _restaurantIDF;
  String? _branchIDF;
  String? _counterIDF;
  String? _counterBalanceHistoryIDF;
  String? _trackingOrderID;
  String? _paymentGatewayIDF;
  String? _paymentGatewaySettingIDF;
  String? _userIDF;
  String? _reasonForRefund;
  String? _refundedReferenceID;
  String? _requestData;
  String? _payAmountCash;
  String? _dueAmountCash;
  String? _returnAmountCash;
  String? _generalManagerUserID;

  String? get restaurantIDF => _restaurantIDF;

  String? get branchIDF => _branchIDF;

  String? get counterIDF => _counterIDF;

  String? get counterBalanceHistoryIDF => _counterBalanceHistoryIDF;

  String? get trackingOrderID => _trackingOrderID;

  String? get paymentGatewayIDF => _paymentGatewayIDF;

  String? get paymentGatewaySettingIDF => _paymentGatewaySettingIDF;

  String? get userIDF => _userIDF;

  String? get reasonForRefund => _reasonForRefund;

  String? get refundedReferenceID => _refundedReferenceID;

  String? get requestData => _requestData;

  String? get payAmountCash => _payAmountCash;

  String? get dueAmountCash => _dueAmountCash;

  String? get returnAmountCash => _returnAmountCash;

  String? get generalManagerUserID => _generalManagerUserID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['CounterIDF'] = _counterIDF;
    map['CounterBalanceHistoryIDF'] = _counterBalanceHistoryIDF;
    map['TrackingOrderID'] = _trackingOrderID;
    map['PaymentGatewayIDF'] = _paymentGatewayIDF;
    map['PaymentGatewaySettingIDF'] = _paymentGatewaySettingIDF;
    map['UserIDF'] = _userIDF;
    map['ReasonForRefund'] = _reasonForRefund;
    map['RefundedReferenceID'] = _refundedReferenceID;
    map['RequestData'] = _requestData;
    map['PayAmountCash'] = _payAmountCash;
    map['DueAmountCash'] = _dueAmountCash;
    map['ReturnAmountCash'] = _returnAmountCash;
    map['GeneralManagerUserID'] = _generalManagerUserID;
    return map;
  }
}

/// CardNumber : 5544

class DebitCard {
  DebitCard({
    int? cardNumber,
  }) {
    _cardNumber = cardNumber;
  }

  DebitCard.fromJson(dynamic json) {
    _cardNumber = json['CardNumber'];
  }

  int? _cardNumber;

  int? get cardNumber => _cardNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CardNumber'] = _cardNumber;
    return map;
  }
}
