// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../controller/shift_details_controller.dart';
import 'cash_model/cash_model.dart';

class OpenCashDrawerScreenController extends GetxController {
  ShiftDetailsController mShiftDetailsController = Get.find<ShiftDetailsController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;


}
