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
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common_view/button_view/button_view.dart';
import '../../controller/menu_sales_controller.dart';

class SalesListRowView extends StatelessWidget {
  late MenuSalesController controller;
  late int index;

  SalesListRowView({super.key,required this.index}) {
    controller = Get.find<MenuSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 11.sp, left: 11.sp, right: 11.sp, bottom: 11.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            alignment: Alignment.center,
            // decoration: const BoxDecoration(
            //   color: ColorConstants.cAppButtonColour,
            //   shape: BoxShape.circle,
            // ),
            width: 15.sp,
            // child: Icon(
            //   Icons.add,
            //   color: ColorConstants.white,
            //   size: 14.sp,
            // ),
          ),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  getRandomNumber(),
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader,
                      size: 10.5.sp),
                ),
              )),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Name of Customer',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader,
                      size: 11.sp),
                ),
              )),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '08-11-2024  6:30 PM',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader,
                      size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Dine-In',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader,
                      size: 11.sp),
                ),
              )),
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '#6',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader,
                      size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'RM 56.45',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader,
                      size: 11.sp),
                ),
              )),
          Expanded(
              flex: 9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5.5.w,
                    child: index % 2 == 1
                        ? Center(
                      child: Text(
                        'Done',
                        style: getText600(
                            size: 10.5,
                            colors: ColorConstants
                                .cAppTextInviceColour),
                      ),
                    )
                        : rectangleCornerButtonText600(
                      sPAY.tr,
                      height: 16.5.sp,
                      textSize: 10.5.sp,
                          () {
                        controller.onPayNow(index);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onEdit(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 10.sp, left: 10.sp),
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
                      controller.onDeleteSale(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 10.sp),
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
                        Icons.delete,
                        color: ColorConstants.white,
                        size: 11.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.back();
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
                      child: Image.asset(
                        ImageAssetsConstants.appPrint,
                        fit: BoxFit.fitWidth,
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
