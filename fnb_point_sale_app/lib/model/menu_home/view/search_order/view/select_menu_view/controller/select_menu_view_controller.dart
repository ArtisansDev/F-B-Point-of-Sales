// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../../controller/search_order_controller.dart';

class SelectMenuViewController extends GetxController {
  Rxn<SearchOrderController> mDashboardScreenController =
      Rxn<SearchOrderController>();
  RxList<String> selectMenu = <String>[].obs;

  SelectMenuViewController() {
    if (Get.isRegistered<SearchOrderController>()) {
      mDashboardScreenController.value = Get.find<SearchOrderController>();
    }
  }

  void onClickHome() {
    selectMenu.clear();
    selectMenu.refresh();
  }
}
