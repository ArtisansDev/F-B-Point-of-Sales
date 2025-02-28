import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_app/model/menu_shift_details/view/open_cash_drawer/view/total_cash_screen.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
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
          controller.mShiftDetailsController.addAmount();
        },
        onVisibilityLost: () {},
        child: Obx(
          () => Container(
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
                Expanded(
                  child: Visibility(
                      visible: controller
                              .mShiftDetailsController.isShiftClose.value ||
                          controller.mShiftDetailsController.sMessage.value
                              .isNotEmpty,
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                          child: Text(
                            controller.mShiftDetailsController.sMessage.value,
                            style: getText500(
                                size: 12.sp,
                                colors: controller.mShiftDetailsController
                                            .sMessage.value ==
                                        'Loading...'
                                    ? ColorConstants.black
                                    : ColorConstants.red),
                          ))),
                ),

                ///reason
                Visibility(
                    visible: !controller
                            .mShiftDetailsController.isShiftClose.value &&
                        controller
                            .mShiftDetailsController.sLoading.value.isEmpty &&
                        controller
                            .mShiftDetailsController.sMessage.value.isEmpty,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                            height: 19.5.sp,
                            child: TextInputWidget(
                              textColor: Colors.black,
                              placeHolder: sReason.tr,
                              controller: controller.mShiftDetailsController
                                  .reasonController.value,
                              errorText: null,
                              textInputType: TextInputType.emailAddress,
                              hintText: sReason.tr,
                              showFloatingLabel: false,
                              topPadding: 5.sp,
                              hintTextColor:
                                  ColorConstants.black.withOpacity(0.50),
                              hintTextSize: 11.sp,
                              textSize: 11.5.sp,
                              onFilteringTextInputFormatter: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    AppUtilConstants.patternStringAndSpace)),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                left: 8.sp, right: 8.sp, top: 8.sp),
                            child: rectangleCornerButtonText600(
                              height: 19.5.sp,
                              textSize: 11.5.sp,
                              sShiftClose.tr,
                              () {
                                controller.mShiftDetailsController
                                    .calculateAmount(getDoubleValue(controller
                                            .mShiftDetailsController
                                            .totalCashCollected
                                            .value)
                                        .toStringAsFixed(2));
                              },
                            )),
                      ],
                    )),

                SizedBox(
                  height: 8.sp,
                )
              ],
            ),
          ),
        ));
  }
}
