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
  Rx<TextEditingController> sDateToComeController = TextEditingController().obs;
  Rx<TextEditingController> sTimeToComeController = TextEditingController().obs;
  Rx<TextEditingController> notesController = TextEditingController().obs;
  RxBool isDineIn = true.obs;
  RxString orderNumber = '1234567890'.obs;

  TableSelectController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }

    orderNumber.value = getRandomNumber();
  }

  void onCreateOrder() {
    Get.back();
  }
}
