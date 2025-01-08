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
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import '../controller/selected_order_controller.dart';

class SelectedOrderBottomView extends StatelessWidget {
  late SelectedOrderController controller;

  SelectedOrderBottomView({super.key}) {
    controller = Get.find<SelectedOrderController>();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: (controller.mOrderPlace.value?.cartItem ?? []).isNotEmpty,
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
                        size: 11.sp, colors: ColorConstants.cAppTaxColour),
                  ),
                  Text(
                    '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${(controller.mOrderPlace.value?.subTotalPrice ?? 0).toStringAsFixed(2)}',
                    style: getTextRegular(
                        size: 11.sp, colors: ColorConstants.cAppTaxColour),
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
                  (controller.mDashboardScreenController.taxData ?? []).length,
              itemBuilder: (BuildContext context, int index) {
                TaxData mTaxData =
                    (controller.mDashboardScreenController.taxData ??
                        [])[index];
                return Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(
                          8.sp,
                        ),
                        padding: EdgeInsets.only(
                            left: 8.sp, right: 8.sp, top: 5.sp, bottom: 5.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${mTaxData.taxName ?? ''}+ (${mTaxData.taxPercentage}%)',
                              style: getTextRegular(
                                  size: 11.sp,
                                  colors: ColorConstants.cAppTaxColour),
                            ),
                            Text(
                              '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${calculatePercentageOf(getDoubleValue(controller.mOrderPlace.value?.subTotalPrice ?? 0), getDoubleValue(mTaxData.taxPercentage)).toStringAsFixed(2)}',
                              style: getTextRegular(
                                  size: 11.sp,
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
                );
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
                    '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(controller.mOrderPlace.value?.totalPrice ?? 0).toStringAsFixed(2)}',
                    style: getTextRegular(
                        size: 11.5.sp, colors: ColorConstants.cAppButtonColour),
                  ),
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
                    sTotalPay.tr,
                    style: getText500(
                        size: 12.5.sp, colors: ColorConstants.cAppButtonColour),
                  ),
                  Text(
                    '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(controller.mOrderPlace.value?.rounOffPrice ?? 0).toStringAsFixed(2)}',
                    style: getText500(
                        size: 12.5.sp, colors: ColorConstants.cAppButtonColour),
                  ),
                ],
              )),
          Container(
            height: 3.sp,
            margin: EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 12.sp),
            color: Colors.grey.shade300,
          ),

          ///remark
          Container(
              margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
              height: 19.5.sp,
              child: TextInputWidget(
                // isReadOnly: controller.remarkController.value.text.isNotEmpty,
                textColor: Colors.black,
                // controller.remarkController.value.text.isEmpty
                //     ? Colors.black
                //     : Colors.grey,
                placeHolder: sRemark.tr,
                controller: controller.remarkController.value,
                errorText: null,
                textInputType: TextInputType.emailAddress,
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
              )),

          ///button Place Order
          Visibility(
              visible: (controller.mOrderPlace.value?.tableNo ?? '') != '--',
              child: Visibility(
                  visible: controller.placeOrder.value,
                  child: Container(
                      margin:
                          EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
                      child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.5.sp,
                        sPlaceOrder.tr,
                        () {
                          controller.onPlaceOrder();
                        },
                      )))),

          ///button Pay and Invoice
          Container(
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
              )),
          SizedBox(
            height: 8.sp,
          )
        ]));
  }
}
