import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import '../../../mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'menu_item_local_api.dart';

class MenuItemLocalApiImpl extends MenuItemLocalApi {
  final String _boxName = "menu_item_list";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(MenuItemResponse mMenuItemResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mMenuItemResponse.toJson());
  }

  @override
  Future<MenuItemResponse?> getMenuItemResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      MenuItemResponse? mMenuItemResponse = MenuItemResponse.fromJson(decoded);
      return Future.value(mMenuItemResponse);
    }

    return Future.value(null);
  }

  @override
  Future<List<MenuItemData>?> getMenuItemData(String categoryIDP) async {
    if (categoryIDP.isEmpty) {
      return [];
    }
    MenuItemResponse mMenuItemResponse =
        await getMenuItemResponse() ?? MenuItemResponse();
    List<MenuItemData> selectMenuItem = [];
    if ((mMenuItemResponse.data ?? []).isNotEmpty) {
      for (MenuItemData mMenuItemData in (mMenuItemResponse.data ?? [])) {
        String sValue = jsonEncode(mMenuItemData.categoryIDs ?? []);
        debugPrint("MenuList $sValue == $categoryIDP");
        if (sValue.contains(categoryIDP)) {
          selectMenuItem.add(mMenuItemData);
        }
      }
    }
    return selectMenuItem;
  }

  @override
  Future<List<MenuItemData>?> getMenuItemDataSearch(String name) async {
    if (name.isEmpty) {
      return [];
    }
    MenuItemResponse mMenuItemResponse =
        await getMenuItemResponse() ?? MenuItemResponse();
    List<MenuItemData> selectMenuItem = [];
    if ((mMenuItemResponse.data ?? []).isNotEmpty) {
      for (MenuItemData mMenuItemData in (mMenuItemResponse.data ?? [])) {
        String sValueMenuItemIDP =
            jsonEncode(mMenuItemData.menuItemIDP ?? []).toLowerCase();
        String sValueName =
            jsonEncode(mMenuItemData.itemName ?? []).toLowerCase();
        debugPrint("MenuList $sValueMenuItemIDP == $name");
        debugPrint("MenuList $sValueName == $name");
        if (sValueMenuItemIDP.contains(name) || sValueName.contains(name)) {
          selectMenuItem.add(mMenuItemData);
        }
      }
    }
    return selectMenuItem;
  }

  @override
  Future<List<MenuItemData>?> getMenuItemIdSearch(String name) async {
    if (name.isEmpty) {
      return [];
    }
    MenuItemResponse mMenuItemResponse =
        await getMenuItemResponse() ?? MenuItemResponse();
    List<MenuItemData> selectMenuItem = [];
    if ((mMenuItemResponse.data ?? []).isNotEmpty) {
      for (MenuItemData mMenuItemData in (mMenuItemResponse.data ?? [])) {
        String sValueMenuItemIDP =
            jsonEncode(mMenuItemData.menuItemIDP ?? []).toLowerCase();
        debugPrint("MenuList $sValueMenuItemIDP == $name");
        if (sValueMenuItemIDP.contains(name)) {
          selectMenuItem.add(mMenuItemData);
        }
      }
    }
    return selectMenuItem;
  }

  @override
  Future<MenuItemData?> getMenuItemSearch(String name) async {
    if (name.isEmpty) {
      return null;
    }
    MenuItemResponse mMenuItemResponse =
        await getMenuItemResponse() ?? MenuItemResponse();
    MenuItemData mMenuItemData = (mMenuItemResponse.data ?? []).firstWhere(
        (user) =>
            user.menuItemIDP.toString().toLowerCase() == name.toLowerCase());
    return mMenuItemData;
  }

  @override
  Future<bool> deleteAllMenuItem() async {
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
