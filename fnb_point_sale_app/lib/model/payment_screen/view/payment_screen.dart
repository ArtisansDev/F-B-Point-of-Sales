import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_app/model/payment_screen/view/payment_order_list.dart';
import 'package:fnb_point_sale_app/model/payment_screen/view/payment_type_list.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/payment_screen_controller.dart';

class PaymentScreen extends GetView<PaymentScreenController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PaymentScreenController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
          height: 85.h,
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
                        'Order #: 25897',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Dine-In',
                          style: getText600(
                            size: 11.7.sp,
                            colors: ColorConstants.cAppCancelDilogColour,
                          ),
                        ),
                      ))
                    ],
                  )),

              ///Enter Name
              Container(
                  height: 19.5.sp,
                  margin: EdgeInsets.only(
                      left: 13.sp, right: 13.sp, bottom: 10.sp, top: 11.sp),
                  child: TextInputWidget(
                    placeHolder: sEnterName.tr,
                    controller: controller.nameController.value,
                    errorText: null,
                    textInputType: TextInputType.emailAddress,
                    hintText: sEnterName.tr,
                    hintTextColor: ColorConstants.black.withOpacity(0.80),
                    showFloatingLabel: false,
                    topPadding: 5.sp,
                    hintTextSize: 10.5.sp,
                    textSize: 10.5.sp,
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternOnlyString)),
                    ],
                  )),

              ///Phone Number
              Container(
                  height: 19.5.sp,
                  margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                  child: TextInputWidget(
                    placeHolder: sPhoneNumber.tr,
                    controller: controller.phoneNumberController.value,
                    errorText: null,
                    textInputType: TextInputType.emailAddress,
                    hintText: sPhoneNumber.tr,
                    showFloatingLabel: false,
                    topPadding: 5.sp,
                    hintTextSize: 10.5.sp,
                    hintTextColor: ColorConstants.black.withOpacity(0.80),
                    textSize: 10.5.sp,
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternOnlyString)),
                    ],
                  )),
              ///order list
              Expanded(child: PaymentOrderList()),
              ///amount
              Container(
                  margin: EdgeInsets.only(
                      top: 11.sp, bottom: 11.sp, left: 13.sp, right: 13.sp),
                  padding: EdgeInsets.only(
                      top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cAppCancelDilogBackgroundColour,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.sp),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Sub Total',
                            style: getText600(
                              size: 10.sp,
                              colors: ColorConstants.cAppCancelDilogColour,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'RM 80.00',
                              style: getText600(
                                size: 10.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Tax 5%',
                            style: getText600(
                              size: 10.sp,
                              colors: ColorConstants.cAppCancelDilogColour,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'RM 4.00',
                              style: getText600(
                                size: 10.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            ),
                          ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                        width: double.infinity,
                        height: 3.sp,
                        color: ColorConstants.cAppCancelDilogDeviderColour,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Total Amount',
                            style: getText600(
                              size: 10.5.sp,
                              colors: ColorConstants.cAppCancelDilogColour,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'RM 84.00',
                              style: getText600(
                                size: 10.5.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  )),
              ///payment list
              Expanded(child: PaymentTypeList()),
              ///Print Invoice button
              Container(
                  margin: EdgeInsets.only(
                      left: 25.sp, right: 25.sp, top: 12.sp, bottom: 13.sp),
                  child: rectangleCornerButtonText600(
                    height: 19.5.sp,
                    textSize: 11.7.sp,
                    sPrintInvoice.tr,
                    () {
                      controller.onPrint();
                    },
                  )),
            ],
          ),
        ));
  }
}