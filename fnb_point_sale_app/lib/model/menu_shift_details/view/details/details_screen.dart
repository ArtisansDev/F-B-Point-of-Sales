import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_shift_details/view/details/view/payment_declaration_screen.dart';
import 'package:fnb_point_sale_app/model/menu_shift_details/view/details/view/transaction_info_screen.dart';
import 'package:fnb_point_sale_app/model/menu_shift_details/view/details/view/user_info_screen.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_view/button_view/button_view.dart';
import 'controller/details_screen_controller.dart';

class DetailsScreen extends GetView<DetailsScreenController> {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailsScreenController());
    return Obx(() => Column(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 11.sp, left: 11.sp),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.sp),
                ),
              ),
              alignment: Alignment.center,
              child: controller.mShiftDetailsController.sLoading.isNotEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                          '${controller.mShiftDetailsController.sLoading}'),
                    )
                  : Column(
                      children: [
                        UserInfoScreen(),
                        SizedBox(
                          height: 10.sp,
                        ),
                        TransactionInfoScreen(),
                        SizedBox(
                          height: 10.sp,
                        ),
                        PaymentDeclarationScreen()
                      ],
                    ),
            )),
            const ButtonView()
          ],
        ));
  }
}
