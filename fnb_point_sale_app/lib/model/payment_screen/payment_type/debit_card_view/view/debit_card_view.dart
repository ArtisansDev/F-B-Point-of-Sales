import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/debit_card_view_controller.dart';

///partha paul
///debit_card_view
///10/02/25

class DebitCardView extends GetView<DebitCardViewController> {
  final Function onPayment;

  const DebitCardView({super.key, required this.onPayment});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DebitCardViewController(onPayment));
    return FocusDetector(
      onVisibilityGained: () {},
      onVisibilityLost: () {},
      child: Container(
        height: 18.w,
        width: 25.w,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.all(
            Radius.circular(11.sp),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                    top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.cAppButtonLightColour,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11.sp),
                    topRight: Radius.circular(11.sp),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Payment Type : Debit Card',
                      style: getText600(
                        size: 11.8.sp,
                        colors: ColorConstants.cAppButtonColour,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        controller.onCancelView();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10.sp),
                        height: 16.5.sp,
                        width: 16.5.sp,
                        padding: EdgeInsets.all(4.5.sp),
                        decoration: BoxDecoration(
                          color: ColorConstants.cAppButtonColour,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.sp),
                          ),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: ColorConstants.white,
                          size: 11.sp,
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///Enter Name
                Container(
                    height: 20.sp,
                    margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                    child: TextInputWidget(
                      placeHolder: 'Enter the last 4 digits debit card number',
                      //sEnterName.tr,
                      controller: controller.nameController.value,
                      errorText: null,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Enter the last 4 digits debit card number',
                      //sEnterName.tr,
                      hintTextColor: ColorConstants.black.withOpacity(0.80),
                      showFloatingLabel: false,
                      topPadding: 5.sp,
                      hintTextSize: 10.5.sp,
                      textSize: 10.5.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternOnlyNumber)),
                        LengthLimitingTextInputFormatter(4)
                      ],
                    )),

                SizedBox(
                  height: 15.sp,
                ),

                ///Print Invoice button
                Row(
                  children: [
                    SizedBox(
                      width: 15.sp,
                    ),
                    Expanded(
                        child: Container(
                            width: 10.w,
                            child: rectangleCornerButtonText600(
                              height: 19.5.sp,
                              textSize: 11.7.sp,
                              sDone.tr,
                              () {
                                controller.onDone();
                              },
                            ))),
                    SizedBox(
                      width: 13.sp,
                    ),
                    Expanded(
                        child: Container(
                            width: 10.w,
                            child: rectangleCornerButtonText600(
                              height: 19.5.sp,
                              textSize: 11.7.sp,
                              sClose.tr,
                              () {
                                controller.onCancelView();
                              },
                            ))),
                    SizedBox(
                      width: 15.sp,
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
