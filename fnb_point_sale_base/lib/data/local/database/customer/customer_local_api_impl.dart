import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/customer/get_all_customer/get_all_customer_response.dart';
import 'customer_local_api.dart';

class CustomerLocalApiImpl extends CustomerLocalApi {
  final String _boxName = "customer_local";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(GetAllCustomerResponse mGetAllCustomerResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mGetAllCustomerResponse.toJson());
  }

  @override
  Future<GetAllCustomerResponse?> getAllCustomerResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      GetAllCustomerResponse? mGetAllCustomerResponse = GetAllCustomerResponse.fromJson(decoded);
      return Future.value(mGetAllCustomerResponse);
    }

    return Future.value(null);
  }
  
  @override
  Future<bool> deleteAllCustomerResponse() async {
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
