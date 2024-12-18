// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class TableSelectController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> enterNameController = TextEditingController().obs;
  Rx<TextEditingController> sTableNoController = TextEditingController().obs;
  Rx<TextEditingController> sPhoneNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> scheduleController = TextEditingController().obs;
  Rx<TextEditingController> notesController = TextEditingController().obs;
  RxBool isDineIn = true.obs;
  RxString orderNumber = '1234567890'.obs;
  RxBool isCreateOrder = false.obs;

  TableSelectController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    isCreateOrder.value = false;
    orderNumber.value = getRandomNumber();
  }

  void onCreateOrder() {
    isCreateOrder.value = true;
    Get.back();
  }

  Rxn<String> sTableNumber = Rxn<String>();

  void setTableNumber(String? tableNumber) {
    sTableNumber.value = tableNumber;
    if (sTableNumber.value != null) {
      sTableNoController.value.text = tableNumber ?? '';
      sTableNoController.refresh();
    }
  }
}
