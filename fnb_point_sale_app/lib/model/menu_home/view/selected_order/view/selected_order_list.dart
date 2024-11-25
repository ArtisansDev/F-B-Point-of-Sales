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

import '../controller/selected_order_controller.dart';

class SelectedOrderList extends StatelessWidget {
  late SelectedOrderController controller;

  SelectedOrderList({super.key}) {
    controller = Get.find<SelectedOrderController>();
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
                  style: getText500(
                      size: 11.5.sp, colors: ColorConstants.black),
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
                            size: 11.5.sp,
                            colors: ColorConstants.black),
                      ))),
            ],
          ),
        ),

        ///Order listing
        Expanded(child:  Container(
            margin: EdgeInsets.only(
                top: 0.sp, left: 8.sp, right: 8.sp, bottom: 8.sp),
            // constraints: BoxConstraints(minHeight: screenHeight*0.31),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(
                      left: 11.sp, right: 11.sp, top: 10.sp, bottom: 10.sp),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Big Italian Salad',
                              maxLines: 1,
                              style: getText500(
                                  size: 10.5.sp, colors: ColorConstants.black),
                            ),
                            Text(
                              'This is some Description',
                              maxLines: 1,
                              style: getText300(
                                  size: 10.5.sp, colors: ColorConstants.black),
                            )
                          ],
                        ) ,
                      ),
                      Expanded(
                          flex: 5,
                          child: incDecView(index)),
                      Expanded(
                          flex: 4,
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'RM 25.00',
                                style: getText500(
                                    size: 10.5.sp, colors: ColorConstants.cAppButtonColour),
                              ))),
                    ],
                  ),
                );
              },
            )))
       ,
      ],
    );
  }

  incDecView(int index) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.only(left: 8.sp,right: 8.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sp),
            color: ColorConstants.cAppQtyColour),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Decrement button
            Container(
              height: 15.5.sp,
              width: 15.5.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: ColorConstants.cAppButtonColour),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // if ((mGetItemDetailsData.count ?? 0) > 1) {
                  //   controller.priceIncDec(mGetItemDetailsData, index,
                  //       (mGetItemDetailsData.count ?? 0) - 1);
                  // }
                },
                color: ColorConstants.white,
                iconSize: 11.5.sp,
              ),
            ),

            // Counter display
            Text(
              '1',
              style: getText500(colors: ColorConstants.black, size: 11.sp),
            ),

            // Increment button
            Container(
                height: 15.5.sp,
                width: 15.5.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: ColorConstants.cAppButtonColour),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // controller.priceIncDec(mGetItemDetailsData, index,
                    //     (mGetItemDetailsData.count ?? 0) + 1);
                  },
                  color: ColorConstants.white,
                  iconSize: 11.5.sp,
                )),
          ],
        ));
  }
}
