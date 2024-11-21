// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../../controller/search_order_controller.dart';

class SearchViewController extends GetxController {
  Rxn<SearchOrderController> mDashboardScreenController =
      Rxn<SearchOrderController>();
  Rx<TextEditingController> searchController = TextEditingController().obs;

  SearchViewController() {
    if (Get.isRegistered<SearchOrderController>()) {
      mDashboardScreenController.value = Get.find<SearchOrderController>();
    }
  }

}
