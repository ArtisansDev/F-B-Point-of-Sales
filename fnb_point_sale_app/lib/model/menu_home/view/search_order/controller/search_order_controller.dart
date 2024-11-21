// ignore_for_file: depend_on_referenced_packages
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';

class SearchOrderController extends GetxController {
  Rxn<HomeController> mHomeController = Rxn<HomeController>();
  SearchOrderController(){
    if (Get.isRegistered<HomeController>()) {
      mHomeController.value = Get.find<HomeController>();
    }
  }


}
