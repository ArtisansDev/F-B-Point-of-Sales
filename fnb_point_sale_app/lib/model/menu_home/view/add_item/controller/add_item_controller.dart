// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../home_base_controller/home_base_controller.dart';

class AddItemController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rxn<HomeBaseController> mHomeBaseController = Rxn<HomeBaseController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  AddItemController(HomeBaseController mGetHomeBaseController) {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    // if (Get.isRegistered<HomeController>()) {
    //   mHomeController.value = Get.find<HomeController>();
    mHomeBaseController.value = mGetHomeBaseController;
    getValue();
    // }
  }

  void getValue() {
    MyLogUtils.logDebug(
        "##### mMenuItemSelected ${jsonEncode(mHomeBaseController.value?.mMenuItemSelected.value)}");
    MyLogUtils.logDebug(
        "##### mVariantListData ${mHomeBaseController.value?.mVariantListData.length}");
    MyLogUtils.logDebug(
        "##### mVariantListData ${jsonEncode(mHomeBaseController.value?.mVariantListData)}");

    MyLogUtils.logDebug(
        "##### mModifierListData ${jsonEncode(mHomeBaseController.value?.mModifierListData.length)}");
    MyLogUtils.logDebug(
        "##### mModifierListData ${jsonEncode(mHomeBaseController.value?.mModifierListData)}");
  }

  void onAddItem() {
    Get.back();
  }
}
