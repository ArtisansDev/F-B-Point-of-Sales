// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/menu_sales_screen.dart';
import 'package:fnb_point_sale_app/model/menu_settings/view/settings_screen.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_screen.dart';
import 'package:fnb_point_sale_base/common/download_data/download_data_view_model.dart';
import 'package:fnb_point_sale_base/common/download_data/ui/download_data_menu_widget.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/mode/button_bar/button_bar_model.dart';
import 'package:get/get.dart';

import '../../menu_home/controller/home_controller.dart';
import '../../menu_home/view/home_screen.dart';
import '../../menu_sales/controller/menu_sales_controller.dart';
import '../../menu_settings/controller/settings_controller.dart';
import '../../menu_shift_details/controller/shift_details_controller.dart';
import '../../menu_shift_details/view/shift_details_screen.dart';
import '../../menu_table/controller/table_controller.dart';
import '../view/top_bar/model/tob_bar_model.dart';

class DashboardScreenController extends GetxController {
  RxString version = ''.obs;
  RxInt selectMenu = 0.obs;
  RxList<TobBarModel> mTobBarModel = <TobBarModel>[
    TobBarModel(
      name: 'ALL',
      value: '20',
    ),
    TobBarModel(name: 'OPEN', value: '5'),
    TobBarModel(name: 'OCCUPIED', value: '5'),
    TobBarModel(name: 'RESERVED', value: '5'),
    // TobBarModel(name: 'SELECT TABLE', value: '2'),
  ].obs;

  ///set Top Bar value
  setTopBarValue(int index, int value) {
    mTobBarModel.value[index].value =
        (int.parse((mTobBarModel.value[index].value ?? '0').toString()) + 1)
            .toString();
    mTobBarModel.refresh();
  }

  ///set APP VERSION
  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  getView() {
    deleteController();
    switch (selectMenu.value) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MenuSalesScreen();
      case 2:
        return const TableScreen();
      case 3:
        return const SettingsScreen();
      case 4:
        return const ShiftDetailsScreen();
    }
  }

  deleteController() {
    switch (selectMenu.value) {
      case 0:

        ///home
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        break;
      case 1:

        ///MenuSales
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().onClose();
          Get.delete<HomeController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        return;
      case 2:

        ///MenuTable
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().onClose();
          Get.delete<HomeController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        break;
      case 3:

        ///MenuSettings
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().onClose();
          Get.delete<HomeController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        break;
      case 4:

        ///ShiftDetails
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().onClose();
          Get.delete<HomeController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        break;
    }
  }

  ///button bar
  RxList<ButtonBarModel> mButtonBarModel = [
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.newOrderButton,
        buttonBarName: 'New Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.holdOrderButton,
        buttonBarName: 'Hold Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.cancelOrderButton,
        buttonBarName: 'Cancel Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.sendOrderButton,
        buttonBarName: 'Send Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.reservationButton,
        buttonBarName: 'Reservation'),
  ].obs;

  ///onSync
  fastTimeSync() {
    if (WebConstants.isFastTimeLogin) {
      WebConstants.isFastTimeLogin = false;
      unawaited(DownloadDataViewModel().startDownloading((value) {
        sDownloadText.value = value;
        sDownloadText.refresh();
      }, () {
        sDownloadText.value = '';
        sDownloadText.refresh();
        onUpdateDate.value!();
      }, (value) {}, DownloadDataMenu.values, onlyLatestChange: false));
    }
  }

  RxString sDownloadText = ''.obs;

  onSync() async {
    await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => DownloadDataMenuWidget(
              onError: (value) {},
              updateMessage: (value) {
                sDownloadText.value = value;
                sDownloadText.refresh();
              },
              onCompleted: () {
                sDownloadText.value = '';
                sDownloadText.refresh();
                onUpdateDate.value!();
              },
              onCancel: () {
                Get.back();
              },
            ));
  }

  Rxn<Function> onUpdateDate = Rxn<Function>();

  onUpdate(Function update) {
    onUpdateDate.value = update;
  }
}
