import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_shift_details/view/open_cash_drawer/view/total_cash_screen.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
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
        onVisibilityGained: () {},
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
          child:Column(
            children: [
              CashDrawerScreen(),
              CashCalculateScreen(),
              TotalCashScreen(),
            ],
          ),
        ));
  }
}
