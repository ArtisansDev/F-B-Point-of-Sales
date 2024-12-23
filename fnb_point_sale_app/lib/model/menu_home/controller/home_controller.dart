// ignore_for_file: depend_on_referenced_packages

import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../home_base_controller/home_base_controller.dart';
import '../view/search_order/controller/search_order_controller.dart';
import '../view/selected_order/controller/selected_order_controller.dart';

class HomeController extends HomeBaseController {
  HomeController(){
    mHomeController.value = this;
  }
  @override
  void onClose() {
    ///delete all sub Controller
    if (Get.isRegistered<SearchOrderController>()) {
      Get.find<SearchOrderController>().onClose();
      Get.delete<SearchOrderController>();
    }
    if (Get.isRegistered<SelectedOrderController>()) {
      Get.find<SelectedOrderController>().onClose();
      Get.delete<SelectedOrderController>();
    }
    super.onClose();
  }
}
