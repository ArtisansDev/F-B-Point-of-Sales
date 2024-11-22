// ignore_for_file: depend_on_referenced_packages
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../view/menu_view/controller/menu_view_controller.dart';
import '../view/search_view/controller/search_view_controller.dart';
import '../view/select_menu_view/controller/select_menu_view_controller.dart';

class SearchOrderController extends GetxController {
  Rxn<HomeController> mHomeController = Rxn<HomeController>();

  SearchOrderController() {
    if (Get.isRegistered<HomeController>()) {
      mHomeController.value = Get.find<HomeController>();
    }
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
