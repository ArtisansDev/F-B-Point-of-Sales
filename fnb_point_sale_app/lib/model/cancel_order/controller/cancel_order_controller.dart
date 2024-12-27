// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../menu_home/view/selected_order/controller/selected_order_controller.dart';

class CancelOrderController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rxn<SelectedOrderController> mSelectedOrderController =
      Rxn<SelectedOrderController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();

  setOrder(SelectedOrderController mSelectedOrder){
    mSelectedOrderController.value = mSelectedOrder;
    mOrderPlace.value = mSelectedOrder.mOrderPlace.value;
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    mOrderPlace.refresh();
  }

  void onCancel() {
    if (mSelectedOrderController.value != null) {
      mOrderPlace.value =null;
      mSelectedOrderController.value?.mOrderPlace.value = null;
      mSelectedOrderController.value?.mOrderPlace.refresh();
    }
    Get.back();
  }
}
