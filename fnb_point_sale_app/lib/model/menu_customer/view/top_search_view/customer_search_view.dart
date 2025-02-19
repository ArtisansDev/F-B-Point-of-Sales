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
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/customer_controller.dart';

class CustomerSearchView extends StatelessWidget {
  late CustomerController controller;

  CustomerSearchView({super.key}) {
    controller = Get.find<CustomerController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///search
            Expanded(
              flex: 10,
              child: Container(
                  height: 22.sp,
                  margin: EdgeInsets.only(
                      top: 11.sp, left: 11.sp, right: 11.sp, bottom: 8.sp),
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
                        hintText: sSearchCustomer.tr,
                        showFloatingLabel: false,
                        onTextChange: (value){
                          controller.onTextChange(value);
                        },
                        topPadding: 5.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(AppUtilConstants.patternStringNumberSpace)),
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
                      ),
                    ],
                  )),
            ),

            Container(
              height: 22.sp,
              width: 22.sp,
              margin: EdgeInsets.only(
                  top: 11.sp,right: 11.sp, bottom: 8.sp),
              padding: EdgeInsets.all(6.5.sp),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.sp),
                ),
              ),
              child:
             GestureDetector(
                onTap: () {
                  controller.addCustomer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.cAppButtonColour,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  padding: EdgeInsets.all(8.5.sp),
                  child: Image.asset(
                    ImageAssetsConstants.appAddUser,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ) ,
            )
            ,
          ],
        ));
  }
}
