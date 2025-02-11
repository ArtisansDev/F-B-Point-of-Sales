// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:get/get.dart';

class QrViewController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rxn<Function> onPaymentClick = Rxn<Function>();
  Rxn<GetAllPaymentTypeData> mSelectPaymentType =  Rxn<GetAllPaymentTypeData>();
  QrViewController(GetAllPaymentTypeData mGetAllPaymentTypeData,Function onPayment) {
    mSelectPaymentType.value = mGetAllPaymentTypeData;
    onPaymentClick.value = onPayment;
  }

  void onDone() {
    if(nameController.value.text.isEmpty){
      AppAlert.showCustomSnackbar(
          Get.context!, 'Please enter the QrCode scan type');
    }else {
      Get.back();
      String value = "{\"QrCode\": {\"QrCodeData\": \"${nameController.value
          .text}\"}}";
      onPaymentClick.value!(value);
    }
  }

  void onCancelView() {
    Get.back();
    onPaymentClick.value!('Cancel');
  }
}
