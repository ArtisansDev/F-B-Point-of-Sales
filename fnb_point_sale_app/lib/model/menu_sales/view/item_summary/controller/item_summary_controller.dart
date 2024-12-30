// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/view/payment_screen.dart';

class ItemSummaryController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rx<OrderHistoryData> mOrderPlace = OrderHistoryData().obs;

  ItemSummaryController(OrderHistoryData mOrder) {
    mOrderPlace.value = mOrder;
    // remarkController.value.text = mOrderPlace.value.remarkController ?? '';
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onPayment() async {
    Get.back();
    // await AppAlert.showView(
    //     Get.context!, PaymentScreen(mOrderPlace.value ?? OrderPlace()),
    //     barrierDismissible: true);
    // if (Get.isRegistered<PaymentScreenController>()) {
    //   Get.delete<PaymentScreenController>();
    // }
  }

// void addMore() {
//   mDashboardScreenController.value?.mOrderPlace.value =
//       mOrderPlace.value;
//   Get.back();
//   mDashboardScreenController.value!.selectMenu.value = 0;
//   mDashboardScreenController.value!.selectMenu.refresh();
// }
}
