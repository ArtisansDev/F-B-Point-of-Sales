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
  Color? labelTextColor;
  Color? borderColor;
  TextCapitalization? textCapitalization;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Function? onClick;
  Function? onTextChange;
  int maxLines;
  double? topPadding;
  double? prefixHeight;
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
    this.hintTextColor,
    this.labelTextColor,
    this.textCapitalization,
    this.prefixIcon,
    this.suffixIcon,
    this.isPhone,
    this.onClick,
    this.onTextChange,
    this.sPrefixText,
    this.prefixHeight,
    this.topPadding,
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
            readOnly: isReadOnly ?? false,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            obscureText: hidePassword ?? false,
            inputFormatters:
                onFilteringTextInputFormatter ?? <TextInputFormatter>[],
            style: getText500(colors: ColorConstants.black, size: 16.sp),
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            cursorColor: ColorConstants.appEditText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: 0.sp,
                  right: 15.sp,
                  top: topPadding ?? 13.sp,
                  bottom: topPadding ?? 13.sp),
              floatingLabelBehavior: (showFloatingLabel ?? true)
                  ? FloatingLabelBehavior.auto
                  : FloatingLabelBehavior.never,
              hintText: hintText,
              hintStyle: getTextRegular(
                  colors: ColorConstants.appEditTextHint, size: 13.sp),
              errorText: errorText,
              errorStyle: getTextRegular(colors: Colors.red, size: 12.5.sp),
              alignLabelWithHint: true,
              labelText: placeHolder,
              labelStyle: getTextRegular(
                  colors: ColorConstants.appEditTextHint, size: 13.sp),
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
                          margin: EdgeInsets.only(right: 13.sp),
                          padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                          height: prefixHeight ?? 10.h,
                          width: ((prefixHeight ?? 10.h) + 16.sp),
                          decoration: BoxDecoration(
                            color: ColorConstants.appEditTextHint.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.sp),
                                bottomLeft: Radius.circular(11.sp)),
                          ),
                          child: Text(
                            '+$sPrefixText',
                            maxLines: 1,
                            style: getText500(
                                colors: ColorConstants.black, size: 16.sp),
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
                  borderRadius: BorderRadius.all(Radius.circular(11.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
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
            readOnly: isReadOnly ?? false,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            obscureText: hidePassword ?? false,
            inputFormatters:
                onFilteringTextInputFormatter ?? <TextInputFormatter>[],
            style: getText500(colors: ColorConstants.black, size: 13.5.sp),
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            cursorColor: ColorConstants.appEditText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: 15.sp,
                  right: 15.sp,
                  top: topPadding ?? 13.sp,
                  bottom: topPadding ?? 13.sp),
              floatingLabelBehavior: (showFloatingLabel ?? true)
                  ? FloatingLabelBehavior.auto
                  : FloatingLabelBehavior.never,
              hintText: hintText,
              hintStyle: getTextRegular(
                  colors: ColorConstants.appEditTextHint, size: 13.sp),
              errorText: errorText,
              errorStyle: getTextRegular(colors: Colors.red, size: 11.5.sp),
              alignLabelWithHint: true,
              labelText: placeHolder,
              labelStyle: getTextRegular(
                  colors: ColorConstants.appEditTextHint, size: 13.sp),
              prefixIcon: prefixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        prefixIcon,
                        size: 22.sp,
                      ), // icon is 48px widget.
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
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: const BorderSide(
                    color: ColorConstants.appEditTextHint,
                  )),
            ),
          );
  }
}

