import 'package:fnb_point_sale_base/utils/num_utils.dart';

/// Name : "Cash"
/// PaymentGatewayNo : 0
/// TotalCount : 24
/// SuccessCount : 24
/// RefundCount : 1
/// CancelCount : 0
/// TotalPaidAmount : 3331.3
/// TotalRefundAmount : 145.2
/// NetAmount : 3186.1

class PaymentTypeData {
  PaymentTypeData({
      String? name, 
      int? paymentGatewayNo, 
      int? totalCount, 
      int? successCount, 
      int? refundCount, 
      int? cancelCount, 
      double? totalPaidAmount, 
      double? totalRefundAmount, 
      double? netAmount,}){
    _name = name;
    _paymentGatewayNo = paymentGatewayNo;
    _totalCount = totalCount;
    _successCount = successCount;
    _refundCount = refundCount;
    _cancelCount = cancelCount;
    _totalPaidAmount = totalPaidAmount;
    _totalRefundAmount = totalRefundAmount;
    _netAmount = netAmount;
}

  PaymentTypeData.fromJson(dynamic json) {
    _name = json['Name'];
    _paymentGatewayNo = json['PaymentGatewayNo'];
    _totalCount = json['TotalCount'];
    _successCount = json['SuccessCount'];
    _refundCount = json['RefundCount'];
    _cancelCount = json['CancelCount'];
    _totalPaidAmount = getDoubleValue(json['TotalPaidAmount']);
    _totalRefundAmount = getDoubleValue(json['TotalRefundAmount']);
    _netAmount = getDoubleValue(json['NetAmount']);
  }
  String? _name;
  int? _paymentGatewayNo;
  int? _totalCount;
  int? _successCount;
  int? _refundCount;
  int? _cancelCount;
  double? _totalPaidAmount;
  double? _totalRefundAmount;
  double? _netAmount;

  String? get name => _name;
  int? get paymentGatewayNo => _paymentGatewayNo;
  int? get totalCount => _totalCount;
  int? get successCount => _successCount;
  int? get refundCount => _refundCount;
  int? get cancelCount => _cancelCount;
  double? get totalPaidAmount => _totalPaidAmount;
  double? get totalRefundAmount => _totalRefundAmount;
  double? get netAmount => _netAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['PaymentGatewayNo'] = _paymentGatewayNo;
    map['TotalCount'] = _totalCount;
    map['SuccessCount'] = _successCount;
    map['RefundCount'] = _refundCount;
    map['CancelCount'] = _cancelCount;
    map['TotalPaidAmount'] = _totalPaidAmount;
    map['TotalRefundAmount'] = _totalRefundAmount;
    map['NetAmount'] = _netAmount;
    return map;
  }

}