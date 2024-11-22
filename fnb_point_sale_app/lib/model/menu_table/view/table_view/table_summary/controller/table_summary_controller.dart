// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';
import '../../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../../payment_screen/view/payment_screen.dart';
import '../../../../controller/table_controller.dart';

class TableSummaryController extends GetxController {
  Rxn<TableController> mTableController = Rxn<TableController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  TableSummaryController() {
    if (Get.isRegistered<TableController>()) {
      mTableController.value = Get.find<TableController>();
    }
  }

  void onPayment() async {
    Get.back();
    await AppAlert.showView(Get.context!, const PaymentScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }

  void addMore() {
    Get.back();
    mTableController.value?.mDashboardScreenController.selectMenu.value = 0;
    mTableController.value?.mDashboardScreenController.selectMenu.refresh();
  }
}
