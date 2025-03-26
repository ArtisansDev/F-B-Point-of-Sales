/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// TrackingOrderID : "4766392791"
/// PaymentGatewayIDF : "8FE2B7F2-666D-491A-9C88-6F0207A5286F"
/// PaymentGatewaySettingIDF : "B3FB9D34-97A8-4583-8940-0FB52748D14A"
/// UserIDF : "a35ca135-4c38-42a2-8aec-da4d4746aad9"
/// ReasonForChangingPaymentType : "mistake select payment type"
/// RequestData : {"DebitCard":{"CardNumber":5544}}

class UpdatePaymentTypeRequest {
  UpdatePaymentTypeRequest({
    String? restaurantIDF,
    String? branchIDF,
    String? trackingOrderID,
    String? paymentGatewayIDF,
    String? paymentGatewaySettingIDF,
    String? userIDF,
    String? reasonForChangingPaymentType,
    String? requestData,}) {
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _trackingOrderID = trackingOrderID;
    _paymentGatewayIDF = paymentGatewayIDF;
    _paymentGatewaySettingIDF = paymentGatewaySettingIDF;
    _userIDF = userIDF;
    _reasonForChangingPaymentType = reasonForChangingPaymentType;
    _requestData = requestData;
  }

  UpdatePaymentTypeRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _trackingOrderID = json['TrackingOrderID'];
    _paymentGatewayIDF = json['PaymentGatewayIDF'];
    _paymentGatewaySettingIDF = json['PaymentGatewaySettingIDF'];
    _userIDF = json['UserIDF'];
    _reasonForChangingPaymentType = json['ReasonForChangingPaymentType'];
    _requestData = json['RequestData'];
    // _requestData = json['RequestData'] != null
    //     ? RequestData.fromJson(json['RequestData'])
    //     : null;
  }

  String? _restaurantIDF;
  String? _branchIDF;
  String? _trackingOrderID;
  String? _paymentGatewayIDF;
  String? _paymentGatewaySettingIDF;
  String? _userIDF;
  String? _reasonForChangingPaymentType;
  String? _requestData;

  String? get restaurantIDF => _restaurantIDF;

  String? get branchIDF => _branchIDF;

  String? get trackingOrderID => _trackingOrderID;

  String? get paymentGatewayIDF => _paymentGatewayIDF;

  String? get paymentGatewaySettingIDF => _paymentGatewaySettingIDF;

  String? get userIDF => _userIDF;

  String? get reasonForChangingPaymentType => _reasonForChangingPaymentType;

  String? get requestData => _requestData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['TrackingOrderID'] = _trackingOrderID;
    map['PaymentGatewayIDF'] = _paymentGatewayIDF;
    map['PaymentGatewaySettingIDF'] = _paymentGatewaySettingIDF;
    map['UserIDF'] = _userIDF;
    map['ReasonForChangingPaymentType'] = _reasonForChangingPaymentType;
    map['RequestData'] = _requestData;

    // if (_requestData != null) {
    //   map['RequestData'] = RequestData?.toJson();
    // }
    return map;
  }

}

// /// DebitCard : {"CardNumber":5544}
//
// class RequestData {
//   RequestData({
//       DebitCard? debitCard,}){
//     _debitCard = debitCard;
// }
//
//   RequestData.fromJson(dynamic json) {
//     _debitCard = json['DebitCard'] != null ? DebitCard.fromJson(json['DebitCard']) : null;
//   }
//   DebitCard? _debitCard;
//
//   DebitCard? get debitCard => _debitCard;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_debitCard != null) {
//       map['DebitCard'] = _debitCard?.toJson();
//     }
//     return map;
//   }
//
// }

/// CardNumber : 5544

class DebitCard {
  DebitCard({
    int? cardNumber,}) {
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