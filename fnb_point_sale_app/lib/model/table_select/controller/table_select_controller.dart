// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class TableSelectController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> enterNameController = TextEditingController().obs;
  Rx<TextEditingController> sTableNoController = TextEditingController().obs;
  Rx<TextEditingController> sPhoneNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> scheduleController = TextEditingController().obs;
  Rx<TextEditingController> notesController = TextEditingController().obs;
  RxBool isDineIn = true.obs;
  RxString orderNumber = '1234567890'.obs;
  RxBool isCreateOrder = false.obs;

  TableSelectController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    isCreateOrder.value = false;
    orderNumber.value = getRandomNumber();
  }

  void onCreateOrder() {
    isCreateOrder.value = true;
    mDashboardScreenController.value?.mOrderPlace.value =
        OrderPlace(cartItem: []);
    mDashboardScreenController.value?.mOrderPlace.value?.seatIDP =
        sTablesData.value?.seatIDP ?? '--';
    mDashboardScreenController.value?.mOrderPlace.value?.tableNo =
        sTableNumber.value ?? '--';
    mDashboardScreenController.value?.mOrderPlace.value?.userName =
        enterNameController.value.text;
    mDashboardScreenController.value?.mOrderPlace.value?.userPhone =
        sPhoneNumberController.value.text;
    mDashboardScreenController.value?.mOrderPlace.value?.sOrderNo =
        orderNumber.value;

    Get.back();
  }

  Rxn<String> sTableNumber = Rxn<String>();
  Rxn<GetAllTablesResponseData> sTablesData = Rxn<GetAllTablesResponseData>();

  void setTableNumber(GetAllTablesResponseData? mGetAllTablesResponseData) {
    sTablesData.value = mGetAllTablesResponseData ?? GetAllTablesResponseData();
    sTableNumber.value = mGetAllTablesResponseData?.seatNumber ?? '';
    if (sTableNumber.value != null) {
      sTableNoController.value.text = sTableNumber.value ?? '';
      sTableNoController.refresh();
    }
  }
}
