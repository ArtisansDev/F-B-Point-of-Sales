import 'dart:convert';

import 'package:fnb_point_sale_base/data/local/database/payment_type/payment_type_local_api.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/product/get_all_payment_type/get_all_payment_type_response.dart';


class PaymentTypeLocalApiImpl extends PaymentTypeLocalApi {
  final String _boxName = "payment_type";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(GetAllPaymentTypeResponse mGetAllPaymentTypeResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mGetAllPaymentTypeResponse.toJson());
  }

  @override
  Future<GetAllPaymentTypeResponse?> getPaymentTypeResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      GetAllPaymentTypeResponse? mGetAllPaymentTypeResponse = GetAllPaymentTypeResponse.fromJson(decoded);
      return Future.value(mGetAllPaymentTypeResponse);
    }
    return Future.value(null);
  }

  @override
  Future<bool> deleteAllPaymentType() async {
    Box<dynamic> box = await _getBox();
    await box.delete(_boxName);
    return true;
  }

  @override
  Future<void> clearBox() async {
    var box = await _getBox();
    await box.deleteFromDisk();
  }
  
}
