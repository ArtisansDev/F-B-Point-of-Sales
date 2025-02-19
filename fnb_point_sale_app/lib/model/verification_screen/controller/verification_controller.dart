import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';

import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../routes/route_constants.dart';

class VerificationController extends GetxController {
  Rx<TextEditingController> pinputController = TextEditingController().obs;
  RxBool isLogin = true.obs;
  RxString text = ''.obs;

  VerificationController() {
    getPackageInfo();
  }

  final defaultPinTheme = PinTheme(
    width: 14.sp,
    height: 14.sp,
    textStyle: getText500(colors: ColorConstants.white, size: 13.3.sp),
    decoration: BoxDecoration(
      color: ColorConstants.white,
      shape: BoxShape.circle,
      border: Border.all(color: ColorConstants.cAppColors.withOpacity(0.5)),
    ),
  );

  onKeyboardTap(String value) {
    if (text.value.length != 4) {
      text.value = text.value + value;
      pinputController.value.text = text.value;
    }
  }

  onDeletePress() {
    if (text.value.isNotEmpty) {
      text.value = text.value.substring(0, text.value.length - 1);
      pinputController.value.text = text.value;
    }
  }

  RxString version = ''.obs;

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  isPinCheck() {
    if (text.value.length == 4) {
      Get.offNamed(
        RouteConstants.rDashboardScreen,
      );
    } else {
      AppAlert.showSnackBar(Get.context!, 'Please enter the pin');
    }
  }
}
