/*
 * Project      : fnb_point_sale_app
 * File         : table_summary_order_list.dart.dart
 * Description  :
 * Author       : parthapaul
 * Date         : 2024-11-20
 * Version      : 1.0
 * Ticket       :
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/table_item_summary_controller.dart';

class TableItemSummaryBottomView extends StatelessWidget {
  late TableItemSummaryController controller;

  TableItemSummaryBottomView({super.key}) {
    controller = Get.find<TableItemSummaryController>();
  }

  @override
  Widget build(BuildContext context) {
    return
    Obx(() {
      return Visibility(
          visible: controller.mOrderPlace.value != null,
          child: Column(children: [
            ///Sub Total
            Container(
                margin: EdgeInsets.all(
                  8.sp,
                ),
                padding: EdgeInsets.only(
                    left: 8.sp, right: 8.sp, top: 3.sp, bottom: 5.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sSubTotal.tr,
                      style: getTextRegular(
                          size: 11.5.sp, colors: ColorConstants.cAppTaxColour),
                    ),
                    Text(
                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(controller.mOrderPlace.value.subTotal ?? 0).toStringAsFixed(2)}',
                      style: getTextRegular(
                          size: 11.5.sp, colors: ColorConstants.cAppTaxColour),
                    ),
                  ],
                )),
            Container(
              height: 3.sp,
              margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
              color: Colors.grey.shade300,
            ),

            ///Tax
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount:
                (controller.mDashboardScreenController.value?.taxData ?? [])
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  TaxData mTaxData =
                  (controller.mDashboardScreenController.value?.taxData ??
                      [])[index];
                  return Visibility(
                      visible: (mTaxData.taxPercentage ?? 0) > 0,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(
                                8.sp,
                              ),
                              padding: EdgeInsets.only(
                                  left: 8.sp,
                                  right: 8.sp,
                                  top: 5.sp,
                                  bottom: 5.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${mTaxData.taxName ?? ''} (${mTaxData.taxPercentage}%)',
                                    style: getTextRegular(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                  Text(
                                    '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${calculatePercentageOf(getDoubleValue(controller.mOrderPlace.value.subTotal ?? 0), getDoubleValue(mTaxData.taxPercentage)).toStringAsFixed(2)}',
                                    style: getTextRegular(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                ],
                              )),
                          Container(
                            height: 3.sp,
                            margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ));
                }),

            ///total
            Container(
                margin: EdgeInsets.all(
                  8.sp,
                ),
                padding: EdgeInsets.only(
                    left: 8.sp, right: 8.sp, top: 3.sp, bottom: 3.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sTotal.tr,
                      style: getTextRegular(
                          size: 11.5.sp, colors: ColorConstants.cAppButtonColour),
                    ),
                    Text(
                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0).toStringAsFixed(2)}',
                      style: getTextRegular(
                          size: 11.5.sp, colors: ColorConstants.cAppButtonColour),
                    ),
                  ],
                )),
            Container(
              height: 3.sp,
              margin: EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 8.sp),
              color: Colors.grey.shade300,
            ),

            ///Rounding
            Container(
                margin: EdgeInsets.only(
                    left: 8.sp, right: 8.sp, top: 3.sp, bottom: 8.sp),
                padding: EdgeInsets.only(
                    left: 8.sp, right: 8.sp, top: 0.sp, bottom: 3.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sRounding.tr,
                      style: getTextRegular(
                          size: 11.5.sp, colors: ColorConstants.cAppTaxColour),
                    ),
                    (controller.mOrderPlace.value.paymentStatus != 'S')
                        ? Text(
                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(getDoubleValue(roundToNearestPossible(getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0))) - getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0)).toStringAsFixed(2)}',
                      style: getTextRegular(
                          size: 11.5.sp,
                          colors: ColorConstants.cAppTaxColour),
                    )
                        : Text(
                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(controller.mOrderPlace.value.adjustedAmount ?? 0) > 0 ? (getDoubleValue(controller.mOrderPlace.value.adjustedAmount ?? 0) - getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0)).toStringAsFixed(2) : (getDoubleValue(controller.mOrderPlace.value.grandTotal ?? 0) - getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0)).toStringAsFixed(2)}',
                      style: getTextRegular(
                          size: 11.5.sp,
                          colors: ColorConstants.cAppTaxColour),
                    ),
                    // Text(
                    //   '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0) - getDoubleValue(controller.mOrderPlace.value?.rounOffPrice ?? 0)).toStringAsFixed(2)}',
                    //   style: getTextRegular(
                    //       size: 11.5.sp, colors: ColorConstants.cAppTaxColour),
                    // ),
                  ],
                )),
            Container(
              height: 3.sp,
              margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
              color: Colors.grey.shade300,
            ),

            ///total pay
            Container(
                margin: EdgeInsets.all(
                  8.sp,
                ),
                padding: EdgeInsets.only(
                    left: 8.sp, right: 8.sp, top: 3.sp, bottom: 3.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sPayableAmount.tr,
                      style: getText500(
                          size: 12.5.sp, colors: ColorConstants.cAppButtonColour),
                    ),
                    (controller.mOrderPlace.value.paymentStatus != 'S')
                        ? Text(
                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(roundToNearestPossible(getDoubleValue(controller.mOrderPlace.value.totalAmount ?? 0))).toStringAsFixed(2)}',
                      style: getText500(
                          size: 12.5.sp,
                          colors: ColorConstants.cAppButtonColour),
                    )
                        : Text(
                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(controller.mOrderPlace.value.adjustedAmount ?? 0) > 0 ? getDoubleValue(controller.mOrderPlace.value.adjustedAmount ?? 0).toStringAsFixed(2) : getDoubleValue(controller.mOrderPlace.value.grandTotal ?? 0).toStringAsFixed(2)}',
                      style: getText500(
                          size: 12.5.sp,
                          colors: ColorConstants.cAppButtonColour),
                    ),
                  ],
                )),
            Container(
              height: 3.sp,
              margin: EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 12.sp),
              color: Colors.grey.shade300,
            ),

            ///remark
            Visibility(
                visible: (controller.mOrderPlace.value.paymentStatus == 'P' ||
                    controller.mOrderPlace.value.paymentStatus == 'F') &&
                    (controller.mOrderPlace.value.paymentStatus != 'S'),
                child: Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                    height: 19.5.sp,
                    child: TextInputWidget(
                      placeHolder: sRemark.tr,
                      isReadOnly: true,
                      textColor: Colors.grey,
                      controller: controller.remarkController.value,
                      errorText: null,
                      textInputType: TextInputType.text,
                      hintText: sRemark.tr,
                      showFloatingLabel: false,
                      topPadding: 5.sp,
                      hintTextColor: ColorConstants.black.withOpacity(0.50),
                      hintTextSize: 11.sp,
                      textSize: 11.5.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternStringAndSpace)),
                      ],
                    ))),

            ///button Place Order
            Visibility(
                visible: (controller.mOrderPlace.value.paymentStatus != 'C'),
                child: Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
                    child: rectangleCornerButtonText600(
                      height: 19.5.sp,
                      textSize: 11.5.sp,
                      sPrintKot.tr,
                          () {
                        controller.mTableController
                            .onPrintKot(controller.index.value);
                      },
                    ))),
            Visibility(
                visible: (controller.mOrderPlace.value.paymentStatus == 'P' ||
                    controller.mOrderPlace.value.paymentStatus == 'F') &&
                    (controller.mOrderPlace.value.paymentStatus != 'S') &&
                    (controller.mOrderPlace.value.paymentGatewayNo == 1 ||
                        controller.mOrderPlace.value.paymentGatewayNo == 2),
                child: Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
                    child: const Text('You can able to change the payment type'))),

            ///button Pay and Invoice
            Visibility(
                visible: (controller.mOrderPlace.value.paymentStatus == 'P' ||
                    controller.mOrderPlace.value.paymentStatus == 'F') &&
                    (controller.mOrderPlace.value.paymentStatus != 'S'),
                child: Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
                    child: rectangleCornerButtonText600(
                      boderColor: ColorConstants.cAppButtonInviceColour,
                      bgColor: ColorConstants.cAppButtonInviceColour,
                      textColor: ColorConstants.cAppTextInviceColour,
                      height: 19.5.sp,
                      textSize: 11.5.sp,
                      sPayInvoice.tr,
                          () {
                        controller.onPayment();
                      },
                    ))),
            SizedBox(
              height: 8.sp,
            )
          ]));
    },);
  }
}
