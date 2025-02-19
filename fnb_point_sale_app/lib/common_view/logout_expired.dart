/*
 * Project      : skill_360
 * File         : logout.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-16
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/menu_item/menu_item_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/modifier/modifier_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';
import '../model/dashboard_screen/controller/dashboard_screen_controller.dart';
import '../model/dashboard_screen/view/side_menu/controller/side_menu_controller.dart';
import '../model/dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../model/menu_customer/controller/customer_controller.dart';
import '../model/menu_home/home_base_controller/home_base_controller.dart';
import '../model/menu_sales/controller/menu_sales_controller.dart';
import '../model/menu_settings/controller/settings_controller.dart';
import '../model/menu_shift_details/controller/shift_details_controller.dart';
import '../model/menu_table/controller/table_controller.dart';
import '../routes/route_constants.dart';

import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';

openCounter() async {
  await SharedPrefs().setHistoryID('');
  var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
  mPlaceOrderSaleLocalApi.clearBox();
  Get.delete<DashboardScreenController>();
  Get.offNamed(
    RouteConstants.rOpenCounterScreen,
  );
}

logout() async {
  await SharedPrefs().setUserToken('');
  await SharedPrefs().setUserId('');
  await SharedPrefs().setHistoryID('');

  await locator.get<AllCategoryLocalApi>().deleteAllCategory();
  await locator.get<ModifierLocalApi>().deleteAllModifier();
  await locator.get<MenuItemLocalApi>().deleteAllMenuItem();
  await locator.get<HoldSaleLocalApi>().deleteAllHoldSale();
  deleteAll();

  Get.offAllNamed(
    RouteConstants.rLoginScreen,
  );
}

clearConfiguration() async {
  await SharedPrefs().setUserToken('');
  await SharedPrefs().setUserId('');
  await SharedPrefs().setHistoryID('');


  await locator.get<AllCategoryLocalApi>().deleteAllCategory();
  await locator.get<ModifierLocalApi>().deleteAllModifier();
  await locator.get<MenuItemLocalApi>().deleteAllMenuItem();
  await locator.get<HoldSaleLocalApi>().deleteAllHoldSale();
  await locator.get<ConfigurationLocalApi>().deleteAllConfiguration();


  deleteAll();
  Get.offAllNamed(
    RouteConstants.rConfigurationScreen,
  );
}

deleteAll(){
  Get.delete<DashboardScreenController>();
  Get.delete<SideMenuController>();
  Get.delete<TopBarController>();

  if (Get.isRegistered<HomeBaseController>()) {
    Get.find<HomeBaseController>().onClose();
    Get.delete<HomeBaseController>();
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
  if (Get.isRegistered<CustomerController>()) {
    Get.find<CustomerController>().onClose();
    Get.delete<CustomerController>();
  }
  if (Get.isRegistered<CustomerController>()) {
    Get.find<CustomerController>().onClose();
    Get.delete<CustomerController>();
  }
  if (Get.isRegistered<ShiftDetailsController>()) {
    Get.find<ShiftDetailsController>().onClose();
    Get.delete<ShiftDetailsController>();
  }
}
