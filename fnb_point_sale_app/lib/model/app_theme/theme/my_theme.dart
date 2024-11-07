import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:fnb_point_sale_base/constants/color_constants.dart';

ThemeData myLightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: ColorConstants.cAppColorsMaterial,
    fontFamily: GoogleFonts.rajdhani().fontFamily,
    scaffoldBackgroundColor: ColorConstants.primaryBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(
            left: 15.sp,
            right: 15.sp,),
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
            ))
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: ColorConstants.cAppColors,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorConstants.cAppColors,
    ),
    radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith(
            (states) => ColorConstants.cAppColors)),
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.cAppColors),
    useMaterial3: true,
  );
}

ThemeData myDarkTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: ColorConstants.cAppColorsMaterial,
    fontFamily: GoogleFonts.rajdhani().fontFamily,
    scaffoldBackgroundColor: ColorConstants.primaryBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
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
            ))
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: ColorConstants.cAppColors,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorConstants.cAppColors,
    ),
    radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith(
            (states) => ColorConstants.cAppColors)),
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.cAppColors),
    useMaterial3: true,
  );
}
