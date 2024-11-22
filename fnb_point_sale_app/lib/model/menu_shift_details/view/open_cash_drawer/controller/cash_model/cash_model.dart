/*
 * Project      : fnb_point_sale_app
 * File         : cash_model.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-22
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/cupertino.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// amount : 0.05
/// qty : 1
/// total_amount : 0.05

class CashModel {
  CashModel({
    this.amount,
    this.qty,
    this.totalAmount,
  });

  CashModel.fromJson(dynamic json) {
    amount = getDoubleValue(json['amount']);
    qty = json['qty'];
    totalAmount = getDoubleValue(json['total_amount']);
  }
  Rx<TextEditingController> qtyController = TextEditingController().obs;
  double? amount;
  int? qty;
  double? totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['qty'] = qty;
    map['total_amount'] = totalAmount;
    return map;
  }
}
