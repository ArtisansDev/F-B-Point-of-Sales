// ignore_for_file: depend_on_referenced_packages

import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class HoldSalesController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rxn<HoldSaleModel> mHoldSaleModel = Rxn<HoldSaleModel>();
  var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
  getAllHoldSale() async {
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
  }

  void onDeleteAll() async{
    await holdSaleLocalApi.deleteAllHoldSale();
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
    await mDashboardScreenController.onUpdateHoldSale();
  }

  void onEditHoldSale(int index, OrderPlace mOrderPlace) {
    mDashboardScreenController.mOrderPlace.value = mOrderPlace;
    mDashboardScreenController.mOrderPlace.refresh();
    Get.back();
  }

  void onDeleteHoldSale(int index, OrderPlace mOrderPlace) async{
    await holdSaleLocalApi.getHoldSaleDelete(mOrderPlace.sOrderNo);
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
    await mDashboardScreenController.onUpdateHoldSale();
  }
}
