import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  Future<void> saveAllCategoryResponse(
      GetAllCategoryResponse allCategoryResponse) async {
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
      GetAllCategoryResponse? allCategoryResponse =
          GetAllCategoryResponse.fromJson(decoded);
      return Future.value(allCategoryResponse);
    }

    return Future.value(null);
  }

  @override
  Future<List<GetAllCategoryData>?> getCategoryListSearch(String name) async {
    GetAllCategoryResponse mGetAllCategoryResponse =
        await getAllCategoryResponse() ?? GetAllCategoryResponse();
    List<GetAllCategoryData> selectGetAllCategoryData = [];
    if ((mGetAllCategoryResponse.mGetAllCategoryData ?? []).isEmpty) {
      return selectGetAllCategoryData;
    } else if (name.isEmpty) {
      return (mGetAllCategoryResponse.mGetAllCategoryData ?? []);
    } else {
      for (GetAllCategoryData mGetAllCategoryData
          in (mGetAllCategoryResponse.mGetAllCategoryData ?? [])) {
        String sValueName =
            jsonEncode(mGetAllCategoryData.categoryName ?? []).toLowerCase();
        debugPrint("Category $sValueName == $name");
        if (sValueName.contains(name)) {
          selectGetAllCategoryData.add(mGetAllCategoryData);
        }
        ///sub
        for (GetAllCategoryData mGetAllCategoryData
            in mGetAllCategoryData.subCategories ?? []) {
          String sValueName =
              jsonEncode(mGetAllCategoryData.categoryName ?? []).toLowerCase();
          debugPrint("Category $sValueName == $name");
          if (sValueName.contains(name)) {
            selectGetAllCategoryData.add(mGetAllCategoryData);
          }
          ///sub
          for (GetAllCategoryData mGetAllCategoryData
              in mGetAllCategoryData.subCategories ?? []) {
            String sValueName =
                jsonEncode(mGetAllCategoryData.categoryName ?? [])
                    .toLowerCase();
            debugPrint("Category $sValueName == $name");
            if (sValueName.contains(name)) {
              selectGetAllCategoryData.add(mGetAllCategoryData);
            }
            ///sub
            for (GetAllCategoryData mGetAllCategoryData
                in mGetAllCategoryData.subCategories ?? []) {
              String sValueName =
                  jsonEncode(mGetAllCategoryData.categoryName ?? [])
                      .toLowerCase();
              debugPrint("Category $sValueName == $name");
              if (sValueName.contains(name)) {
                selectGetAllCategoryData.add(mGetAllCategoryData);
              }
            }
          }
        }
      }
    }

    return selectGetAllCategoryData;
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
