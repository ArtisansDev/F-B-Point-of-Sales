// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../view/search_order/controller/search_order_controller.dart';
import '../view/selected_order/controller/selected_order_controller.dart';

class HomeController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  @override
  void onClose() {
    ///delete all sub Controller
    if (Get.isRegistered<SearchOrderController>()) {
      Get.find<SearchOrderController>().onClose();
      Get.delete<SearchOrderController>();
    }
    if (Get.isRegistered<SelectedOrderController>()) {
      Get.find<SelectedOrderController>().onClose();
      Get.delete<SelectedOrderController>();
    }
    super.onClose();
  }
}
