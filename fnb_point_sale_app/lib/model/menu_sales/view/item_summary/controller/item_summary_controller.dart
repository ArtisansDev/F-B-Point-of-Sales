// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/view/payment_screen.dart';
import '../../../controller/menu_sales_controller.dart';
import '../../item_payment_screen/controller/item_payment_screen_controller.dart';
import '../../item_payment_screen/view/item_payment_screen.dart';

class ItemSummaryController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  MenuSalesController mMenuSalesController = Get.find<MenuSalesController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rx<OrderHistoryData> mOrderPlace = OrderHistoryData().obs;
  RxInt index = (-1).obs;

  ItemSummaryController(OrderHistoryData mOrder, int iIndex) {
    index.value = iIndex;
    mOrderPlace.value = mOrder;
    remarkController.value.text = mOrderPlace.value.additionalNotes ?? 'No Remark';
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onCancelOrder() async {
    AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Cancel Order!',
        'Are you sure you want to cancel this order?', () {
          Get.back();
          mMenuSalesController.orderCancelPayment(mOrderPlace.value);
        },
        rightText: 'Yes');
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
            mMenuSalesController.orderPayment(
                mGetAllPaymentTypeData, mOrderPlace.value, mGetAllCustomerList);
          },
        ),
        barrierDismissible: true);
    if (Get.isRegistered<ItemPaymentScreenController>()) {
      Get.delete<ItemPaymentScreenController>();
    }
  }

// void addMore() {
//   mDashboardScreenController.value?.mOrderPlace.value =
//       mOrderPlace.value;
//   Get.back();
//   mDashboardScreenController.value!.selectMenu.value = 0;
//   mDashboardScreenController.value!.selectMenu.refresh();
// }
}
