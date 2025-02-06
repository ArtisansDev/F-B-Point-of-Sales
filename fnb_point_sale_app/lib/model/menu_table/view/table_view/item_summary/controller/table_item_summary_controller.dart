// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../../menu_sales/view/item_payment_screen/controller/item_payment_screen_controller.dart';
import '../../../../../menu_sales/view/item_payment_screen/view/item_payment_screen.dart';
import '../../../../controller/table_controller.dart';

class TableItemSummaryController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  TableController mTableController = Get.find<TableController>();

  // MenuSalesController mMenuSalesController = Get.find<MenuSalesController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rx<OrderHistoryData> mOrderPlace = OrderHistoryData().obs;
  RxInt index = (-1).obs;

  TableItemSummaryController(OrderHistoryData mOrder, int iIndex) {
    index.value = iIndex;
    mOrderPlace.value = mOrder;
    remarkController.value.text =
        (mOrderPlace.value.additionalNotes ?? '').isEmpty
            ? 'No remark'
            : (mOrderPlace.value.additionalNotes ?? '');
    remarkController.refresh();
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onCancelOrder() {
    AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Cancel Order!',
        'Are you sure you want to cancel this order?', () async {
      Get.back();
      await mTableController.orderCancelPayment(mOrderPlace.value);
    }, rightText: 'Yes');
  }

  void onPayment() async {
    Get.back();
    await AppAlert.showViewWithoutBlur(
        Get.context!,
        ItemPaymentScreen(
          mOrderPlace.value,
          onPayment: (GetAllPaymentTypeData mGetAllPaymentTypeData,
              GetAllCustomerList? mGetAllCustomerList) {
            Get.back();
            mTableController.orderPayment(
                mGetAllPaymentTypeData, mOrderPlace.value, mGetAllCustomerList);
          },
        ),
        barrierDismissible: true);
    if (Get.isRegistered<ItemPaymentScreenController>()) {
      Get.delete<ItemPaymentScreenController>();
    }
  }

  void addMore() async {
    await allOrderPlace();
    ///get OrderPlace
    OrderPlace mSelectOrderPlace =
        getOrderPlace(mOrderPlace.value.seatIDF ?? '');

    ///
    if ((mSelectOrderPlace.sOrderNo ?? '').isNotEmpty) {
      mDashboardScreenController.value?.mOrderPlace.value =
          getOrderPlace(mOrderPlace.value.seatIDF ?? '');
      if ((mDashboardScreenController.value?.mOrderPlace.value?.cartItem ?? [])
          .isNotEmpty) {
        mDashboardScreenController.value?.mOrderHistoryPlace.value = null;
        Get.back();
        mDashboardScreenController.value?.selectMenu.value = 0;
        mDashboardScreenController.value?.selectMenu.refresh();
      } else {
        mDashboardScreenController.value?.mOrderPlace.value = null;
        mDashboardScreenController.value?.mOrderHistoryPlace.value =
            mOrderPlace.value;
        Get.back();
        mDashboardScreenController.value?.selectMenu.value = 0;
        mDashboardScreenController.value?.selectMenu.refresh();
      }
    }
  }

  Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
  var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

  allOrderPlace() async {
    mPlaceOrderSaleModel.value =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
  }

  OrderPlace getOrderPlace(String sSeatIDP) {
    OrderPlace mOrderPlace = OrderPlace();
    if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? []).isEmpty) {
      return mOrderPlace;
    }
    int? value = mPlaceOrderSaleModel.value?.mOrderPlace?.indexWhere(
      (element) => element.seatIDP.toString() == sSeatIDP.toString(),
    );
    if ((value ?? -1) == -1) {
      return mOrderPlace;
    } else {
      mOrderPlace =
          mPlaceOrderSaleModel.value?.mOrderPlace?[value ?? -1] ?? OrderPlace();
      return mOrderPlace;
    }
  }
}
