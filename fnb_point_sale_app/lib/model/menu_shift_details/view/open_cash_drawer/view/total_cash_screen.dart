import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/open_cash_drawer_screen_controller.dart';

class TotalCashScreen extends StatelessWidget {
  late OpenCashDrawerScreenController controller;

  TotalCashScreen({super.key}) {
    controller = Get.find<OpenCashDrawerScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(left: 14.sp, top: 12.sp, right: 14.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sCashCollected.tr,
              style: getText500(size: 11.sp, colors: ColorConstants.black),
            ),
            Text(
              '${controller.mShiftDetailsController.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${getNumberFormat(getDoubleValue(controller.mShiftDetailsController.totalCashCollected.value))}',
              style: getText500(
                  size: 11.sp, colors: ColorConstants.cAppButtonColour),
            )
          ],
        ),
      );
    });
  }
}
