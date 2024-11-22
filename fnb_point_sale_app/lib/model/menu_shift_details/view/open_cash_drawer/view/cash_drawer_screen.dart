import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/cash_model/cash_model.dart';
import '../controller/open_cash_drawer_screen_controller.dart';

class CashDrawerScreen extends StatelessWidget {
  late OpenCashDrawerScreenController controller;

  CashDrawerScreen({super.key}) {
    controller = Get.find<OpenCashDrawerScreenController>();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 13.sp, top: 12.sp),
      child: Row(
        children: [
          Image.asset(
            ImageAssetsConstants.openDrawer,
            fit: BoxFit.fitWidth,
            width: 15.sp,
          ),
          SizedBox(
            width: 10.sp,
          ),
          Text(
            sOpenCashDrawer.tr,
            style: getText500(
                size: 11.sp, colors: ColorConstants.cAppButtonColour),
          )
        ],
      ),
    );
  }
}
