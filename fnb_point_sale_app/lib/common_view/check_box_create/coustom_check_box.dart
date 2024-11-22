/*
 * Project      : fnb_point_sale_app
 * File         : coustom_check_box.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-22
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

selectCheckBox({bool isRound = true, bool isSelect = false}) {
  return Container(
    width: 14.sp,
    height: 14.sp,
    decoration: BoxDecoration(
      color: Colors.white,
      // Background color
      shape: isRound ? BoxShape.circle : BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          // Shadow color
          spreadRadius: 2,
          // Spread area
          blurRadius: 3,
        ),
      ],
    ),
    padding: EdgeInsets.all(6.sp),
    child: Container(
      decoration: BoxDecoration(
        color: isSelect ? ColorConstants.cAppButtonColour : Colors.transparent,
        shape: isRound ? BoxShape.circle : BoxShape.rectangle,
      ),
    ),
  );
}
