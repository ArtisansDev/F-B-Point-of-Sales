import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/cart_item/order_place.dart';
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import 'hold_sale_local_api.dart';
import 'hold_sale_model.dart';

class HoldSaleLocalApiImpl extends HoldSaleLocalApi {
  final String _boxName = "hold_sale";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(HoldSaleModel mHoldSaleModel) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mHoldSaleModel.toJson());
  }

  @override
  Future<HoldSaleModel?> getAllHoldSale() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      HoldSaleModel? mHoldSaleModel = HoldSaleModel.fromJson(decoded);
      return Future.value(mHoldSaleModel);
    }

    return Future.value(null);
  }

  @override
  Future<int> getHoldSaleCount() async {
    HoldSaleModel? mHoldSaleModel = await getAllHoldSale();
    return (mHoldSaleModel?.mOrderPlace ?? []).length;
  }

  @override
  Future<bool> getHoldSaleDelete(String sOrderNo) async {
    bool value = false;
    HoldSaleModel? mHoldSaleModel = await getAllHoldSale();
    (mHoldSaleModel?.mOrderPlace ?? []).length;
    for (int i = 0; i < (mHoldSaleModel?.mOrderPlace ?? []).length; i++) {
      if ((mHoldSaleModel?.mOrderPlace ?? [])[i].sOrderNo.toString() ==
          sOrderNo) {
        (mHoldSaleModel?.mOrderPlace ?? []).removeAt(i);
        save(mHoldSaleModel ?? HoldSaleModel());
        return true;
      }
    }
    return value;
  }

  @override
  Future<void> getHoldSaleEdit(OrderPlace mOrderPlace) async {
    HoldSaleModel? mHoldSaleModel = await getAllHoldSale();
    (mHoldSaleModel?.mOrderPlace ?? []).length;
    for (int i = 0; i < (mHoldSaleModel?.mOrderPlace ?? []).length; i++) {
      if ((mHoldSaleModel?.mOrderPlace ?? [])[i].sOrderNo.toString() ==
          mOrderPlace.sOrderNo.toString()) {
        (mHoldSaleModel?.mOrderPlace ?? []).removeAt(i);
        break;
      }
    }
    mHoldSaleModel?.mOrderPlace?.add(mOrderPlace);
    save(mHoldSaleModel ?? HoldSaleModel());
  }

  @override
  Future<bool> deleteAllHoldSale() async {
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
