// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:fnb_point_sale_app/common_view/logout_expired.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../../../../routes/route_constants.dart';
import '../../../controller/dashboard_screen_controller.dart';
import '../model/tob_bar_model.dart';

class TopBarController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///top bar Menu select
  void onClickTopBarMenu(int index) {
    // mDashboardScreenController.setTopBarValue(index,0);
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
    }
  }
}
