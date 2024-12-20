// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/view/payment_screen.dart';
import '../../../../table_select/controller/table_select_controller.dart';
import '../../../../table_select/view/table_select_screen.dart';
import '../../../controller/home_controller.dart';
import '../../../home_base_controller/home_base_controller.dart';

class SelectedOrderController extends HomeBaseController {
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  SelectedOrderController() {
    mSelectedOrderController.value = this;
  }

  void onPayment() async {
    await AppAlert.showView(Get.context!, const PaymentScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }

  onSelectOrder() async {
    // await AppAlert.showView(
    //     Get.context!,
    //     const TableSelectScreen(tableNumber: null,),
    //     barrierDismissible: true);
    // if (Get.isRegistered<TableSelectController>()) {
    //   Get.delete<TableSelectController>();
    // }
  }

  @override
  void onClose() {
    ///delete all sub Controller
    super.onClose();
  }
}
