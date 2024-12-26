// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../../../../home_base_controller/home_base_controller.dart';
import '../../../controller/search_order_controller.dart';

class SearchViewController extends HomeBaseController {
  SearchViewController() {
    if (Get.isRegistered<SearchOrderController>()) {
      mSearchOrderController.value = Get.find<SearchOrderController>();
    }
  }

}
