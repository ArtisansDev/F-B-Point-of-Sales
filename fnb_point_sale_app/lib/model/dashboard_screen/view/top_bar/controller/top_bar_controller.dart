// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/common_view/logout_expired.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/printer/types/test_printing.dart';
import 'package:fnb_point_sale_base/printer/widgets/printer_configuration_widget.dart';
import 'package:fnb_point_sale_base/serialportdevices/widgets/serial_port_device_config_widget.dart';
import 'package:get/get.dart';

import '../../../../hold_sales/controller/hold_sales_controller.dart';
import '../../../../hold_sales/view/hold_sales_screen.dart';
import '../../../../menu_home/view/selected_order/controller/selected_order_controller.dart';
import '../../../../reservation_table_select/controller/reservation_table_select_controller.dart';
import '../../../../reservation_table_select/view/reservation_table_select_screen.dart';
import '../../../controller/dashboard_screen_controller.dart';

class TopBarController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///top bar Menu select
  void onClickTopBarMenu(int index) async {
    if (index == 3) {
      ///Reservation Table
      await AppAlert.showView(
          Get.context!, const ReservationTableSelectScreen(),
          barrierDismissible: true);
      if (Get.isRegistered<ReservationTableSelectController>()) {
        Get.delete<ReservationTableSelectController>();
      }
    } else if (index == 4) {
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
    } else {
      mDashboardScreenController.setTopBarValue(index, 0);
    }
  }

  void onSelectedProfileMenu(int value) {
    switch (value) {
      case 0:
        break;
      case 1:
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
}
