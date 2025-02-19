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
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/hold_sales_controller.dart';

class HoldSalesListRowView extends StatelessWidget {
  late HoldSalesController controller;
  late int index;

  HoldSalesListRowView({super.key, required this.index}) {
    controller = Get.find<HoldSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    OrderPlace mOrderPlace =
        controller.mHoldSaleModel.value?.mOrderPlace?[index] ?? OrderPlace();
    return Container(
      padding:
          EdgeInsets.only(top: 11.sp, left: 11.sp, right: 11.sp, bottom: 11.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            alignment: Alignment.center,
            width: 15.sp,
          ),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${controller.mDashboardScreenController.mRestaurantData.value?.orderIDPrefixCode ?? ''}${mOrderPlace.sOrderNo ?? ''}',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 10.5.sp),
                ),
              )),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '--',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  mOrderPlace.dateTime,
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Dine-In',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  mOrderPlace.tableNo ?? "--",
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 7,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${mOrderPlace.totalPrice.toStringAsFixed(2)}',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.onEditHoldSale(index, mOrderPlace);
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
                        Icons.edit,
                        color: ColorConstants.white,
                        size: 11.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onDeleteHoldSale(index, mOrderPlace);
                    },
                    child: Container(
                      height: 16.5.sp,
                      width: 16.5.sp,
                      padding: EdgeInsets.all(8.5.sp),
                      decoration: BoxDecoration(
                        color: ColorConstants.cAppButtonColour,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.sp),
                        ),
                      ),
                      child: Icon(
                        Icons.delete_forever,
                        color: ColorConstants.white,
                        size: 11.sp,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
    ;
  }
}
