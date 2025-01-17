// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/common_view/logout_expired.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/database/table_list/table_list_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/types/test_printing.dart';
import 'package:fnb_point_sale_base/printer/widgets/printer_configuration_widget.dart';
import 'package:fnb_point_sale_base/serialportdevices/widgets/serial_port_device_config_widget.dart';
import 'package:get/get.dart';

import '../../../../hold_sales/controller/hold_sales_controller.dart';
import '../../../../hold_sales/view/hold_sales_screen.dart';
import '../../../../menu_home/view/selected_order/controller/selected_order_controller.dart';
import '../../../../profile/controller/profile_controller.dart';
import '../../../../profile/view/profile_screen.dart';
import '../../../controller/dashboard_screen_controller.dart';

class TopBarController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///top bar Menu select
  void onClickTopBarMenu(int index) async {
    // if (index == 3) {
    //   ///Reservation Table
    //   await AppAlert.showView(
    //       Get.context!, const ReservationTableSelectScreen(),
    //       barrierDismissible: true);
    //   if (Get.isRegistered<ReservationTableSelectController>()) {
    //     Get.delete<ReservationTableSelectController>();
    //   }
    // } else
    if (index == 3) {
      /// hold sale
      await AppAlert.showView(Get.context!, const HoldSalesScreen(),
          barrierDismissible: true);

      if (Get.isRegistered<HoldSalesController>()) {
        Get.delete<HoldSalesController>();
      }

      if (mDashboardScreenController.selectMenu.value != 0 &&
          mDashboardScreenController.mOrderPlace.value != null) {
        mDashboardScreenController.selectMenu.value = 0;
        mDashboardScreenController.selectMenu.refresh();
      } else if (mDashboardScreenController.mOrderPlace.value != null) {
        if (Get.isRegistered<SelectedOrderController>()) {
          SelectedOrderController mSelectedOrderController =
              Get.find<SelectedOrderController>();
          mSelectedOrderController.onOrderPlaceAnotherPage();
        }
      }
      if (mDashboardScreenController.onUpdateHold.value != null) {
        mDashboardScreenController.onUpdateHold.value!();
      }
    } else {
      mDashboardScreenController.setTopBarValue(index, 0);
    }
  }

  void onSelectedProfileMenu(int value) async {
    switch (value) {
      case 0:

        ///profile
        await AppAlert.showView(Get.context!, const ProfileScreen());
        if (Get.isRegistered<ProfileController>()) {
          Get.delete<ProfileController>();
        }
        break;
      case 1:

        ///mDashboardScreenController.selectMenu.value = 5;
        AppAlert.showCustomDialogYesNoLogout(
            Get.context!, 'Logout!', 'Do you want to log out?', () {
          logout();
        });
        break;
      case 2:
        exit(0);
        break;
      case 3:
        printPdf();
        break;
      case 4:
        _searchPrinterDialog();
        break;
      case 5:
        _searchSerialPortDevicesDialog();
        break;
    }
  }

  Future<void> _searchPrinterDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) => const PrinterConfigurationWidget(),
    );
  }

  Future<void> _searchSerialPortDevicesDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) => const SerialPortDeviceConfigWidget(),
    );
  }

  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  Rx<ConfigurationResponse> mConfigurationResponse =
      ConfigurationResponse().obs;

  ///sync update
  onHomeUpdate() async {
    await allOrderPlace();
    mDashboardScreenController.onTopBarUpdate(fUpdateTopBar: () async {
      await updateDetails();
      await loadAllTables();
    });

    await updateDetails();
  }

  updateDetails() async {
    mConfigurationResponse.value =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    mConfigurationResponse.refresh();
  }

  ///OrderPlace
  Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
  var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

  allOrderPlace() async {
    mPlaceOrderSaleModel.value =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
    showTableCount();
  }

  ///all table
  RxList<GetAllTablesResponseData> mGetAllTablesList =
      <GetAllTablesResponseData>[].obs;

  loadAllTables() async {
    var mTableListLocalApi = locator.get<TableListLocalApi>();
    GetAllTablesResponse mGetAllTablesResponse =
        await mTableListLocalApi.getTablesListResponse() ??
            GetAllTablesResponse();
    mGetAllTablesList.clear();
    mGetAllTablesList.addAll(mGetAllTablesResponse.data ?? []);
    mGetAllTablesList.refresh();

    ///groupTable
    groupTable();

    ///show table count
    showTableCount();
  }

  showTableCount() {
    String totalTable = (mGetAllTablesList.length ?? 0).toString();
    int occupiedTable = 0;
    String openTable = totalTable;
    String value = jsonEncode(mGetAllTablesList);
    for (OrderPlace totalOrder
        in (mPlaceOrderSaleModel.value ?? PlaceOrderSaleModel()).mOrderPlace ??
            []) {
      if (value.contains(totalOrder.tableNo.toString())) {
        occupiedTable = occupiedTable + 1;
      }
    }

    mDashboardScreenController.mTobBarModel[0].value = totalTable;
    mDashboardScreenController.mTobBarModel[1].value =
        (int.parse(openTable) - occupiedTable).toString();
    mDashboardScreenController.mTobBarModel[2].value = occupiedTable.toString();
    mDashboardScreenController.mTobBarModel.refresh();
  }

  RxMap<String, List<GetAllTablesResponseData>> groupedByDepartment =
      <String, List<GetAllTablesResponseData>>{}.obs;

  groupTable() {
    /// Create a map for grouping
    for (var mTable in mGetAllTablesList) {
      groupedByDepartment.putIfAbsent(mTable.locationType ?? '', () => []);
      groupedByDepartment[mTable.locationType]!.add(mTable);
    }
    groupedByDepartment.refresh();
    // debugPrint(groupedByDepartment as String?);
  }
}
