// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/view/payment_screen.dart';
import '../../../controller/home_controller.dart';

class SelectedOrderController extends GetxController {
  Rxn<HomeController> mHomeController = Rxn<HomeController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  SelectedOrderController(){
    if (Get.isRegistered<HomeController>()) {
      mHomeController.value = Get.find<HomeController>();
    }
  }

  void onPayment() async{
    await AppAlert.showView(Get.context!, const PaymentScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }


}
