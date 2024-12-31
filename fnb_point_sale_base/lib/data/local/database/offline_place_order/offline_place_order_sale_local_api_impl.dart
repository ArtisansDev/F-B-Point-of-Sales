import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import '../../../mode/cart_item/order_place.dart';
import '../../../mode/order_place/process_multiple_orders_request.dart';
import 'offline_place_order_sale_local_api.dart';

class OfflinePlaceOrderSaleLocalApiImpl extends OfflinePlaceOrderSaleLocalApi {
  final String _boxName = "offline_place_order_sale";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(
      ProcessMultipleOrdersRequest mProcessMultipleOrdersRequest) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mProcessMultipleOrdersRequest.toJson());
  }

  @override
  Future<ProcessMultipleOrdersRequest?> getAllPlaceOrderSale() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      ProcessMultipleOrdersRequest? mProcessMultipleOrdersRequest =
          ProcessMultipleOrdersRequest.fromJson(decoded);
      return Future.value(mProcessMultipleOrdersRequest);
    }

    return Future.value(null);
  }

  @override
  Future<int> getPlaceOrderSaleCount() async {
    ProcessMultipleOrdersRequest? mProcessMultipleOrdersRequest =
        await getAllPlaceOrderSale();
    return (mProcessMultipleOrdersRequest?.orderDetailList ?? []).length;
  }

  @override
  Future<bool> getPlaceOrderDelete(String sOrderNo) async {
    bool value = false;
    // ProcessMultipleOrdersRequest? mProcessMultipleOrdersRequest = await getAllPlaceOrderSale();
    // (mProcessMultipleOrdersRequest?.orderDetailList ?? []).length;
    // for (int i = 0; i < (mProcessMultipleOrdersRequest?.mOrderPlace ?? []).length; i++) {
    //   if ((mProcessMultipleOrdersRequest?.mOrderPlace ?? [])[i].sOrderNo.toString() ==
    //       sOrderNo) {
    //     (mProcessMultipleOrdersRequest?.mOrderPlace ?? []).removeAt(i);
    //     save(mProcessMultipleOrdersRequest ?? ProcessMultipleOrdersRequest());
    //     return true;
    //   }
    // }
    return value;
  }

  @override
  Future<void> getPlaceOrderAdd(OrderDetailList mOrderDetailList) async {
    ProcessMultipleOrdersRequest? mProcessMultipleOrdersRequest =
        await getAllPlaceOrderSale();
    (mProcessMultipleOrdersRequest?.orderDetailList ?? []).length;
    mProcessMultipleOrdersRequest?.orderDetailList?.add(mOrderDetailList);
    save(mProcessMultipleOrdersRequest ?? ProcessMultipleOrdersRequest());
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
