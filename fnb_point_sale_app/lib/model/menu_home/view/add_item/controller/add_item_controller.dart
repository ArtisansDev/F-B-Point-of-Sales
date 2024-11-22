// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../controller/home_controller.dart';

class AddItemController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rxn<HomeController> mHomeController = Rxn<HomeController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  AddItemController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    if (Get.isRegistered<HomeController>()) {
      mHomeController.value = Get.find<HomeController>();
    }
  }

  void onAddItem() {
    Get.back();
  }
}
