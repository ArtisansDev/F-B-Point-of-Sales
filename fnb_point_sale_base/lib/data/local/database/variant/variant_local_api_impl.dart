import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/data/local/database/variant/variant_local_api.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/product/get_all_variant/get_all_variant_response.dart';

class VariantLocalApiImpl extends VariantLocalApi {
  final String _boxName = "variant_list";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(GetAllVariantResponse mGetAllVariantResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mGetAllVariantResponse.toJson());
  }

  @override
  Future<GetAllVariantResponse?> getVariantResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      GetAllVariantResponse? mGetAllVariantResponse =
          GetAllVariantResponse.fromJson(decoded);
      return Future.value(mGetAllVariantResponse);
    }

    return Future.value(null);
  }

  @override
  Future<List<VariantListData>?> getVariantList(String sMenuItemIDF) async {
    if (sMenuItemIDF.isEmpty) {
      return [];
    }
    GetAllVariantResponse mGetAllVariantResponse =
        await getVariantResponse() ?? GetAllVariantResponse();
    List<VariantListData> selectVariant = [];
    if ((mGetAllVariantResponse.data ?? []).isNotEmpty) {
      for (VariantListData mVariantListData
          in (mGetAllVariantResponse.data ?? [])) {
        String sValue = mVariantListData.menuItemIDF??'';
        debugPrint("VariantList $sValue == $sMenuItemIDF");
        if (sValue.contains(sMenuItemIDF)) {
          selectVariant.add(mVariantListData);
        }
      }
    }
    return selectVariant;
  }

  @override
  Future<bool> deleteAllVariant() async {
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
