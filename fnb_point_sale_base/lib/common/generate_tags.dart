/*
 * Project      : skill_360
 * File         : generate_tags.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-06
 * Version      : 1.0
 * Ticket       : 
 */



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles_constants.dart';

var tags = [
];

yourKeySkillsView(var tagList) {
  tags = tagList;
  return Container(
    margin: EdgeInsets.all(14.sp),
    child: Wrap(
      spacing: 12.sp, // gap between adjacent chips
      runSpacing: 12.sp, // gap between lines
      children: <Widget>[...generateTags()],
    ),
  );
}

generateTags() {
  return tags.map((tag) => getChip(tag)).toList();
}

getChip(name) {
  return Container(
    decoration: BoxDecoration(
        color: ColorConstants.cAppColors,
        borderRadius: BorderRadius.circular(
            20) // use instead of BorderRadius.all(Radius.circular(20))
    ),
    padding: EdgeInsets.only(
        top: 12.5.sp, bottom: 12.sp, right: 17.sp, left: 17.sp),
    child: Text(
      "$name",
      style: getText500(colors: Colors.white, size: 14.5.sp),
    ),
  );

}