// class TextInputNoBorderWidget extends StatelessWidget {
//   String placeHolder = '';
//   String hintText = '';
//   late TextEditingController controller;
//   TextInputType? textInputType = TextInputType.text;
//   String? errorText = '';
//   bool? hidePassword = false;
//   bool? showFloatingLabel = true;
//   bool? isReadOnly = false;
//   String? suffixIconType = '';
//   Color? hintTextColor;
//   Color? labelTextColor;
//   Color? borderColor;
//   TextCapitalization? textCapitalization;
//   IconData? prefixIcon;
//   IconData? suffixIcon;
//   Function? onClick;
//   Function? onTextChange;
//   int maxLines;
//   int minLine;
//   List<TextInputFormatter>? onFilteringTextInputFormatter = [];
//   double? topPadding ;
//
//   TextInputNoBorderWidget({
//     super.key,
//     this.isReadOnly,
//     this.suffixIconType,
//     required this.placeHolder,
//     required this.hintText,
//     required this.controller,
//     required this.errorText,
//     this.hidePassword,
//     this.showFloatingLabel,
//     this.textInputType,
//     this.borderColor,
//     this.hintTextColor,
//     this.labelTextColor,
//     this.textCapitalization,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onClick,
//     this.onTextChange,
//     this.onFilteringTextInputFormatter,
//     this.maxLines = 1,
//     this.minLine = 1,
//     this.topPadding,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: (value) {
//         if (onTextChange != null) {
//           onTextChange!(value.toString());
//         }
//       },
//       onTap: () {
//         if (onClick != null) {
//           onClick!("click");
//         }
//       },
//       textAlignVertical: TextAlignVertical.center,
//       textAlign: TextAlign.left,
//       cursorColor: Colors.black,
//       readOnly: isReadOnly ?? false,
//       enableSuggestions: false,
//       autocorrect: false,
//       controller: controller,
//       keyboardType: textInputType,
//       minLines: minLine,
//       maxLines: maxLines,
//       obscureText: hidePassword ?? false,
//       inputFormatters: onFilteringTextInputFormatter ?? <TextInputFormatter>[],
//       style: getText500(colors: ColorConstants.primaryColorDark, size: 16.sp),
//       textCapitalization: textCapitalization ?? TextCapitalization.none,
//       decoration: InputDecoration(
//         contentPadding:  EdgeInsets.only(left: 15.sp,right: 15.sp,top:topPadding??13.sp ,bottom: topPadding??13.sp),
//         filled: true,
//         fillColor: ColorConstants.cAppEditTextBackground,
//         border:  OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//             borderRadius: BorderRadius.all(Radius.circular(14.sp))),
//         enabledBorder:  OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//             borderRadius: BorderRadius.all(Radius.circular(14.sp))),
//         focusedBorder:  OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//             borderRadius: BorderRadius.all(Radius.circular(14.sp))),
//         errorBorder:  OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//             borderRadius: BorderRadius.all(Radius.circular(14.sp))),
//         disabledBorder:  OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//             borderRadius: BorderRadius.all(Radius.circular(14.sp))),
//         floatingLabelBehavior: (showFloatingLabel ?? true)
//             ? FloatingLabelBehavior.auto
//             : FloatingLabelBehavior.never,
//         hintText: hintText,
//         hintStyle: getTextRegular(
//             colors: ColorConstants.primaryColorDark, size: 15.5.sp),
//         errorText: errorText,
//         errorStyle: getTextRegular(colors: Colors.red, size: 13.5.sp),
//         alignLabelWithHint: true,
//         labelText: placeHolder,
//         labelStyle:
//             getTextRegular(colors: ColorConstants.colorBlack, size: 15.5.sp),
//         prefixIcon: prefixIcon == null
//             ? null
//             : Padding(
//                 padding: EdgeInsets.all(0.0),
//                 child: Icon(
//                   prefixIcon,
//                   size: 22.sp,
//                 ), // icon is 48px widget.
//               ),
//         prefixIconColor: ColorConstants.cAppColors.shade400,
//         suffixIcon: suffixIcon == null
//             ? null
//             : GestureDetector(
//                 onTap: () {
//                   if (onClick != null) {
//                     onClick!("suffixIcon");
//                   }
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(0.0),
//                   child: Icon(
//                     suffixIcon,
//                     size: 21.sp,
//                   ), // icon is 48px widget.
//                 ),
//               ),
//         suffixIconColor: ColorConstants.appTextColour,
//       ),
//     );
//   }
// }
