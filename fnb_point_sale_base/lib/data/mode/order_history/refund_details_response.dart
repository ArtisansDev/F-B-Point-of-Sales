import 'package:fnb_point_sale_base/utils/num_utils.dart';

/// RefundIDP : "1c996cfa-fb51-43c8-9da5-697bca11715e"
/// RefundStatus : "S"
/// RefundStatusText : "Success"
/// RefundTransactionID : ""
/// RefundResponseCode : "200"
/// RefundResponseMessage : "Refund processed successfully"
/// ReasonForRefund : "change amount"
/// RefundAmountTotal : 145.2
/// RefundedPayAmountCash : 145.2
/// RefundedDueAmountCash : 0.0
/// RefundedReturnAmountCash : 0.0
/// RefundedPaymentGatewayName : "Cash"
/// RefundedPaymentGatewayNo : "0"
/// RefundRequestDate : "31-03-2025 02:58 PM"
/// RefundProcessedDate : "31-03-2025 02:58 PM"
/// RefundedReferenceID : "12345AGDE-fFF                                                                                                                                                                                                                                             "
/// RefundedByFullName : "Pc Pc"
/// RefundedByFullNameGeneralManager : "prashant chauhan"

class RefundDetails {
  RefundDetails({
    String? refundIDP,
    String? refundStatus,
    String? refundStatusText,
    String? refundTransactionID,
    String? refundResponseCode,
    String? refundResponseMessage,
    String? reasonForRefund,
    double? refundAmountTotal,
    double? refundedPayAmountCash,
    double? refundedDueAmountCash,
    double? refundedReturnAmountCash,
    String? refundedPaymentGatewayName,
    String? refundedPaymentGatewayNo,
    String? refundRequestDate,
    String? refundProcessedDate,
    String? refundedReferenceID,
    String? refundedByFullName,
    String? refundedByFullNameGeneralManager,
  }) {
    _refundIDP = refundIDP;
    _refundStatus = refundStatus;
    _refundStatusText = refundStatusText;
    _refundTransactionID = refundTransactionID;
    _refundResponseCode = refundResponseCode;
    _refundResponseMessage = refundResponseMessage;
    _reasonForRefund = reasonForRefund;
    _refundAmountTotal = refundAmountTotal;
    _refundedPayAmountCash = refundedPayAmountCash;
    _refundedDueAmountCash = refundedDueAmountCash;
    _refundedReturnAmountCash = refundedReturnAmountCash;
    _refundedPaymentGatewayName = refundedPaymentGatewayName;
    _refundedPaymentGatewayNo = refundedPaymentGatewayNo;
    _refundRequestDate = refundRequestDate;
    _refundProcessedDate = refundProcessedDate;
    _refundedReferenceID = refundedReferenceID;
    _refundedByFullName = refundedByFullName;
    _refundedByFullNameGeneralManager = refundedByFullNameGeneralManager;
  }

  RefundDetails.fromJson(dynamic json) {
    _refundIDP = json['RefundIDP'];
    _refundStatus = json['RefundStatus'];
    _refundStatusText = json['RefundStatusText'];
    _refundTransactionID = json['RefundTransactionID'];
    _refundResponseCode = json['RefundResponseCode'];
    _refundResponseMessage = json['RefundResponseMessage'];
    _reasonForRefund = json['ReasonForRefund'];
    _refundAmountTotal = getDoubleValue(json['RefundAmountTotal']);
    _refundedPayAmountCash = getDoubleValue(json['RefundedPayAmountCash']);
    _refundedDueAmountCash = getDoubleValue(json['RefundedDueAmountCash']);
    _refundedReturnAmountCash =
        getDoubleValue(json['RefundedReturnAmountCash']);
    _refundedPaymentGatewayName = json['RefundedPaymentGatewayName'];
    _refundedPaymentGatewayNo = json['RefundedPaymentGatewayNo'];
    _refundRequestDate = json['RefundRequestDate'];
    _refundProcessedDate = json['RefundProcessedDate'];
    _refundedReferenceID = json['RefundedReferenceID'];
    _refundedByFullName = json['RefundedByFullName'];
    _refundedByFullNameGeneralManager =
        json['RefundedByFullNameGeneralManager'];
  }

  String? _refundIDP;
  String? _refundStatus;
  String? _refundStatusText;
  String? _refundTransactionID;
  String? _refundResponseCode;
  String? _refundResponseMessage;
  String? _reasonForRefund;
  double? _refundAmountTotal;
  double? _refundedPayAmountCash;
  double? _refundedDueAmountCash;
  double? _refundedReturnAmountCash;
  String? _refundedPaymentGatewayName;
  String? _refundedPaymentGatewayNo;
  String? _refundRequestDate;
  String? _refundProcessedDate;
  String? _refundedReferenceID;
  String? _refundedByFullName;
  String? _refundedByFullNameGeneralManager;

  String? get refundIDP => _refundIDP;

  String? get refundStatus => _refundStatus;

  String? get refundStatusText => _refundStatusText;

  String? get refundTransactionID => _refundTransactionID;

  String? get refundResponseCode => _refundResponseCode;

  String? get refundResponseMessage => _refundResponseMessage;

  String? get reasonForRefund => _reasonForRefund;

  double? get refundAmountTotal => _refundAmountTotal;

  double? get refundedPayAmountCash => _refundedPayAmountCash;

  double? get refundedDueAmountCash => _refundedDueAmountCash;

  double? get refundedReturnAmountCash => _refundedReturnAmountCash;

  String? get refundedPaymentGatewayName => _refundedPaymentGatewayName;

  String? get refundedPaymentGatewayNo => _refundedPaymentGatewayNo;

  String? get refundRequestDate => _refundRequestDate;

  String? get refundProcessedDate => _refundProcessedDate;

  String? get refundedReferenceID => _refundedReferenceID;

  String? get refundedByFullName => _refundedByFullName;

  String? get refundedByFullNameGeneralManager =>
      _refundedByFullNameGeneralManager;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RefundIDP'] = _refundIDP;
    map['RefundStatus'] = _refundStatus;
    map['RefundStatusText'] = _refundStatusText;
    map['RefundTransactionID'] = _refundTransactionID;
    map['RefundResponseCode'] = _refundResponseCode;
    map['RefundResponseMessage'] = _refundResponseMessage;
    map['ReasonForRefund'] = _reasonForRefund;
    map['RefundAmountTotal'] = _refundAmountTotal;
    map['RefundedPayAmountCash'] = _refundedPayAmountCash;
    map['RefundedDueAmountCash'] = _refundedDueAmountCash;
    map['RefundedReturnAmountCash'] = _refundedReturnAmountCash;
    map['RefundedPaymentGatewayName'] = _refundedPaymentGatewayName;
    map['RefundedPaymentGatewayNo'] = _refundedPaymentGatewayNo;
    map['RefundRequestDate'] = _refundRequestDate;
    map['RefundProcessedDate'] = _refundProcessedDate;
    map['RefundedReferenceID'] = _refundedReferenceID;
    map['RefundedByFullName'] = _refundedByFullName;
    map['RefundedByFullNameGeneralManager'] = _refundedByFullNameGeneralManager;
    return map;
  }
}
