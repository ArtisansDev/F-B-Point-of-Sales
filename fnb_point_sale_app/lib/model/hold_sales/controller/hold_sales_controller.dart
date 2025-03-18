// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/table_status_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../../menu_table/controller/table_controller.dart';

class HoldSalesController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rxn<HoldSaleModel> mHoldSaleModel = Rxn<HoldSaleModel>();
  var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
  TopBarController mTopBarController = Get.find<TopBarController>();
  RxBool cancel = false.obs;

  getAllHoldSale() async {
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
  }

  void onDeleteAll() async {
    HoldSaleModel mHoldSaleModelValue =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();

    for (OrderPlace mOrderPlace in mHoldSaleModelValue.mOrderPlace ?? []) {
      ///clear table
      if ((mOrderPlace.tableNo ?? "").isNotEmpty &&
          !(mOrderPlace.orderHistory)) {
        TablesByTableStatusData mTablesByTableStatusData =
            TablesByTableStatusData(
          occupiedTrackingOrderID: mOrderPlace.sOrderNo ?? '',
          occupiedOrderID: mOrderPlace.sOrderNo ?? '',
          seatIDP: mOrderPlace.seatIDP ?? '',
        );
        await callUpdateTableStatus(mTablesByTableStatusData);
      }
    }

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

  void onDeleteHoldSale(int index, OrderPlace mOrderPlace) async {
    ///clear table
    if ((mOrderPlace.tableNo ?? "").isNotEmpty && !(mOrderPlace.orderHistory)) {
      TablesByTableStatusData mTablesByTableStatusData =
          TablesByTableStatusData(
        occupiedTrackingOrderID: mOrderPlace.sOrderNo ?? '',
        occupiedOrderID: mOrderPlace.sOrderNo ?? '',
        seatIDP: mOrderPlace.seatIDP ?? '',
      );
      await callUpdateTableStatus(mTablesByTableStatusData);
    }

    ///hold sale delete
    await holdSaleLocalApi.getHoldSaleDelete(mOrderPlace.sOrderNo);
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
    await mDashboardScreenController.onUpdateHoldSale();
  }

  ///update table status
  callUpdateTableStatus(
      TablesByTableStatusData mTablesByTableStatusData) async {
    ///api product call
    final orderPlaceApi = locator.get<OrderPlaceApi>();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        TableStatusRequest mTableStatusRequest = TableStatusRequest(
            trackingOrderID:
                mTablesByTableStatusData.occupiedTrackingOrderID ?? '',
            tableStatus: 'A',
            seatIDP: mTablesByTableStatusData.seatIDP,
            userIDF: await SharedPrefs().getUserId());

        WebResponseSuccess mWebResponseSuccess =
            await orderPlaceApi.postTableStatus(mTableStatusRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          await mTopBarController.callGetAllTableStatus();
          if (Get.isRegistered<TableController>()) {
            if (mDashboardScreenController.onUpdateTable.value != null) {
              mDashboardScreenController.onUpdateTable.value!();
            }
          }
        } else {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}
