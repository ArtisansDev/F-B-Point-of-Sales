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
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/side_menu_controller.dart';

class SideMenuRow extends StatelessWidget {
  late SideMenuController controller;
  final index;

  SideMenuRow({super.key, required this.index}) {
    controller = Get.find<SideMenuController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onClickSideMenu(index);
      },
      child: Obx(
        () {
          return Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: 14.sp, right: 14.sp, bottom: 6.sp, top: 11.sp),
                  child: Image.asset(
                    controller.sideMenuImage.value[index],
                    fit: BoxFit.fitWidth,
                    color: controller
                                .mDashboardScreenController.selectMenu.value ==
                            index
                        ? ColorConstants.white
                        : ColorConstants.cAppButtonColour,
                    colorBlendMode: BlendMode.srcATop,
                  )),
              Text(
                controller.sideMenu.value[index],
                style: getTextRegular(
                    size: 10.5.sp,
                    colors: controller
                                .mDashboardScreenController.selectMenu.value ==
                            index
                        ? ColorConstants.white
                        : ColorConstants.cAppButtonColour),
              )
            ],
          );
        },
      ),
    );
  }
}
