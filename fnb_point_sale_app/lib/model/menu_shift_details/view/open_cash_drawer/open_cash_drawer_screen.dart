import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_shift_details/view/open_cash_drawer/view/total_cash_screen.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'controller/open_cash_drawer_screen_controller.dart';
import 'view/cash_calculate_screen.dart';
import 'view/cash_drawer_screen.dart';

class OpenCashDrawerScreen extends GetView<OpenCashDrawerScreenController> {
  const OpenCashDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OpenCashDrawerScreenController());
    return FocusDetector(
        onVisibilityGained: () {
          controller.addAmount();
        },
        onVisibilityLost: () {},
        child: Container(
          margin: EdgeInsets.only(
              top: 11.sp, left: 9.sp, right: 11.sp, bottom: 11.sp),
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.sp),
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              CashDrawerScreen(),
              CashCalculateScreen(),
              TotalCashScreen(),
              const Expanded(child: SizedBox()),
              Container(
                  margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
                  child: rectangleCornerButtonText600(
                    height: 19.5.sp,
                    textSize: 11.5.sp,
                    sShiftClose.tr,
                    () {
                      controller.mShiftDetailsController.closeBalanceApiCall(
                          getDoubleValue(controller.totalCashCollected.value)
                              .toStringAsFixed(2));
                    },
                  )),
              SizedBox(
                height: 8.sp,
              )
            ],
          ),
        ));
  }
}
