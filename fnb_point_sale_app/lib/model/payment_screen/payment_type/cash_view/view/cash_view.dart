import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/cash_view_controller.dart';
import 'keypad_screen.dart';

///partha paul
///debit_card_view
///10/02/25

class CashViewScreen extends GetView<CashViewController> {
  final Function onPayment;
  final OrderPlace mOrderPlace;

  const CashViewScreen(
      {super.key, required this.onPayment, required this.mOrderPlace});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CashViewController(onPayment, mOrderPlace));
    return FocusDetector(
      onVisibilityGained: () {
        controller.postShiftDetailsApiCall();
      },
      onVisibilityLost: () {},
      child: Obx(
        () => Container(
          height: 45.w,
          width: 30.w,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.all(
              Radius.circular(11.sp),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        'Payment Type : Cash',
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
              KeypadScreen(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Payable Amount',
                            style: getText600(
                              size: 11.5.sp,
                              colors: ColorConstants.cAppCancelDilogColour,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${controller.mAmount.value.toStringAsFixed(2)}',
                              style: getText600(
                                size: 11.5.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            ),
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Due Amount',
                            style: getText600(
                              size: 11.5.sp,
                              colors: Colors.red,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${controller.mDueAmount.value.toStringAsFixed(2)}',
                              style: getText600(
                                size: 11.5.sp,
                                colors: Colors.red,
                              ),
                            ),
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Change Due Amount',
                            style: getText600(
                              size: 11.5.sp,
                              colors: ColorConstants.cAppTextInviceColour,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${controller.mReturnAmount.value.toStringAsFixed(2)}',
                              style: getText600(
                                size: 11.5.sp,
                                colors: ColorConstants.cAppTextInviceColour,
                              ),
                            ),
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 12.sp,
                  ),

                  ///Enter amount
                  Container(
                      height: 20.sp,
                      margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                      child: TextInputWidget(
                        isReadOnly: true,
                        placeHolder: 'Enter the amount',
                        //sEnterName.tr,
                        controller: controller.amountController.value,
                        errorText: null,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter the amount',
                        onTextChange: (value) {
                          controller.onTextChangeAmount();
                        },
                        //sEnterName.tr,
                        hintTextColor: ColorConstants.black.withOpacity(0.80),
                        showFloatingLabel: false,
                        topPadding: 5.sp,
                        hintTextSize: 10.5.sp,
                        textSize: 10.5.sp,
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              AppUtilConstants.patternDecimalNumberWeight)),
                          LengthLimitingTextInputFormatter(12)
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
                          child: SizedBox(
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
                          child: SizedBox(
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
      ),
    );
  }
}
