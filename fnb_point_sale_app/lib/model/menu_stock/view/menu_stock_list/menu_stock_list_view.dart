/*
 * Project      : fnb_point_sale_app
 * File         : table_row_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/sales_list/sales_list_row_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common_view/button_view/button_view.dart';
import '../../controller/menu_stock_controller.dart';
import 'menu_stock_row_view.dart';

class MenuStockListView extends StatelessWidget {
  late MenuStockController controller;

  MenuStockListView({super.key}) {
    controller = Get.find<MenuStockController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 7.sp, left: 11.sp, right: 11.sp),
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    child: controller.sLoading.value.isNotEmpty
                        ?  Center(
                            child: Text(controller.sLoading.value),
                          )
                        : (controller.mGetMenuStockData ?? []).isEmpty
                            ? const Center(
                                child: Text('No data found'),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount:
                                    (controller.mGetMenuStockData ?? [])
                                        .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return MenuStockRowView(
                                    index: index,
                                  );
                                })),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
