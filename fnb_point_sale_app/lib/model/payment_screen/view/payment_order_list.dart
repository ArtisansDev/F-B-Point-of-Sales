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
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/payment_screen_controller.dart';

class PaymentOrderList extends StatelessWidget {
  late PaymentScreenController controller;

  PaymentOrderList({super.key}) {
    controller = Get.find<PaymentScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///title of order list
        Container(
            padding: EdgeInsets.only(
                top: 10.sp, left: 13.sp, right: 11.sp),
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
                  top: 0.sp, left: 8.sp, right: 8.sp,),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 11.sp, right: 11.sp, top: 10.sp),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Big Italian Salad',
                                maxLines: 1,
                                style: getText500(
                                    size: 10.5.sp,
                                    colors: ColorConstants.black),
                              ),
                              Text(
                                'This is some Description',
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
                                '1x',
                                style: getText500(
                                    colors: ColorConstants.black, size: 11.sp),
                              )),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'RM 25.00',
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
