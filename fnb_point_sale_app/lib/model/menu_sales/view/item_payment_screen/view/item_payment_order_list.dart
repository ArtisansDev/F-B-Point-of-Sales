/*
 * Project      : fnb_point_sale_app
 * File         : table_summary_order_list.dart.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-20
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/item_payment_screen_controller.dart';

class ItemPaymentOrderList extends StatelessWidget {
  late ItemPaymentScreenController controller;

  ItemPaymentOrderList({super.key}) {
    controller = Get.find<ItemPaymentScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///title of order list
        Container(
            padding: EdgeInsets.only(top: 10.sp, left: 13.sp, right: 11.sp),
            child: Text(
              'Order Details',
              style: getText600(
                size: 11.5.sp,
                colors: ColorConstants.cAppCancelDilogColour,
              ),
            )),

        ///Order listing
        Expanded(
          child: Container(
              margin: EdgeInsets.only(
                top: 0.sp,
                left: 8.sp,
                right: 8.sp,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount:
                    (controller.mOrderPlace.value?.orderMenu ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  OrderHistoryMenu mCartItem =
                      (controller.mOrderPlace.value?.orderMenu ?? [])[index];
                  return Container(
                    padding:
                        EdgeInsets.only(left: 11.sp, right: 11.sp, top: 10.sp),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          flex: 4,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'x${mCartItem.quantity}',
                                style: getText500(
                                    colors: ColorConstants.black, size: 11.sp),
                              )),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${((mCartItem.totalItemAmount ?? 0)).toStringAsFixed(2)}',
                                  style: getText500(
                                      size: 10.5.sp,
                                      colors: ColorConstants.cAppButtonColour),
                                ))),
                      ],
                    ),
                  );
                },
              )),
        )
      ],
    );
  }
}
