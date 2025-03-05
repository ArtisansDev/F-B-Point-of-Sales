///partha paul
///settings_row_view
///05/03/25

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

import '../controller/settings_controller.dart';


class SettingsRowView extends StatelessWidget {
  late SettingsMenuController controller;
  final int index;

  SettingsRowView({super.key, required this.index}) {
    controller = Get.find<SettingsMenuController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
            () =>  GestureDetector(
          onTap: () {
            controller.onSettingSelect(index);
          },
          child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.cAppButtonColour,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.sp),
                ),
              ),
              height: 10.h,
              alignment: Alignment.center,
              child: Text(
                controller.settingsMenu[index],
                style: getText500(size: 11.5.sp),
              )),
        )
    );

  }
}
