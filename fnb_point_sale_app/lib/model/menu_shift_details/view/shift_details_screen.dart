import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/shift_details_controller.dart';

class ShiftDetailsScreen extends GetView<ShiftDetailsController> {
  const ShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShiftDetailsController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
          margin: EdgeInsets.only(top: 8.sp, left: 8.sp, right: 8.sp,bottom: 8.sp),
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.sp),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'ShiftDetails In-processing',
            style: getText600(size: 15.sp, colors: ColorConstants.cAppColors),
          ),
        ));
  }
}
