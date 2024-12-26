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
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/button_bar/button_bar_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/table_controller.dart';

class TableRowView extends StatelessWidget {
  late TableController controller;
  final int index;

  TableRowView({super.key, required this.index}) {
    controller = Get.find<TableController>();
  }

  @override
  Widget build(BuildContext context) {
    GetAllTablesResponseData mGetAllTablesResponseData =
        controller.mGetAllTablesList[index];
    OrderPlace mOrderPlace =
        controller.getOrderPlace(mGetAllTablesResponseData.seatIDP ?? '');
    return GestureDetector(
      onTap: () {
        controller.onTableSelectClick(index);
      },
      child: Container(
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
                color: ColorConstants.cAppButtonLightColour,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.sp),
                  topRight: Radius.circular(8.sp),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'Table No ${mGetAllTablesResponseData.seatNumber ?? ''}',
                    style: getText500(
                        size: 11.6.sp, colors: ColorConstants.cAppButtonColour),
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
            Stack(
              alignment: Alignment.center,
              children: [
                (mOrderPlace.cartItem ?? []).isNotEmpty
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
                                    'Order No: ',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    mOrderPlace.sOrderNo,
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
                                    'Time: ',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    mOrderPlace.dateTime ?? '',
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
                                bottom: 11.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Amount: ',
                                    style: getText300(
                                        size: 11.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(mOrderPlace.totalPrice ?? 0).toStringAsFixed(2)}',
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.cAppTaxColour),
                                  ),
                                )
                              ],
                            ),
                          ),
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
                            Text(
                              'Tap to Reserve',
                              style: getText300(
                                  size: 11.sp, colors: ColorConstants.black),
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                          ],
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
