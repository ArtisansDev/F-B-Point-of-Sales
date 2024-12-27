/*
 * Project      : my_coffee
 * File         : order_place_share.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-25
 * Version      : 1.0
 * Ticket       : 
 */


class OrderPlaceShare {
  OrderPlaceShare({
    this.paymentGatewayNo,
    this.data,});

  OrderPlaceShare.fromJson(dynamic json) {
    paymentGatewayNo = json['paymentGatewayNo'];
    data = json['data'];
  }
  String? paymentGatewayNo;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paymentGatewayNo'] = paymentGatewayNo;
    map['data'] = data;
    return map;
  }

}