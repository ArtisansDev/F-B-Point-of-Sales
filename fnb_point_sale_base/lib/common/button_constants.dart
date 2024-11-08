import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/text_styles_constants.dart';

import '../constants/color_constants.dart';

/// Button -> rectangle rounded corner

rectangleCornerButton(String sTitle,
    Function onClick, {
      double? textSize,
      double? borderRadius,
      double? height,
      Color bgColor = ColorConstants.cAppButtonColour,
      Color? boderColor ,
      Color textColor = ColorConstants.white,
    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height: height??5.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: boderColor??Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.sp),
          color: bgColor),
      child: Text(
        sTitle,
        style: getTextRegular(size: textSize ?? 14.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}


rectangleCornerButtonText600(String sTitle,
    Function onClick, {
      double? textSize,
      double? borderRadius,
      double? height,
      Color bgColor = ColorConstants.cAppButtonColour,
      Color? boderColor ,
      Color textColor = ColorConstants.white,
    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height: height??5.8.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: boderColor??Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.sp),
          color: bgColor),
      child: Text(
        sTitle,
        style: getText600(size: textSize ?? 14.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

