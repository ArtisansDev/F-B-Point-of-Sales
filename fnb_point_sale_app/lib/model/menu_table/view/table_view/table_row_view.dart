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
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/button_bar/button_bar_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/table_controller.dart';

class TableRowView extends StatelessWidget {
  late TableController controller;
  final int index;
  final GetAllTablesResponseData mGetAllTablesResponseData;

  TableRowView(
      {super.key,
      required this.index,
      required this.mGetAllTablesResponseData}) {
    controller = Get.find<TableController>();
  }

  @override
  Widget build(BuildContext context) {
    // OrderPlace mOrderPlace =
    //     controller.getOrderPlace(mGetAllTablesResponseData.seatIDP ?? '');
    TablesByTableStatusData mOrderPlace = controller
        .getTablesByTableStatusData(mGetAllTablesResponseData.seatIDP ?? '');
    return GestureDetector(
      onTap: () {
        controller.onTableSelectClick(mGetAllTablesResponseData, mOrderPlace);
      },
      child: Container(
        height: 24.h,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8.sp),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 11.sp, left: 11.sp, right: 11.sp, bottom: 11.sp),
              decoration: BoxDecoration(
                color: (mOrderPlace.paymentStatus == 'C')
                    ? Colors.red.withOpacity(0.25)
                    : (mOrderPlace.seatIDP ?? '').isNotEmpty
                        ? Colors.green.withOpacity(0.15)
                        : (!(mGetAllTablesResponseData.isDeleted ?? false) &&
                                (mGetAllTablesResponseData.isActive ?? false))
                            ? ColorConstants.cAppButtonLightColour
                            : Colors.red.withOpacity(0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.sp),
                  topRight: Radius.circular(8.sp),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '${sSeatingNo.tr} ${mGetAllTablesResponseData.seatNumber ?? ''}',
                    style: getText500(
                        size: 11.6.sp,
                        colors: (mOrderPlace.paymentStatus == 'C')
                            ? Colors.red
                            : (mOrderPlace.seatIDP ?? '').isNotEmpty
                                ? Colors.green
                                : (!(mGetAllTablesResponseData.isDeleted ??
                                            false) &&
                                        (mGetAllTablesResponseData.isActive ??
                                            false))
                                    ? ColorConstants.cAppButtonColour
                                    : Colors.red),
                  )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${mGetAllTablesResponseData.seatingCapacity ?? ''} Seat(s)',
                        style: getText500(
                            size: 11.sp, colors: ColorConstants.cAppTaxColour),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Stack(
              alignment: Alignment.center,
              children: [
                // (mOrderPlace.cartItem ?? []).isNotEmpty
                (mOrderPlace.seatIDP ?? '').isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 8.sp,
                                left: 11.sp,
                                right: 11.sp,
                                bottom: 8.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Order No ',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    mOrderPlace.occupiedTrackingOrderID ?? '',
                                    maxLines: 1,
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 11.sp,
                              right: 11.sp,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Time ',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    getUTCToLocalDateTime(
                                        mOrderPlace.orderDate ?? ''),
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 8.sp,
                                left: 11.sp,
                                right: 11.sp,
                                bottom: 8.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Amount ',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(mOrderPlace.totalPayableAmount ?? 0).toStringAsFixed(2)}',
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 11.sp, right: 11.sp, bottom: 9.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Order From',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    (mOrderPlace.orderSource ?? '1') == '1'
                                        ? 'APP'
                                        : (mOrderPlace.orderSource ?? '1') ==
                                                '2'
                                            ? 'POS'
                                            : 'WEB',
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              color: (mOrderPlace.paymentStatus == 'C')
                                  ? Colors.red.withOpacity(0.25)
                                  : (mOrderPlace.seatIDP ?? '').isNotEmpty
                                      ? Colors.green.withOpacity(0.15)
                                      : (!(mGetAllTablesResponseData
                                                      .isDeleted ??
                                                  false) &&
                                              (mGetAllTablesResponseData
                                                      .isActive ??
                                                  false))
                                          ? ColorConstants.cAppButtonLightColour
                                          : Colors.red.withOpacity(0.15),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8.sp),
                                bottomLeft: Radius.circular(8.sp),
                              ),
                            ),
                            child: Row(
                              children: [
                                 Expanded(child: Container(
                                  child: (mOrderPlace.paymentStatus == 'C')
                                      ?Text('Order Cancel'):SizedBox(),
                                   padding: EdgeInsets.only(left: 10.sp),
                                )),
                                Visibility(
                                    visible: mOrderPlace.paymentStatus != 'P',
                                    child: Container(
                                        width: 6.w,
                                        margin: EdgeInsets.only(
                                            left: 8.sp,
                                            right: 8.sp,
                                            top: 8.sp,
                                            bottom: 8.sp),
                                        child: rectangleCornerButtonText500(
                                          boderColor: (mOrderPlace.paymentStatus == 'C')
                                              ? Colors.red.withOpacity(0.05): ColorConstants
                                              .cAppButtonInviceColour,
                                          bgColor:  (mOrderPlace.paymentStatus == 'C')
                                              ? Colors.red.withOpacity(0.35):ColorConstants
                                              .cAppButtonInviceColour,
                                          textColor:  (mOrderPlace.paymentStatus == 'C')
                                              ? Colors.red:ColorConstants
                                              .cAppTextInviceColour,
                                          height: 17.5.sp,
                                          textSize: 10.sp,
                                          sClear.tr,
                                          () {
                                            controller.onClear(mOrderPlace);
                                          },
                                        ))),
                              ],
                            ),
                          ))
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        height: 10.2.h,
                        margin: EdgeInsets.only(bottom: 1.1.h),
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (!(mGetAllTablesResponseData.isDeleted ??
                                          false) &&
                                      (mGetAllTablesResponseData.isActive ??
                                          false))
                                  ? 'OPEN'
                                  : 'CLOSE',
                              style: getText500(
                                  size: 11.5.sp,
                                  colors: (!(mGetAllTablesResponseData
                                                  .isDeleted ??
                                              false) &&
                                          (mGetAllTablesResponseData.isActive ??
                                              false))
                                      ? ColorConstants.cAppButtonInviceColour
                                      : ColorConstants.red),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Visibility(
                                visible:
                                    (!(mGetAllTablesResponseData.isDeleted ??
                                            false) &&
                                        (mGetAllTablesResponseData.isActive ??
                                            false)),
                                child: Text(
                                  'Tap to Reserve',
                                  style: getText300(
                                      size: 11.sp,
                                      colors: ColorConstants.black),
                                )),
                            SizedBox(
                              height: 8.sp,
                            ),
                          ],
                        ),
                      )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
