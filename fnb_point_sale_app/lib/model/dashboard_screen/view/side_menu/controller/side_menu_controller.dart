// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard_screen_controller.dart';

class SideMenuController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  RxList<String> sideMenu = (dotenv.env['SIDE_MENU']?.split(',') ?? []).obs;
  RxList<String> sideMenuImage = ([
    ImageAssetsConstants.sideMenuHome,
    ImageAssetsConstants.sideMenuTable,
    ImageAssetsConstants.sideMenuSales,
    ImageAssetsConstants.sideMenuSettings,
    ImageAssetsConstants.customer,
    ImageAssetsConstants.sideMenuShift
  ]).obs;

  void onClickSideMenu(index) {
    mDashboardScreenController.selectMenu.value = index;
  }
}
