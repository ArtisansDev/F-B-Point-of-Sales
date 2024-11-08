// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_app/model/menu_settings/view/settings_screen.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_screen.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

import '../../../routes/route_constants.dart';
import '../../menu_home/view/home_screen.dart';
import '../../menu_item/view/menu_item_screen.dart';
import '../../menu_shift_details/view/shift_details_screen.dart';
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
    TobBarModel(name: 'MY TABLE', value: '2'),
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
        return const MenuItemScreen();
      case 2:
        return const TableScreen();
      case 3:
        return const SettingsScreen();
      case 4:
        return const ShiftDetailsScreen();
    }
  }

  deleteController() {}
}
