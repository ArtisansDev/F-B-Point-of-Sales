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
import 'package:fnb_point_sale_base/common/dropdown_button_view/dropdown_button2.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/menu_stock_controller.dart';

class MenuStockSearchView extends StatelessWidget {
  late MenuStockController controller;

  MenuStockSearchView({super.key}) {
    controller = Get.find<MenuStockController>();
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
                        hintText: sSearchItems.tr,
                        showFloatingLabel: false,
                        onSubmit: (){
                          controller.onTextChange('');
                        },
                        onTextChange: (value) {
                          //controller.onTextChange(value);
                        },
                        topPadding: 5.sp,
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        hintTextColor: ColorConstants.cAppTaxColour,
                        borderSideColor: Colors.transparent,
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              AppUtilConstants.patternStringNumberSpace)),
                        ],
                      )),
                      GestureDetector(
                        onTap: () {
                          controller.onTextChange("");
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

            ///StockStatus
            Expanded(
                flex: 4,
                child: Obx(() => Container(
                    height: 22.sp,
                    margin:
                        EdgeInsets.only(top: 11.sp, right: 8.sp, bottom: 8.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: stockStatus()))),
          ],
        ));
  }

  Widget stockStatus() => DropdownButton2(
        barrierColor: Colors.transparent,
        focusColor: Colors.white,
        hint: Text(
          controller.selectStockStatus.value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getTextRegular(size: 11.sp, colors: Colors.black),
        ),
        isExpanded: true,
        items: controller.stockStatusList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getTextRegular(
                        size: 11.sp, colors: ColorConstants.appTextSalesHader),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if(controller.selectStockStatus.value.toString()!=value.toString()){
            controller.selectStockStatus.value = value.toString();
            controller.sLoading.value = 'Loading...';
            controller.sLoading.refresh();
            controller.onStockItem();
          }
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        icon: Row(
          children: [
            Icon(
              Icons.arrow_drop_down,
              size: 15.sp,
              // Custom dropdown icon
              color: ColorConstants.cAppButtonColour,
            )
          ],
        ),
        offset: const Offset(0, -10),
        underline: const SizedBox(),
      );
}
