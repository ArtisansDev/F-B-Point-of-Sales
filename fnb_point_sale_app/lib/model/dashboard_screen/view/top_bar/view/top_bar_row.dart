// ignore_for_file: prefer_typing_uninitialized_variables

/*
 * Project      : fnb_point_sale_app
 * File         : side_menu_row.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-08
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/top_bar_controller.dart';

class TopBarRow extends StatelessWidget {
  late TopBarController controller;
  final index;

  TopBarRow({super.key, required this.index}) {
    controller = Get.find<TopBarController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onClickTopBarMenu(index);
      },
      child: Obx(
        () {
          return Container(
            width: 35.sp,
            margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
            padding: EdgeInsets.only(left: 10.sp, right: 7.sp),
            decoration: BoxDecoration(
              color: ColorConstants.cAppButtonColour,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  controller.mDashboardScreenController.mTobBarModel
                          .value[index].name ??
                      '',
                  style: getText500(size: 11.sp),
                )),
                Container(
                  height: 17.5.sp,
                  width: 17.5.sp,
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  padding: EdgeInsets.only(top: 5.sp),
                  alignment: Alignment.center,
                  child: Text(
                    (controller.mDashboardScreenController.mTobBarModel
                                .value[index].value ??
                            '0')
                        .toString()
                        .padLeft(2, '0'),
                    style: getText600(
                        size: 11.sp, colors: ColorConstants.cAppColors),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
