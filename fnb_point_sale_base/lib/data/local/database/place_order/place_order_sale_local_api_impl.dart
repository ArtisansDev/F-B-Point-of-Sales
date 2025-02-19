import 'dart:convert';

import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/cart_item/order_place.dart';

class PlaceOrderSaleLocalApiImpl extends PlaceOrderSaleLocalApi {
  final String _boxName = "place_order_sale";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(PlaceOrderSaleModel mPlaceOrderSaleModel) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mPlaceOrderSaleModel.toJson());
  }

  @override
  Future<PlaceOrderSaleModel?> getAllPlaceOrderSale() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      PlaceOrderSaleModel? mPlaceOrderSaleModel = PlaceOrderSaleModel.fromJson(
          decoded);
      return Future.value(mPlaceOrderSaleModel);
    }

    return Future.value(null);
  }

  @override
  Future<int> getPlaceOrderSaleCount() async {
    PlaceOrderSaleModel? mPlaceOrderSaleModel = await getAllPlaceOrderSale();
    return (mPlaceOrderSaleModel?.mOrderPlace ?? []).length;
  }

  @override
  Future<bool> getPlaceOrderDelete(String sOrderNo) async {
    bool value = false;
    PlaceOrderSaleModel? mPlaceOrderSaleModel = await getAllPlaceOrderSale();
    (mPlaceOrderSaleModel?.mOrderPlace ?? []).length;
    for (int i = 0; i < (mPlaceOrderSaleModel?.mOrderPlace ?? []).length; i++) {
      if ((mPlaceOrderSaleModel?.mOrderPlace ?? [])[i].sOrderNo.toString() ==
          sOrderNo) {
        (mPlaceOrderSaleModel?.mOrderPlace ?? []).removeAt(i);
        save(mPlaceOrderSaleModel ?? PlaceOrderSaleModel());
        return true;
      }
    }
    return value;
  }

  @override
  Future<void> getPlaceOrderSaleEdit(OrderPlace mOrderPlace) async {
    PlaceOrderSaleModel? mPlaceOrderSaleModel = await getAllPlaceOrderSale();
    (mPlaceOrderSaleModel?.mOrderPlace ?? []).length;
    for (int i = 0; i < (mPlaceOrderSaleModel?.mOrderPlace ?? []).length; i++) {
      if ((mPlaceOrderSaleModel?.mOrderPlace ?? [])[i].sOrderNo.toString() ==
          mOrderPlace.sOrderNo.toString()) {
        (mPlaceOrderSaleModel?.mOrderPlace ?? [])[i] = mOrderPlace;
        break;
      }
    }
    save(mPlaceOrderSaleModel ?? PlaceOrderSaleModel());
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
