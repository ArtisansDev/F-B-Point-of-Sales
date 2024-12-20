import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import '../../../mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'modifier_local_api.dart';


class ModifierLocalApiImpl extends ModifierLocalApi {
  final String _boxName = "modifier_list";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(GetAllModifierResponse mGetAllModifierResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mGetAllModifierResponse.toJson());
  }

  @override
  Future<GetAllModifierResponse?> getModifierResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      GetAllModifierResponse? mGetAllModifierResponse = GetAllModifierResponse.fromJson(decoded);
      return Future.value(mGetAllModifierResponse);
    }

    return Future.value(null);
  }

  @override
  Future<List<ModifierList>?> getModifierList(List<ModifierIDs> sModifierIDs) async{
    if (sModifierIDs.isEmpty) {
      return [];
    }
    GetAllModifierResponse mGetAllModifierResponse =
        await getModifierResponse() ?? GetAllModifierResponse();
    List<ModifierList> selectModifier = [];
    String sValue = jsonEncode(sModifierIDs ?? []);
      for (ModifierList mModifierList in (mGetAllModifierResponse.data ?? [])) {
        String sModifierIDP = mModifierList.modifierIDP ??"" ;
        debugPrint("##ModifierList $sModifierIDP == $sValue");
        if (sValue.contains(sModifierIDP)) {
          selectModifier.add(mModifierList);
        }
      }
    return selectModifier;
  }

  @override
  Future<bool> deleteAllModifier() async {
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
