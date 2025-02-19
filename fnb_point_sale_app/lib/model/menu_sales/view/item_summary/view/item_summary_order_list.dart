/*
 * Project      : fnb_point_sale_app
 * File         : table_summary_order_list.dart.dart
 * Description  :
 * Author       : parthapaul
 * Date         : 2024-11-20
 * Version      : 1.0
 * Ticket       :
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/item_summary_controller.dart';

class ItemSummaryOrderList extends StatelessWidget {
  late ItemSummaryController controller;

  ItemSummaryOrderList({super.key}) {
    controller = Get.find<ItemSummaryController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///title of order list
        Container(
          margin: EdgeInsets.only(
              top: 10.sp, left: 8.sp, right: 8.sp, bottom: 0.sp),
          padding: EdgeInsets.only(
              left: 11.sp, right: 11.sp, top: 10.sp, bottom: 10.sp),
          decoration: BoxDecoration(
            color: ColorConstants.cAppButtonLightColour,
            borderRadius: BorderRadius.all(
              Radius.circular(8.sp),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  sItems.tr,
                  style:
                      getText500(size: 11.5.sp, colors: ColorConstants.black),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      sQty.tr,
                      style: getText500(
                          size: 11.5.sp, colors: ColorConstants.black),
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        sPrice.tr,
                        style: getText500(
                            size: 11.5.sp, colors: ColorConstants.black),
                      ))),
            ],
          ),
        ),

        ///Order listing
        Expanded(
            child: Container(
                margin: EdgeInsets.only(
                    top: 0.sp, left: 8.sp, right: 8.sp, bottom: 8.sp),
                // constraints: BoxConstraints(minHeight: screenHeight*0.31),
                child: Obx(
                  () {
                    return (controller.mOrderPlace.value.orderMenu ?? [])
                            .isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:
                                (controller.mOrderPlace.value.orderMenu ?? [])
                                    .length,
                            itemBuilder: (BuildContext context, int index) {
                              OrderHistoryMenu mCartItem =
                                  (controller.mOrderPlace.value.orderMenu ??
                                      [])[index];
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 11.sp,
                                    right: 11.sp,
                                    top: 10.sp,
                                    bottom: 10.sp),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mCartItem.itemName ?? '',
                                            maxLines: 1,
                                            style: getText500(
                                                size: 10.5.sp,
                                                colors: ColorConstants.black),
                                          ),
                                          Text(
                                            mCartItem.itemVariantName ?? '',
                                            maxLines: 1,
                                            style: getText300(
                                                size: 10.5.sp,
                                                colors: ColorConstants.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: incDecView(
                                            count: mCartItem.quantity,
                                            priceIncDec: (value) {})),
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${((mCartItem.totalItemAmount ?? 0)).toStringAsFixed(2)}',
                                              style: getText500(
                                                  size: 10.5.sp,
                                                  colors: ColorConstants
                                                      .cAppButtonColour),
                                            ))),
                                  ],
                                ),
                              );
                            },
                          );
                  },
                ))),

        /// Add More Items
        // GestureDetector(
        //   onTap: () {
        //     // controller.addMore();
        //   },
        //   child: Container(
        //     margin: EdgeInsets.only(top: 8.sp, left: 8.sp, right: 8.sp),
        //     padding: EdgeInsets.all(8.sp),
        //     decoration: BoxDecoration(
        //       color: ColorConstants.cAppButtonLightColour,
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(8.sp),
        //       ),
        //     ),
        //     child: Row(
        //       children: [
        //         SizedBox(
        //           width: 13.sp,
        //         ),
        //         Text(
        //           sAddMoreItems.tr,
        //           style: getText600(
        //               size: 12.sp, colors: ColorConstants.cAppButtonColour),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  incDecView({int? count, Function? priceIncDec}) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sp),
            color: ColorConstants.cAppQtyColour),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Decrement button
            Container(
              height: 15.5.sp,
              width: 15.5.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: ColorConstants.appEditText),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.remove),
                onPressed: () {
                  priceIncDec!((count ?? 1) - 1);
                },
                color: ColorConstants.white,
                iconSize: 11.5.sp,
              ),
            ),

// Counter display
            Text(
              '$count',
              style: getText500(colors: ColorConstants.black, size: 11.sp),
            ),

            /// Increment button
            Container(
                height: 15.5.sp,
                width: 15.5.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: ColorConstants.appEditText),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    priceIncDec!((count ?? 1) + 1);
                  },
                  color: ColorConstants.white,
                  iconSize: 11.5.sp,
                )),
          ],
        ));
  }
}
