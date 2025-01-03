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
import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';
import '../model/dashboard_screen/controller/dashboard_screen_controller.dart';
import '../routes/route_constants.dart';

import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';

logout() async {
  await SharedPrefs().setUserToken('');
  Get.delete<DashboardScreenController>();
  Get.offAllNamed(
    RouteConstants.rLoginScreen,
  );
}

clearConfiguration() async {
  await locator.get<AllCategoryLocalApi>().deleteAllCategory();
  await locator.get<ConfigurationLocalApi>().deleteAllConfiguration();
  await locator.get<HoldSaleLocalApi>().deleteAllHoldSale();
  await SharedPrefs().setUserToken('');
  Get.delete<DashboardScreenController>();
  Get.offAllNamed(
    RouteConstants.rConfigurationScreen,
  );
}
