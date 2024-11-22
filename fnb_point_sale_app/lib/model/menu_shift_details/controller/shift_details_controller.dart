// ignore_for_file: depend_on_referenced_packages



import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../view/details/controller/details_screen_controller.dart';
import '../view/open_cash_drawer/controller/open_cash_drawer_screen_controller.dart';

class ShiftDetailsController extends GetxController {
  DashboardScreenController mDashboardScreenController = Get.find<DashboardScreenController>();

  @override
  void onClose() {
    if (Get.isRegistered<OpenCashDrawerScreenController>()) {
      Get.delete<OpenCashDrawerScreenController>();
    }
    if (Get.isRegistered<DetailsScreenController>()) {
      Get.delete<DetailsScreenController>();
    }
    super.onClose();
  }

}
