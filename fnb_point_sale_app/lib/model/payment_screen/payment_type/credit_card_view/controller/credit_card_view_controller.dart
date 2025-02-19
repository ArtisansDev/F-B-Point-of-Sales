// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardViewController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rxn<Function> onPaymentClick = Rxn<Function>();

  CreditCardViewController(Function onPayment) {
    onPaymentClick.value = onPayment;
  }

  void onDone() {
    Get.back();
    String value = "{\"CreditCard\": {\"CardNumber\": \"${nameController.value.text}\"}}";
    onPaymentClick.value!(value);
  }

  void onCancelView() {
    Get.back();
    onPaymentClick.value!('Cancel');
  }
}
