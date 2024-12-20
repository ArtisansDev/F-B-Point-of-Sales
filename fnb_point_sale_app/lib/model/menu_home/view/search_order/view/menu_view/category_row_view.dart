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
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controller/menu_view_controller.dart';

class CategoryRowView extends StatelessWidget {
  late MenuViewController controller;
  final int index;

  CategoryRowView({super.key, required this.index}) {
    controller = Get.find<MenuViewController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  GestureDetector(
        onTap: () {
          controller.onCategorySelect(index);
        },
        child: Container(
            decoration: BoxDecoration(
              color: controller.isSelectedCategory(controller.mGetAllCategoryView[index])
                  ? ColorConstants.cAppColors
                  : ColorConstants.cAppButtonColour,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            height: 10.h,
            alignment: Alignment.center,
            child: Text(
              controller.mGetAllCategoryView[index].categoryName??'',
              style: getText500(size: 11.5.sp),
            )),
      )
    );

  }
}
