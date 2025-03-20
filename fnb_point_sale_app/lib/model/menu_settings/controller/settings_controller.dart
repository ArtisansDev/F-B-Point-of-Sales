// ignore_for_file: depend_on_referenced_packages



import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../menu_stock/controller/menu_stock_controller.dart';
import '../../menu_stock/view/menu_stock_screen.dart';


class SettingsMenuController extends GetxController {
  DashboardScreenController mDashboardScreenController = Get.find<DashboardScreenController>();
  RxList<String> settingsMenu = (dotenv.env['SETTINGS']?.split(',') ?? []).obs;

  ///SettingSelect
  void onSettingSelect(int index) {
    String value = settingsMenu[index];
    switch(value){
      case "Stock Availability":
        stockInOutView();
        break;
    }
  }

  ///stockInOut
  void stockInOutView() async{
    await AppAlert.showViewWithoutBlur(Get.context!,  const MenuStockScreen(), barrierDismissible: true);
    // bool isAddMember = false;
    if (Get.isRegistered<MenuStockController>()) {
      // AddCustomerController mAddCustomerController =
      // Get.find<AddCustomerController>();
      // isAddMember = mAddCustomerController.isAddMember;
      Get.delete<MenuStockController>();
    }
  }



}
