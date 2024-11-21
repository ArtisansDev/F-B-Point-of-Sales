// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class PaymentScreenController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  PaymentScreenController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  RxList<String> paymentType = ['Affin Terminal','Google Pay','Booking Payment','Credit Card'].obs;

  void onPrint() {
    Get.back();
  }
}
