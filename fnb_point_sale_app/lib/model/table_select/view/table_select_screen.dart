import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/check_box_create/coustom_check_box.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/table_select_controller.dart';
import 'dine_in/dine_in_screen.dart';

class TableSelectScreen extends GetView<TableSelectController> {
  final GetAllTablesResponseData? tableNumber;

  const TableSelectScreen({super.key, required this.tableNumber});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TableSelectController());
    // controller.getAllCustomerList();
    return FocusDetector(
        onVisibilityGained: () {
          controller.setTableNumber(tableNumber);
        },
        onVisibilityLost: () {},
        child: Obx(() => Container(
              height: controller.isDineIn.value
                  ? Platform.isWindows
                      ? 70.h
                      : 67.h
                  : Platform.isWindows
                      ? 65.h
                      : 60.h,
              width: 40.w,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(11.sp),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: 11.sp, bottom: 11.sp, left: 14.sp, right: 12.sp),
                      decoration: BoxDecoration(
                        color: ColorConstants.cAppButtonLightColour,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11.sp),
                          topRight: Radius.circular(11.sp),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Order #: ${controller.orderNumber.value}',
                            style: getText600(
                              size: 11.8.sp,
                              colors: ColorConstants.cAppButtonColour,
                            ),
                          )),
                          GestureDetector(
                            onTap: () {
                              controller.isCreateOrder.value = false;
                              Get.back();
                            },
                            child: Container(
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
                          )
                        ],
                      )),

                  ///select Dine-In or Take Away
                  Container(
                    margin:
                        EdgeInsets.only(left: 15.sp, top: 12.sp, bottom: 12.sp),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          selectCheckBox(isSelect: controller.isDineIn.value),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Text(
                            sDineIn.tr,
                            style: getText500(
                              size: 11.sp,
                              colors: ColorConstants.black.withOpacity(0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  ///isDineIn
                  Expanded(
                      child: Container(
                          child:
                              // controller.isDineIn.value
                              //     ?
                              DineInScreen()
                          // : TakeAwayScreen()
                          )),

                  ///button
                  Container(
                      margin: EdgeInsets.only(
                          left: 13.sp, right: 13.sp, top: 12.sp, bottom: 13.sp),
                      child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.7.sp,
                        controller.isDineIn.value
                            ? sCreateOrder.tr
                            : sCreateOrder.tr,
                        () {
                          controller.onCreateOrder();
                        },
                      )),
                ],
              ),
            )));
  }
}
