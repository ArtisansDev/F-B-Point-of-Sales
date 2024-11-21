// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class CancelOrderController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  CancelOrderController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onCancel() {
    Get.back();
  }
}
