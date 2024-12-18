import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../mode/product/get_all_category/get_all_category_response.dart';
import 'all_category_local_api.dart';


class AllCategoryLocalApiImpl extends AllCategoryLocalApi {
  final String _boxName = "all_category";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> saveAllCategoryResponse(GetAllCategoryResponse allCategoryResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, allCategoryResponse.toJson());
  }

  @override
  Future<GetAllCategoryResponse?> getAllCategoryResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      GetAllCategoryResponse? allCategoryResponse = GetAllCategoryResponse.fromJson(decoded);
      return Future.value(allCategoryResponse);
    }

    return Future.value(null);
  }

  @override
  Future<bool> deleteAllCategory() async {
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
