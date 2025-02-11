// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/shift_details_controller.dart';

class OpenCashDrawerScreenController extends GetxController {
  ShiftDetailsController mShiftDetailsController = Get.find<ShiftDetailsController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;


}
