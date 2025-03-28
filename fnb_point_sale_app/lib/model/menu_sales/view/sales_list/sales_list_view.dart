/*
 * Project      : fnb_point_sale_app
 * File         : table_row_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/sales_list/sales_list_row_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common_view/button_view/button_view.dart';
import '../../controller/menu_sales_controller.dart';

class SalesListView extends StatelessWidget {
  late MenuSalesController controller;

  SalesListView({super.key}) {
    controller = Get.find<MenuSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 7.sp, left: 11.sp, right: 11.sp),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            child: controller.sLoading.isNotEmpty
                ? Center(
                    child: Text(controller.sLoading.value),
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 11.sp,
                            left: 11.sp,
                            right: 11.sp,
                            bottom: 11.sp),
                        decoration: BoxDecoration(
                          color: ColorConstants.cAppButtonLightColour,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.sp),
                            topLeft: Radius.circular(8.sp),
                          ),
                        ),
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
                                    sOrder.tr,
                                    style: getText600(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sType.tr,
                                    style: getText600(
                                        colors:
                                        ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sCustomerName.tr,
                                    style: getText600(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sPhoneNumber.tr,
                                    style: getText600(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sTime.tr,
                                    style: getText600(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),

                            Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sTable.tr,
                                    style: getText600(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sPaymentType.tr,
                                    style: getText600(
                                        colors:
                                        ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    sTotalBill.tr,
                                    style: getText600(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                )),
                            const Expanded(flex: 10, child: SizedBox()),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.mOrderHistoryData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SalesListRowView(
                                  index: index,
                                );
                              })),
                      Visibility(
                          visible: controller.totalPageNumber.value > 1,
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 8.sp,
                                  left: 11.sp,
                                  right: 11.sp,
                                  bottom: 8.sp),
                              decoration: BoxDecoration(
                                color: ColorConstants.cAppButtonLightColour,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.sp),
                                  bottomRight: Radius.circular(8.sp),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 35.w,
                                  child: Obx(
                                    () => NumberPagination(
                                      onPageChanged: (int pageNumber) {
                                        controller.pageNumber.value =
                                            pageNumber;
                                        controller.callOrderHistory();
                                      },
                                      visiblePagesCount: Platform.isIOS
                                          ? 6
                                          : Platform.isAndroid
                                              ? 6
                                              : 10,
                                      totalPages:
                                          controller.totalPageNumber.value,
                                      currentPage: controller.pageNumber.value,
                                      selectedButtonColor:
                                          ColorConstants.cAppButtonColour,
                                      unSelectedNumberColor:
                                          ColorConstants.cAppButtonColour,
                                      buttonRadius: 8.sp,
                                      buttonSelectedBorderColor:
                                          ColorConstants.cAppButtonColour,
                                      buttonUnSelectedBorderColor:
                                          ColorConstants.cAppButtonColour,
                                      numberButtonSize: Size(16.sp, 16.sp),
                                      buttonElevation: 0,
                                      fontSize: 10.sp,
                                      controlButtonSize: Size(16.sp, 16.sp),
                                      lastPageIcon: Icon(
                                        Icons.last_page,
                                        size: 12.sp,
                                        color: ColorConstants.cAppButtonColour,
                                      ),
                                      nextPageIcon: Icon(
                                        Icons.navigate_next,
                                        size: 12.sp,
                                        color: Colors.black,
                                      ),
                                      firstPageIcon: Icon(
                                        Icons.first_page,
                                        size: 12.sp,
                                        color: ColorConstants.cAppButtonColour,
                                      ),
                                      previousPageIcon: Icon(
                                        Icons.navigate_before,
                                        size: 12.sp,
                                        color: Colors.black,
                                      ),
                                      controlButtonColor: Colors.white,
                                    ),
                                  ),
                                ),
                              )))
                    ],
                  ),
          )),
          const ButtonView()
        ],
      ),
    );
  }
}
