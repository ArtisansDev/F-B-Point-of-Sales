import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/color_constants.dart';

class MyOutlineButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? iconSize;
  final double? textSize;
  final TextStyle? mTextStyle;
  final Function onClick;
  final WidgetStateProperty<Color?>? backgroundColor;
  final IconData? icon;

  const MyOutlineButton(
      {Key? key,
      required this.text,
      required this.onClick,
      this.mTextStyle,
      this.height,
      this.iconSize,
      this.textSize,
      this.backgroundColor,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 17.sp,
      child: OutlinedButton(
        style: ButtonStyle(
            side: WidgetStateProperty.all( BorderSide(
                color: ColorConstants.cAppButtonColour, width: 3.sp)), // Set ,
            backgroundColor: backgroundColor ??
                WidgetStateProperty.all(ColorConstants.cAppButtonColour),
            elevation: WidgetStateProperty.all(0),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.sp)))),
        onPressed: () {
          onClick();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
                visible: icon != null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: iconSize ?? 13.sp,
                    ),
                    SizedBox(
                      width: 0.4.w,
                    )
                  ],
                )),
            Text(tr(text),
                style: mTextStyle ??
                    getTextRegular(
                        colors: ColorConstants.white, size: textSize ?? 11.sp)),
          ],
        ),
      ),
    );
  }
}
