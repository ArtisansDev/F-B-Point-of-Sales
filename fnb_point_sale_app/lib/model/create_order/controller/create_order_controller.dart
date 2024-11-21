// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class CreateOrderController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> enterNameController = TextEditingController().obs;
  Rx<TextEditingController> sTableNoController = TextEditingController().obs;
  Rx<TextEditingController> sPhoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> scheduleController = TextEditingController().obs;
  Rx<TextEditingController> sDateToComeController = TextEditingController().obs;
  Rx<TextEditingController> sTimeToComeController = TextEditingController().obs;
  Rx<TextEditingController> notesController = TextEditingController().obs;
RxBool isDineIn = true.obs;
  CreateOrderController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onCreateOrder() {
    Get.back();
  }
}
