import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/text_styles_constants.dart';

import '../constants/color_constants.dart';

/// Button -> rectangle rounded corner

rectangleRoundedCornerButton(
  String sTitle,
  Function onClick, {
  Color bgColor = ColorConstants.cAppColors,
  Color textColor = ColorConstants.cAppColors,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.sp), color: bgColor),
      child: Text(
        sTitle,
        style: getTextRegular(size: 15.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleRoundedCornerButtonMedium(
  String sTitle,
  Function onClick, {
  Color bgColor = ColorConstants.cAppColors,
  Color textColor = ColorConstants.cAppColors,
  double size = 0,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: bgColor),
      child: Text(
        sTitle,
        style: getText500(size: size == 0 ? 15.5.sp : size, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleCornerButton(
    String sTitle,
    Function onClick, {
      Color bgColor = ColorConstants.cAppColors,
      Color textColor = Colors.white,
      double? size,
      double? height,

    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height:height?? 27.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: bgColor),
      child: Text(
        sTitle,
        style: getText600(size: size?? 15.5.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleCornerButtonBold(
    String sTitle,
    Function onClick, {
      Color bgColor = ColorConstants.cAppColors,
      Color textColor = Colors.white,
      double? size,
      double? height,
      IconData? mIconData,
    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height:height?? 27.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: bgColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(visible:mIconData!=null,child: Icon(mIconData,color: textColor,size: 19.sp,)),
          Visibility(visible:mIconData!=null,child: SizedBox(width: 10.sp,)),
          Text(
            sTitle,
            style: getTextBold(size: size?? 15.5.sp, colors: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      )

    ),
  );
}

rectangleCornerBorderButton(
    String sTitle,
    Function onClick, {
      Color bgColor = ColorConstants.cAppColors,
      Color textColor = Colors.white,
      double? size,
      double? height,
      IconData? mIconData,
    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
        alignment: Alignment.center,
        height:height?? 27.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            boxShadow: const [
              BoxShadow(
                color: ColorConstants.appEditTextHint,
                blurRadius: 3,
                offset: Offset(0, 0), // Shadow position
              ),
            ],
            color: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(visible:mIconData!=null,child: Icon(mIconData,color: textColor,size: 19.sp,)),
            Visibility(visible:mIconData!=null,child: SizedBox(width: 10.sp,)),
            Text(
              sTitle,
              style: getText500(size: size?? 15.5.sp, colors: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        )

    ),
  );
}

