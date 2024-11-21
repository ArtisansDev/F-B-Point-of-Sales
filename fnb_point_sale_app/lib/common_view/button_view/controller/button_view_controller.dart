// ignore_for_file: depend_on_referenced_packages
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../../model/cancel_order/controller/cancel_order_controller.dart';
import '../../../model/cancel_order/view/cancel_order_screen.dart';
import '../../../model/dashboard_screen/controller/dashboard_screen_controller.dart';

class ButtonViewController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();

  ButtonViewController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onTabButton(int index) async {
    switch (mDashboardScreenController
        .value!.mButtonBarModel.value[index].buttonBarName) {
      case 'Cancel Order':
        await AppAlert.showView(Get.context!, const CancelOrderScreen(),
            barrierDismissible: true);
        if (Get.isRegistered<CancelOrderController>()) {
          Get.delete<CancelOrderController>();
        }
        break;
    }
  }
}
