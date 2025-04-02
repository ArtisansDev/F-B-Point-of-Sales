/*
 * Project      : fnb_point_sale_app
 * File         : table_row_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common_view/button_view/button_view.dart';
import '../../controller/menu_sales_controller.dart';

class SalesListRowView extends StatelessWidget {
  late MenuSalesController controller;
  late int index;

  SalesListRowView({super.key, required this.index}) {
    controller = Get.find<MenuSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    OrderHistoryData mOrderHistoryData = controller.mOrderHistoryData[index];
    String orderSource = (mOrderHistoryData.orderSource ?? 1) == 1
        ? 'App'
        : (mOrderHistoryData.orderSource ?? 1) == 2
            ? 'Pos'
            : 'Web';
    return Container(
      padding:
          EdgeInsets.only(top: 11.sp, left: 11.sp, right: 11.sp, bottom: 11.sp),
      child: Row(
        children: [
          SizedBox(
            width: 15.sp,
          ),
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${controller.mDashboardScreenController.mRestaurantData.value?.orderIDPrefixCode ?? ''}${mOrderHistoryData.trackingOrderID ?? ''}',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 10.5.sp),
                ),
              )),
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (mOrderHistoryData.orderType ?? 1) == 1
                      ? '${orderSource}\nDine In'
                      : '${orderSource}\nTake Away',
                  textAlign: TextAlign.center,
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (mOrderHistoryData.name ?? '').isEmpty
                      ? '--'
                      : (mOrderHistoryData.name ?? ''),
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (mOrderHistoryData.phoneNumber ?? '').isEmpty
                      ? '--'
                      : '${mOrderHistoryData.phoneCountryCode ?? ' '} ${mOrderHistoryData.phoneNumber ?? ' '}',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getUTCToLocalDateTime(mOrderHistoryData.orderDate ?? ''),
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  mOrderHistoryData.tableNo ?? '--',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  controller.clickPaymentType(index);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    (mOrderHistoryData.paymentGatewayName ?? "").isEmpty
                        ? '--'
                        : (mOrderHistoryData.paymentGatewayName ?? ""),
                    textAlign: TextAlign.center,
                    style: (mOrderHistoryData.counterBalanceHistoryIDF ?? "")
                                    .toUpperCase()
                                    .toString() !=
                                controller.sCounterBalanceHistoryIDF.value
                                    .toString()
                                    .trim()
                                    .toUpperCase() ||
                            (mOrderHistoryData.paymentGatewayName ?? "")
                                .isEmpty ||
                            (mOrderHistoryData.isPaymentTypeChanged ?? false)
                        ? getTextRegular(
                            colors: ColorConstants.appTextSalesHader,
                            size: 11.sp)
                        : getText600(
                            colors: ColorConstants.appTextSalesHader,
                            size: 11.sp),
                  ),
                ),
              )),
          Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${(mOrderHistoryData.adjustedAmount ?? 0.0) > 0 ? (mOrderHistoryData.adjustedAmount ?? 0.0).toStringAsFixed(2) : (mOrderHistoryData.totalAmount ?? 0.0).toStringAsFixed(2)}',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 6.5.w,
                    child: (mOrderHistoryData.paymentStatus
                                .toString()
                                .toUpperCase() ==
                            'R')
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Refund',
                              style:
                                  getText500(size: 11.sp, colors: Colors.red),
                            ),
                          )
                        : (mOrderHistoryData.paymentStatus == 'C')
                            ? Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Cancel',
                                  style: getText500(
                                      size: 11.sp, colors: Colors.red),
                                ),
                              )
                            : (mOrderHistoryData.paymentStatus == 'P' ||
                                        mOrderHistoryData.paymentStatus ==
                                            'F') &&
                                    (mOrderHistoryData.paymentStatus != 'S')
                                ? mOrderHistoryData.paymentGatewayNo == 1 ||
                                        mOrderHistoryData.paymentGatewayNo == 2
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.onAlertView(index);
                                        },
                                        child: Container(
                                          height: 16.5.sp,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.sp),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.15),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ], // use instead of BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8.sp,
                                              ),
                                              const Text('Pending'),
                                              SizedBox(
                                                width: 8.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : rectangleCornerButtonText600(
                                        sPAY.tr,
                                        height: 16.5.sp,
                                        textSize: 10.5.sp,
                                        () {
                                          controller.onPayNow(index);
                                        },
                                      )
                                : Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Success',
                                      style: getText500(
                                          size: 11.sp,
                                          colors: ColorConstants
                                              .cAppTextInviceColour),
                                    ),
                                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onView(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.sp, left: 10.sp),
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
                        Icons.remove_red_eye_outlined,
                        color: ColorConstants.white,
                        size: 11.sp,
                      ),
                    ),
                  ),
                  (mOrderHistoryData.paymentStatus != 'C' &&
                          mOrderHistoryData.paymentStatus != 'R')
                      ? GestureDetector(
                          onTap: () {
                            controller.onPrintKot(index);
                          },
                          child: Container(
                            height: 16.5.sp,
                            width: 16.5.sp,
                            margin: EdgeInsets.only(right: 10.sp),
                            padding: EdgeInsets.all(8.5.sp),
                            decoration: BoxDecoration(
                              color: ColorConstants.cAppTextInviceColour
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.sp),
                              ),
                            ),
                            child: Image.asset(
                              ImageAssetsConstants.appPrint,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                      : Container(
                          height: 16.5.sp,
                          width: 16.5.sp,
                          margin: EdgeInsets.only(right: 10.sp),
                          padding: EdgeInsets.all(8.5.sp),
                        ),
                  ((mOrderHistoryData.paymentStatus == 'S' &&
                              mOrderHistoryData.paymentStatus != 'C') ||
                          mOrderHistoryData.paymentStatus == 'R')
                      ? GestureDetector(
                          onTap: () {
                            if (mOrderHistoryData.paymentStatus == 'R') {
                              controller.onPrintRefund(index);
                            } else {
                              controller.onPrint(index);
                            }
                          },
                          child: Container(
                            height: 16.5.sp,
                            width: 16.5.sp,
                            margin: EdgeInsets.only(right: 10.sp),
                            padding: EdgeInsets.all(8.5.sp),
                            decoration: BoxDecoration(
                              color: ColorConstants.cAppButtonColour,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.sp),
                              ),
                            ),
                            child: Image.asset(
                              ImageAssetsConstants.appPrint,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                      : Container(
                          height: 16.5.sp,
                          width: 16.5.sp,
                          padding: EdgeInsets.all(8.5.sp),
                          margin: EdgeInsets.only(right: 10.sp),
                        ),
                  (mOrderHistoryData.paymentStatus == 'S' &&
                      (mOrderHistoryData.counterBalanceHistoryIDF ?? "")
                          .toUpperCase()
                          .toString() ==
                          controller.sCounterBalanceHistoryIDF.value
                              .toString()
                              .trim()
                              .toUpperCase())
                      ? GestureDetector(
                          onTap: () {
                            controller.onRefund(index);
                          },
                          child: Container(
                            height: 16.5.sp,
                            width: 16.5.sp,
                            padding: EdgeInsets.all(6.5.sp),
                            decoration: BoxDecoration(
                              color: ColorConstants.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.sp),
                              ),
                            ),
                            child: Image.asset(
                              ImageAssetsConstants.appRefund,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                      : Container(
                          height: 16.5.sp,
                          width: 16.5.sp,
                          padding: EdgeInsets.all(8.5.sp),
                        ),
                ],
              )),
        ],
      ),
    );
  }
}
