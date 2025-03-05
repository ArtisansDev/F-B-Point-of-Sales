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
import 'package:fnb_point_sale_base/data/mode/get_menu_stock/get_menu_stock_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/menu_stock_controller.dart';

class MenuStockRowView extends StatelessWidget {
  late MenuStockController controller;
  late int index;

  MenuStockRowView({super.key, required this.index}) {
    controller = Get.find<MenuStockController>();
  }

  @override
  Widget build(BuildContext context) {
    GetMenuStockData mGetMenuStockData = controller.mGetMenuStockData[index];
    return Container(
      padding:
          EdgeInsets.only(top: 8.sp, left: 11.sp, right: 8.sp, bottom: 8.sp),
      margin: EdgeInsets.only(bottom: 10.sp),
      decoration: BoxDecoration(
        color: ColorConstants.cAppButtonLightColour,
        borderRadius: BorderRadius.all(
          Radius.circular(8.sp),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Category Name :',
                        style: getText500(
                            colors: ColorConstants.appTextSalesHader,
                            size: 11.sp),
                      )),
                  Expanded(
                    flex: 9,
                    child: Text(
                      mGetMenuStockData.categoryData?.first.categoryName ?? '',
                      style: getTextRegular(
                          colors: ColorConstants.appTextSalesHader,
                          size: 11.sp),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Item Name :',
                        style: getText500(
                            colors: ColorConstants.appTextSalesHader,
                            size: 11.sp),
                      )),
                  Expanded(
                    flex: 9,
                    child: Text(
                      mGetMenuStockData.itemName ?? '',
                      style: getTextRegular(
                          colors: ColorConstants.appTextSalesHader,
                          size: 11.sp),
                    ),
                  )
                ],
              ),
            ],
          )),
          Container(
              width: 10.w,
              margin: EdgeInsets.only(
                  left: 8.sp, right: 8.sp, top: 8.sp, bottom: 8.sp),
              child: rectangleCornerButtonText600(
                height: 19.5.sp,
                textSize: 11.5.sp,
                (mGetMenuStockData.isStockOut ?? false)
                    ? sStockIn.tr
                    : sStockOut.tr,
                () async {
                  await controller.onStockInOutItem(mGetMenuStockData);
                  // await controller.onStockItem();
                },
              )),
        ],
      ),
    );
  }
}
