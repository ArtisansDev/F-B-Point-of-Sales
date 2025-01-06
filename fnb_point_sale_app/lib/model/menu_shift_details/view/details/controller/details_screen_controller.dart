// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../controller/shift_details_controller.dart';

class DetailsScreenController extends GetxController {
  ShiftDetailsController mShiftDetailsController =
  Get.find<ShiftDetailsController>();

}
