import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/text_styles_constants.dart';

import '../constants/color_constants.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String placeHolder = '';
  String hintText = '';
  late TextEditingController controller;
  TextInputType? textInputType = TextInputType.text;
  String? errorText = '';
  bool? hidePassword = false;
  bool? showFloatingLabel = true;
  bool? isReadOnly = false;
  bool? isPhone = false;
  String? suffixIconType = '';
  String? sPrefixText;

  Color? hintTextColor;
  Color? textColor;
  Color? borderSideColor;
  Color? labelTextColor;
  Color? borderColor;
  TextCapitalization? textCapitalization;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Function? onClick;
  Function? onSubmit;
  Function? onTextChange;
  int maxLines;
  double? topPadding;
  double? prefixPadding;
  double? leftPadding;
  double? prefixHeight;
  double? hintTextSize;
  double? textSize;
  List<TextInputFormatter>? onFilteringTextInputFormatter = [];

  TextInputWidget({
    super.key,
    this.isReadOnly,
    this.suffixIconType,
    required this.placeHolder,
    required this.hintText,
    required this.controller,
    required this.errorText,
    this.hidePassword,
    this.showFloatingLabel,
    this.textInputType,
    this.borderColor,
    this.prefixPadding,
    this.hintTextColor,
    this.textColor,
    this.borderSideColor,
    this.labelTextColor,
    this.textCapitalization,
    this.prefixIcon,
    this.suffixIcon,
    this.isPhone,
    this.onClick,
    this.onSubmit,
    this.onTextChange,
    this.sPrefixText,
    this.prefixHeight,
    this.hintTextSize,
    this.textSize,
    this.topPadding,
    this.leftPadding,
    this.onFilteringTextInputFormatter,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return isPhone ?? false
        ? TextField(
      onChanged: (value) {
        if (onTextChange != null) {
          onTextChange!(value.toString());
        }
      },
      onTap: () {
        if (onClick != null) {
          onClick!("click");
        }
      },
      onSubmitted: (value) {
          if(onSubmit!=null){
            onSubmit!();
          }
      },
      readOnly: isReadOnly ?? false,
      enableSuggestions: false,
      autocorrect: false,
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLines,
      obscureText: hidePassword ?? false,
      inputFormatters:
      onFilteringTextInputFormatter ?? <TextInputFormatter>[],
      style: getText500(
          colors: textColor ?? ColorConstants.black, size: textSize ?? 12.5.sp),
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      cursorColor: ColorConstants.cAppButtonColour,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            left: leftPadding ?? 15.sp,
            right: leftPadding ?? 15.sp,
            top: topPadding ?? 13.sp,
            bottom: topPadding ?? 13.sp),
        floatingLabelBehavior: (showFloatingLabel ?? true)
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: getText500(
            colors: hintTextColor ?? ColorConstants.appEditTextHint,
            size: hintTextSize ?? 12.sp),
        errorText: errorText,
        errorStyle: getTextRegular(colors: Colors.red, size: 12.5.sp),
        alignLabelWithHint: true,
        prefixIcon: sPrefixText == null
            ? null
            : GestureDetector(
          onTap: () {
            if (onClick != null) {
              onClick!("prefixIcon");
            }
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: prefixPadding??8.sp),
              height: prefixHeight ?? 10.h,
              width: 5.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.sp),
                    bottomLeft: Radius.circular(8.sp)),
              ),
              child: Text(
                '+$sPrefixText',
                maxLines: 1,
                style: getText500(
                    colors: ColorConstants.black, size: 11.5.sp),
              )),
        ),
        prefixIconColor: ColorConstants.cAppColorsMaterial.shade400,
        suffixIcon: suffixIcon == null
            ? null
            : GestureDetector(
          onTap: () {
            if (onClick != null) {
              onClick!("suffixIcon");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Icon(
              suffixIcon,
              size: 22.sp,
            ), // icon is 48px widget.
          ),
        ),
        suffixIconColor: ColorConstants.cAppColorsMaterial.shade700,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
      ),
    )
        : TextField(
      onChanged: (value) {
        if (onTextChange != null) {
          onTextChange!(value.toString());
        }
      },
      onTap: () {
        if (onClick != null) {
          onClick!("click");
        }
      },
      onSubmitted: (value) {
        if(onSubmit!=null){
          onSubmit!();
        }
      },
      readOnly: isReadOnly ?? false,
      enableSuggestions: false,
      autocorrect: false,
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLines,
      obscureText: hidePassword ?? false,
      inputFormatters:
      onFilteringTextInputFormatter ?? <TextInputFormatter>[],
      style: getText500(
          colors: textColor ?? ColorConstants.black, size: textSize ?? 12.5.sp),
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      cursorColor: ColorConstants.cAppButtonColour,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            left: leftPadding ?? 15.sp,
            right: leftPadding ?? 15.sp,
            top: topPadding ?? 13.sp,
            bottom: topPadding ?? 13.sp),
        floatingLabelBehavior: (showFloatingLabel ?? true)
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: getText500(
            colors: hintTextColor ?? ColorConstants.appEditTextHint,
            size: hintTextSize ?? 12.sp),
        hintFadeDuration: const Duration(seconds: 0),
        errorText: errorText,
        errorStyle: getTextRegular(colors: Colors.red, size: 11.5.sp),
        alignLabelWithHint: true,
        // labelText: placeHolder,
        // label: Text(placeHolder,style: getText500(
        //     colors: hintTextColor ?? ColorConstants.appEditTextHint,
        //     size: hintTextSize ?? 12.sp),),
        // labelStyle: getText500(
        //     colors: hintTextColor ?? ColorConstants.appEditTextHint,
        //     size: hintTextSize ?? 12.sp),
        prefixIcon: prefixIcon == null
            ? null
            : GestureDetector(
            onTap: () {
              if (onClick != null) {
                onClick!("prefixIcon");
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
              child: Icon(
                prefixIcon,
                size: prefixHeight ?? 15.sp,
              ), // icon is 48px widget.
            )),
        prefixIconColor: ColorConstants.cAppColorsMaterial.shade400,
        suffixIcon: suffixIcon == null
            ? null
            : GestureDetector(
          onTap: () {
            if (onClick != null) {
              onClick!("suffixIcon");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Icon(
              suffixIcon,
              size: 22.sp,
            ), // icon is 48px widget.
          ),
        ),
        suffixIconColor: ColorConstants.cAppColorsMaterial.shade700,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: BorderSide(
              color: borderSideColor ?? ColorConstants.appEditTextHint,
            )),
      ),
    );
  }
}

