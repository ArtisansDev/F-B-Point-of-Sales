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
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/pay_now_controller.dart';

class PayNowOrderList extends StatelessWidget {
  late PayNowController controller;

  PayNowOrderList({super.key}) {
    controller = Get.find<PayNowController>();
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
        Container(
            constraints: BoxConstraints(minHeight: Platform.isWindows?40.5.h:45.5.h),
            child: Container(
              margin: EdgeInsets.only(
                  top: 0.sp, left: 8.sp, right: 8.sp, bottom: 8.sp),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
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
                        Expanded(flex: 5, child: Align(
                          alignment: Alignment.center,
                          child:  Text(
                            '1X',
                            style: getText500(colors: ColorConstants.black, size: 11.sp),
                          ),
                        )),
                        Expanded(
                            flex: 4,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'RM 25.00',
                                  style: getText500(
                                      size: 10.5.sp,
                                      colors: ColorConstants.black),
                                ))),
                      ],
                    ),
                  );
                },
              ),
            ),),
      ],
    );
  }

}
