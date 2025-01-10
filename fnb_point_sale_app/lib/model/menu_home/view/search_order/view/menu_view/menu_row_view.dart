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
import '../../../../home_base_controller/home_base_controller.dart';

class MenuRowView extends StatelessWidget {
  late HomeBaseController controller;
  final int index;

  MenuRowView({super.key, required this.index}) {
    controller = Get.find<HomeBaseController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  GestureDetector(
        onTap: () {
          controller.onMenuSelect(index);
        },
        child: Container(
            padding: EdgeInsets.only(left:15.sp,right:15.sp),
            decoration: BoxDecoration(
              color:
              controller.isSelectedMenuItem(controller.mMenuItemData[index])
                  ? ColorConstants.cAppColors
                  : ColorConstants.cAppButtonColour,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            height: 10.h,
            alignment: Alignment.center,
            child: Text(
              controller.mMenuItemData[index].itemName??'',
              style: getText500(size: 11.5.sp),
            )),
      )
    );

  }
}
