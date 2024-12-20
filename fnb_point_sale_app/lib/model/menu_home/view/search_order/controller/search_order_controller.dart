// ignore_for_file: depend_on_referenced_packages
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../home_base_controller/home_base_controller.dart';
import '../view/menu_view/controller/menu_view_controller.dart';
import '../view/search_view/controller/search_view_controller.dart';
import '../view/select_menu_view/controller/select_menu_view_controller.dart';

class SearchOrderController extends HomeBaseController {

  SearchOrderController() {
    mSearchOrderController.value = this;
  }

  @override
  void onClose() {
    ///delete all sub Controller
    Get.delete<MenuViewController>();
    Get.delete<SearchViewController>();
    Get.delete<SelectMenuViewController>();
    super.onClose();
  }
}
