// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../../controller/home_controller.dart';
import '../../../../../home_base_controller/home_base_controller.dart';
import '../../../../add_item/controller/add_item_controller.dart';
import '../../../../add_item/view/add_item_screen.dart';
import '../../../controller/search_order_controller.dart';
import '../../select_menu_view/controller/select_menu_view_controller.dart';

class MenuViewController extends HomeBaseController {

  MenuViewController(){
    mMenuViewController.value = this;
  }
}
