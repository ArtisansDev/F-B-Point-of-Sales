import 'dart:convert';

import 'package:fnb_point_sale_base/data/local/database/table_list/table_list_local_api.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/product/get_all_tables/get_all_tables_response.dart';


class TableListLocalApiImpl extends TableListLocalApi {
  final String _boxName = "table_list";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(GetAllTablesResponse mGetAllTablesResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mGetAllTablesResponse.toJson());
  }

  @override
  Future<GetAllTablesResponse?> getTablesListResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      GetAllTablesResponse? mGetAllTablesResponse = GetAllTablesResponse.fromJson(decoded);
      return Future.value(mGetAllTablesResponse);
    }
    return Future.value(null);
  }

  @override
  Future<bool> deleteAllTablesList() async {
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
