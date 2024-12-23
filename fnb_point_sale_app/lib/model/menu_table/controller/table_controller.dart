// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/widgets.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/payment_type/payment_type_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/table_list/table_list_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
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
              Expanded(flex: 7, child: SizedBox()),
              Expanded(flex: 3, child: TableSummaryOrderScreen())
            ],
          ),
          barrierDismissible: true);
      if (Get.isRegistered<TableSummaryController>()) {
        Get.delete<TableSummaryController>();
      }
    } else {
      bool isCreateOrder = false;
      await AppAlert.showView(
          Get.context!, TableSelectScreen(tableNumber: '${mGetAllTablesList[index].seatNumber}'),
          barrierDismissible: true);
      if (Get.isRegistered<TableSelectController>()) {
        isCreateOrder = Get.find<TableSelectController>().isCreateOrder.value;
        Get.delete<TableSelectController>();
      }
      if(isCreateOrder) {
        mDashboardScreenController.selectMenu.value = 0;
        mDashboardScreenController.selectMenu.refresh();
      }
    }
  }
  RxList<GetAllTablesResponseData> mGetAllTablesList = <GetAllTablesResponseData>[].obs;
  loadAllTables() async {
    var mTableListLocalApi = locator.get<TableListLocalApi>();
    GetAllTablesResponse mGetAllTablesResponse =
        await mTableListLocalApi.getTablesListResponse() ??
            GetAllTablesResponse();
    mGetAllTablesList.clear();
    mGetAllTablesList.addAll(mGetAllTablesResponse.data??[]);
    mGetAllTablesList.refresh();
  }

}
