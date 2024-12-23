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
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/menu_sales_controller.dart';
import 'calender_view.dart';

class SearchDateView extends StatelessWidget {
  late MenuSalesController controller;

  SearchDateView({super.key}) {
    controller = Get.find<MenuSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            ///search
            Expanded(
              flex: 10,
              child: Container(
                  height: 22.sp,
                  margin:
                      EdgeInsets.only(top: 11.sp, left: 11.sp, bottom: 8.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextInputWidget(
                        placeHolder: sSearchOrderNo.tr,
                        controller: controller.searchController.value,
                        errorText: null,
                        textInputType: TextInputType.emailAddress,
                        hintText: sSearchOrderNo.tr,
                        showFloatingLabel: false,
                        topPadding: 5.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(AppUtilConstants.patternOnlyString)),
                        ],
                      )),
                      GestureDetector(
                        onTap: () {
                          // Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5.sp),
                          height: 21.sp,
                          width: 21.sp,
                          padding: EdgeInsets.all(9.5.sp),
                          decoration: BoxDecoration(
                            color: ColorConstants.cAppButtonColour,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.sp),
                            ),
                          ),
                          child: Image.asset(
                            ImageAssetsConstants.appSearch,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    ],
                  )),
            ),

            ///calendar
            Expanded(
              flex: 10,
              child: Container(
                  height: 22.sp,
                  margin: EdgeInsets.only(
                      top: 11.sp, left: 8.sp, right: 8.sp, bottom: 8.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextInputWidget(
                        isReadOnly: true,
                        placeHolder: sSelectDateRange.tr,
                        controller: controller.sSelectDateRangeController.value,
                        errorText: null,
                        textInputType: TextInputType.emailAddress,
                        hintText: sSelectDateRange.tr,
                        showFloatingLabel: false,
                        topPadding: 5.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                      )),
                      CalenderView()
                    ],
                  )),
            ),

            ///select Type
            Expanded(
              flex: 8,
              child: Obx(
                () => Container(
                    margin:
                        EdgeInsets.only(top: 11.sp, right: 11.sp, bottom: 8.sp),
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.selectType.value = sAll.tr;
                            },
                            child: Container(
                                height: 21.sp,
                                width: 21.sp,
                                padding: EdgeInsets.all(9.5.sp),
                                decoration: BoxDecoration(
                                  color: controller.selectType.value == sAll.tr
                                      ? ColorConstants.cAppButtonColour
                                      : ColorConstants.primaryBackgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.sp),
                                    bottomLeft: Radius.circular(8.sp),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  sAll.tr,
                                  style: getText500(
                                      size: 11.sp,
                                      colors:
                                          controller.selectType.value == sAll.tr
                                              ? ColorConstants.white
                                              : ColorConstants.cAppTaxColour),
                                )),
                          ),
                        ),
                        Container(
                          width: 5.sp,
                          height: 21.sp,
                          color: ColorConstants.appEditTextHint,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.selectType.value = sDine_In.tr;
                            },
                            child: Container(
                                height: 21.sp,
                                width: 21.sp,
                                padding: EdgeInsets.all(9.5.sp),
                                decoration: BoxDecoration(
                                  color: controller.selectType.value ==
                                          sDine_In.tr
                                      ? ColorConstants.cAppButtonColour
                                      : ColorConstants.primaryBackgroundColor,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  sDine_In.tr,
                                  style: getText500(
                                      size: 11.sp,
                                      colors: controller.selectType.value ==
                                              sDine_In.tr
                                          ? ColorConstants.white
                                          : ColorConstants.cAppTaxColour),
                                )),
                          ),
                        ),
                        Container(
                          width: 5.sp,
                          height: 21.sp,
                          color: ColorConstants.appEditTextHint,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.selectType.value = sTake_Away.tr;
                            },
                            child: Container(
                                height: 21.sp,
                                width: 21.sp,
                                padding: EdgeInsets.all(9.5.sp),
                                decoration: BoxDecoration(
                                  color: controller.selectType.value ==
                                          sTake_Away.tr
                                      ? ColorConstants.cAppButtonColour
                                      : ColorConstants.primaryBackgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.sp),
                                    bottomRight: Radius.circular(8.sp),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  sTake_Away.tr,
                                  style: getText500(
                                      size: 11.sp,
                                      colors: controller.selectType.value ==
                                              sTake_Away.tr
                                          ? ColorConstants.white
                                          : ColorConstants.cAppTaxColour),
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }
}
