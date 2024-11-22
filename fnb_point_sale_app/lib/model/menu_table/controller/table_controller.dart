// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/widgets.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../table_select/controller/table_select_controller.dart';
import '../../table_select/view/table_select_screen.dart';
import '../view/table_view/table_summary/controller/table_summary_controller.dart';
import '../view/table_view/table_summary/view/table_summary_order_screen.dart';

class TableController extends GetxController {
  DashboardScreenController mDashboardScreenController =
  Get.find<DashboardScreenController>();

  ///table click
  void onTableSelectClick(int index) async {
    if (!(index % 3 == 0)) {
      await AppAlert.showView(
          Get.context!,
          const Row(
            children: [
              Expanded(
                  flex: 7,
                  child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: TableSummaryOrderScreen())
            ],
          ),
          barrierDismissible: true);
      if (Get.isRegistered<TableSummaryController>()) {
        Get.delete<TableSummaryController>();
      }
    }else {
      await AppAlert.showView(
          Get.context!,
          const TableSelectScreen(),
          barrierDismissible: true);
      if (Get.isRegistered<TableSelectController>()) {
        Get.delete<TableSelectController>();
      }

    }
  }
}
