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

import '../../../controller/table_controller.dart';

class TableSearchView extends StatelessWidget {
  late TableController controller;

  TableSearchView({super.key}) {
    controller = Get.find<TableController>();
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
                      EdgeInsets.only(top: 3.sp, left: 3.sp, bottom: 5.sp),
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
                        placeHolder: sSearchSeatingNo.tr,
                        controller: controller.searchController.value,
                        errorText: null,
                        textInputType: TextInputType.text,
                        hintText: sSearchSeatingNo.tr,
                        showFloatingLabel: false,
                        topPadding: 5.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                        onTextChange: (value){
                          controller.search.value =
                              controller.searchController.value.text;
                          controller.search.refresh();
                          ///search
                          controller.searchTable();
                        },
                        onSubmit: () {
                          controller.search.value =
                              controller.searchController.value.text;
                          controller.search.refresh();
                         ///search
                          controller.searchTable();
                        },
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              AppUtilConstants.patternCompanyName)),
                        ],
                      )),
                      Visibility(
                          visible: controller.search.value.isNotEmpty,
                          child: GestureDetector(
                            onTap: () {
                              controller.searchController.value.text = "";
                              controller.search.value = "";
                              controller.search.refresh();
                              ///clear
                              controller.searchTable();

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
                          ///search
                          controller.searchTable();

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

            ///ref
            GestureDetector(
              onTap: () async {
              controller.onRefresh();
              },
              child: Container(
                  margin:
                      EdgeInsets.only(top: 3.sp, right: 10.sp, left: 10.sp, bottom: 5.sp),
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
}
