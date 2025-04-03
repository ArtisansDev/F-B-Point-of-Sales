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
import 'package:fnb_point_sale_base/common/dropdown_button_view/dropdown_button2.dart';
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
              flex: 9,
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
                        textInputType: TextInputType.text,
                        hintText: sSearchOrderNo.tr,
                        showFloatingLabel: false,
                        topPadding: 5.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                        onSubmit: () {
                          controller.search.value =
                              controller.searchController.value.text;
                          controller.search.refresh();
                          controller.pageNumber.value = 1;
                          controller.sLoading.value = 'Loading...';
                          controller.callOrderHistory();
                        },
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              AppUtilConstants.patternStringNumberSpace)),
                        ],
                      )),
                      Visibility(
                          visible: controller.search.value.isNotEmpty,
                          child: GestureDetector(
                            onTap: () {
                              controller.searchController.value.text = "";
                              controller.search.value = "";
                              controller.search.refresh();
                              controller.pageNumber.value = 1;
                              controller.sLoading.value = 'Loading...';
                              controller.callOrderHistory();
                            },
                            child: Container(
                                margin:
                                    EdgeInsets.only(left: 8.sp, right: 8.sp),
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  color: ColorConstants.cAppButtonColour,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.sp),
                                  ),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: ColorConstants.white,
                                  size: 12.5.sp,
                                )),
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.search.value =
                              controller.searchController.value.text;
                          controller.search.refresh();
                          controller.pageNumber.value = 1;
                          controller.sLoading.value = 'Loading...';
                          controller.callOrderHistory();
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
              flex: 7,
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
                        leftPadding: 13.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.2.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                      )),
                      Visibility(
                          visible: controller
                              .sSelectDateRangeController.value.text.isNotEmpty,
                          child: GestureDetector(
                            onTap: () {
                              controller.sSelectDateRangeController.value.text =
                                  "";
                              controller.selectedDateRange = null;
                              controller.sSelectDateRangeController.refresh();
                              controller.pageNumber.value = 1;
                              controller.sLoading.value = 'Loading...';
                              controller.callOrderHistory();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 6.5.sp),
                                padding: EdgeInsets.all(7.sp),
                                decoration: BoxDecoration(
                                  color: ColorConstants.cAppButtonColour,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.sp),
                                  ),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: ColorConstants.white,
                                  size: 12.5.sp,
                                )),
                          )),
                      CalenderView()
                    ],
                  )),
            ),

            ///orderSource
            Expanded(
                flex: 4,
                child: Obx(() => Container(
                    height: 22.sp,
                    margin:
                        EdgeInsets.only(top: 11.sp, right: 8.sp, bottom: 8.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: orderSource()))),

            ///paymentStatus
            Expanded(
                flex: 4,
                child: Obx(() => Container(
                    height: 22.sp,
                    margin:
                        EdgeInsets.only(top: 11.sp, right: 8.sp, bottom: 8.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: paymentStatus()))),

            /// select Type
            Expanded(
                flex: 4,
                child: Obx(() => Container(
                    height: 22.sp,
                    margin:
                        EdgeInsets.only(top: 11.sp, right: 8.sp, bottom: 8.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: selectType()))),

            ///ref
            GestureDetector(
              onTap: () {
                controller.searchController.value.text = "";
                controller.search.value = "";

                controller.orderType = 0;
                controller.selectType.value = 'Select Type';

                controller.orderSource.value = 0;
                controller.selectOrderSourceType.value = 'Select Source';

                controller.paymentStatus.value = null;
                controller.selectPaymentStatus.value = 'Payment Status';

                controller.selectedDateRange = null;
                controller.sSelectDateRangeController.value.text = "";

                controller.search.refresh();

                controller.pageNumber.value = 1;
                controller.sLoading.value = 'Loading...';
                controller.callOrderHistory();
              },
              child: Container(
                  margin:
                      EdgeInsets.only(top: 11.sp, right: 10.sp, bottom: 8.sp),
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cAppButtonColour,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: ColorConstants.white,
                    size: 13.5.sp,
                  )),
            )
          ],
        ));
  }

  Widget selectType() => DropdownButton2(
        barrierColor: Colors.transparent,
        focusColor: Colors.white,
        hint: Text(
          controller.selectType.value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getTextRegular(size: 11.sp, colors: Colors.black),
        ),
        isExpanded: true,
        items: controller.selectTypeList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getTextRegular(
                        size: 11.sp, colors: ColorConstants.appTextSalesHader),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          controller.selectType.value = value.toString();
          if (controller.selectType.value == sAll.tr) {
            controller.orderType = 0;
          } else if (controller.selectType.value == sDine_In.tr) {
            controller.orderType = 1;
          } else if (controller.selectType.value == sTake_Away.tr) {
            controller.orderType = 2;
          }
          controller.pageNumber.value = 1;
          controller.sLoading.value = 'Loading...';
          controller.callOrderHistory();
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        icon: Row(
          children: [
            // if (selectedSaleStatus == null)
            //   const SizedBox()
            // else
            //   GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         selectedSaleStatus = null;
            //         pageNo = 1;
            //         _getSales();
            //       });
            //     },
            //     child: Icon(
            //       Icons.clear,
            //       size: 13.sp,
            //       color: ColorConstants.cAppButtonTextBlue,
            //     ),
            //   ),
            Icon(
              Icons.arrow_drop_down,
              size: 15.sp,
              // Custom dropdown icon
              color: ColorConstants.cAppButtonColour,
            )
          ],
        ),
        offset: const Offset(0, -10),
        underline: const SizedBox(),
      );

  Widget orderSource() => DropdownButton2(
        barrierColor: Colors.transparent,
        focusColor: Colors.white,
        hint: Text(
          controller.selectOrderSourceType.value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getTextRegular(size: 11.sp, colors: Colors.black),
        ),
        isExpanded: true,
        items: controller.orderSourceList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getTextRegular(
                        size: 11.sp, colors: ColorConstants.appTextSalesHader),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          controller.selectOrderSourceType.value = value.toString();
          if (controller.selectOrderSourceType.value == sAll.tr) {
            controller.orderSource.value = 0;
          } else if (controller.selectOrderSourceType.value == 'Mobile App') {
            controller.orderSource.value = 1;
          } else if (controller.selectOrderSourceType.value == 'Pos') {
            controller.orderSource.value = 2;
          } else if (controller.selectOrderSourceType.value == 'Web') {
            controller.orderSource.value = 3;
          }
          controller.pageNumber.value = 1;
          controller.sLoading.value = 'Loading...';
          controller.callOrderHistory();
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        icon: Row(
          children: [
            // if (selectedSaleStatus == null)
            //   const SizedBox()
            // else
            //   GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         selectedSaleStatus = null;
            //         pageNo = 1;
            //         _getSales();
            //       });
            //     },
            //     child: Icon(
            //       Icons.clear,
            //       size: 13.sp,
            //       color: ColorConstants.cAppButtonTextBlue,
            //     ),
            //   ),
            Icon(
              Icons.arrow_drop_down,
              size: 15.sp,
              // Custom dropdown icon
              color: ColorConstants.cAppButtonColour,
            )
          ],
        ),
        offset: const Offset(0, -10),
        underline: const SizedBox(),
      );

  Widget paymentStatus() => DropdownButton2(
        barrierColor: Colors.transparent,
        focusColor: Colors.white,
        hint: Text(
          controller.selectPaymentStatus.value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getTextRegular(size: 11.sp, colors: Colors.black),
        ),
        isExpanded: true,
        items: controller.paymentStatusList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getTextRegular(
                        size: 11.sp, colors: ColorConstants.appTextSalesHader),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          controller.selectPaymentStatus.value = value.toString();
          if (controller.selectPaymentStatus.value == 'All') {
            controller.selectPaymentStatus.value = "Payment Status";
            controller.paymentStatus.value = null;
          } else if (controller.selectPaymentStatus.value == 'Success') {
            controller.paymentStatus.value = 'S';
          } else if (controller.selectPaymentStatus.value == 'Pending') {
            controller.paymentStatus.value = 'P';
          } else if (controller.selectPaymentStatus.value == 'Refund') {
            controller.paymentStatus.value = 'R';
          } else if (controller.selectPaymentStatus.value == 'Cancel') {
            controller.paymentStatus.value = 'C';
          }
          controller.pageNumber.value = 1;
          controller.sLoading.value = 'Loading...';
          controller.callOrderHistory();
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        icon: Row(
          children: [
            // if (selectedSaleStatus == null)
            //   const SizedBox()
            // else
            //   GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         selectedSaleStatus = null;
            //         pageNo = 1;
            //         _getSales();
            //       });
            //     },
            //     child: Icon(
            //       Icons.clear,
            //       size: 13.sp,
            //       color: ColorConstants.cAppButtonTextBlue,
            //     ),
            //   ),
            Icon(
              Icons.arrow_drop_down,
              size: 15.sp,
              // Custom dropdown icon
              color: ColorConstants.cAppButtonColour,
            )
          ],
        ),
        offset: const Offset(0, -10),
        underline: const SizedBox(),
      );
}
