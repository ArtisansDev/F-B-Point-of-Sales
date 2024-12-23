// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/data/local/database/payment_type/payment_type_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class PaymentScreenController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();

  PaymentScreenController(OrderPlace selectOrderPlace) {
    mOrderPlace.value = selectOrderPlace;
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    mOrderPlace.refresh();
    loadPaymentType();
  }

  // RxList<String> paymentType = ['Affin Terminal','Google Pay','Booking Payment','Credit Card'].obs;
  Rxn<GetAllPaymentTypeResponse> mGetAllPaymentTypeResponse =
      Rxn<GetAllPaymentTypeResponse>();
  RxList<GetAllPaymentTypeData> mGetAllPaymentTypeData = <GetAllPaymentTypeData>[].obs;
  loadPaymentType() async {
    var mPaymentTypeLocalApi = locator.get<PaymentTypeLocalApi>();
    mGetAllPaymentTypeResponse.value =
        await mPaymentTypeLocalApi.getPaymentTypeResponse() ??
            GetAllPaymentTypeResponse();
    mGetAllPaymentTypeData.clear();
    mGetAllPaymentTypeData.addAll(mGetAllPaymentTypeResponse.value?.data??[]);
    mGetAllPaymentTypeResponse.refresh();
    mGetAllPaymentTypeData.refresh();
  }

  RxBool isSelectPayment = false.obs;
  Rx<GetAllPaymentTypeData> mGetAllPaymentType = GetAllPaymentTypeData().obs;
  isSelectPaymentType(index){
    for(int i=0;i<mGetAllPaymentTypeData.length;i++){
      mGetAllPaymentTypeData[i].setIsSelect(false);
    }
    isSelectPayment.value = true;
    mGetAllPaymentTypeData[index].setIsSelect(true);
    mGetAllPaymentType.value = mGetAllPaymentTypeData[index];
    mGetAllPaymentTypeData.refresh();
    isSelectPayment.refresh();
  }

  void onPrint() {
    Get.back();
  }
}
