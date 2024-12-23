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
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/hold_sales_controller.dart';
import 'hold_sales_list_row_view.dart';

class HoldSalesListView extends StatelessWidget {
  late HoldSalesController controller;

  HoldSalesListView({super.key}) {
    controller = Get.find<HoldSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          topBarHoldSale(),
          Expanded(
              child: controller.mHoldSaleModel.value == null
                  ? Center(
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(10.5.sp),
                          height: 25.sp,
                          width: 25.sp,
                          child: const CircularProgressIndicator()),
                    )
                  : (controller.mHoldSaleModel.value?.mOrderPlace ?? []).isEmpty
                      ? const Center(
                          child: Text('No hold sale found'),
                        )
                      : Container(
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
                                        flex: 8,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            sOrder.tr,
                                            style: getText600(
                                                colors: ColorConstants
                                                    .appTextSalesHader,
                                                size: 11.sp),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            sCustomerName.tr,
                                            style: getText600(
                                                colors: ColorConstants
                                                    .appTextSalesHader,
                                                size: 11.sp),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            sTime.tr,
                                            style: getText600(
                                                colors: ColorConstants
                                                    .appTextSalesHader,
                                                size: 11.sp),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            sType.tr,
                                            style: getText600(
                                                colors: ColorConstants
                                                    .appTextSalesHader,
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
                                                colors: ColorConstants
                                                    .appTextSalesHader,
                                                size: 11.sp),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 7,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            sTotalBill.tr,
                                            style: getText600(
                                                colors: ColorConstants
                                                    .appTextSalesHader,
                                                size: 11.sp),
                                          ),
                                        )),
                                    const Expanded(flex: 4, child: SizedBox()),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: (controller.mHoldSaleModel
                                                  .value?.mOrderPlace ??
                                              [])
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return HoldSalesListRowView(
                                          index: index,
                                        );
                                      })),
                            ],
                          ),
                        )),
        ],
      ),
    );
  }

  topBarHoldSale() {
    return Container(
      margin:
          EdgeInsets.only(left: 18.sp, right: 11.sp, bottom: 10, top: 11.sp),
      child: Row(
        children: [
          Expanded(
              child: Text(
            sHoldSale.tr,
            style: getText600(
                colors: ColorConstants.cAppButtonColour, size: 13.5.sp),
          )),
          SizedBox(
            width: 7.5.w,
            child: rectangleCornerButtonText500(
              sDeleteAll.tr,
              height: 17.5.sp,
              textSize: 10.5.sp,
              () {
                controller.onDeleteAll();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.sp),
            width: 7.5.w,
            child: rectangleCornerButtonText500(
              sCancel.tr,
              height: 17.5.sp,
              textSize: 10.5.sp,
              () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
