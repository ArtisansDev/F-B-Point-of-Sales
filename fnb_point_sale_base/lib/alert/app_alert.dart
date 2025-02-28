// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/button_constants.dart';
import '../common/text_input_widget.dart';
import '../constants/color_constants.dart';
import '../constants/text_styles_constants.dart';
import '../lang/translation_service_key.dart';
import 'alert_action.dart';

class AppAlert {
  AppAlert._();

  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        backgroundColor: ColorConstants.cAppColors,
        content: Text(message,
          style: getText600(size: 12.5.sp, colors: ColorConstants.white),),
        duration: const Duration(seconds: 3),
      ));
  }

  static void showCustomSnackbar(BuildContext context, String message) {
    final overlay = Navigator.of(context).overlay!;
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0, // Show at the top
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstants.cAppColors,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: getText600(size: 12.sp, colors: ColorConstants.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 3), () => overlayEntry.remove());
  }

  static showProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black38,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Center(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(10.5.sp),
                  height: 25.sp,
                  width: 25.sp,
                  child: const CircularProgressIndicator()),
            ),
          );
        });
  }

  static hideLoadingDialog(BuildContext context) {
    Get.back();
  }

  static Future<void> showCustomDialogYesNoLogout(BuildContext context,
      String title,
      String message,
      Function onCall, {
        bool? barrierDismissible,
        String? leftText,
        String? rightText,
      }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                    color: Colors.black
                        .withOpacity(0.2)), // Optional: Add overlay color
              ),
              // Dialog
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 23.w,
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Text(
                          title,
                          style: getText600(
                            colors: ColorConstants.cAppColors,
                            size: 12.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.sp, right: 8.sp, bottom: 12.sp),
                        child: Text(message,
                            style: getText500(
                              colors: ColorConstants.cAppButtonColour,
                              size: 11.5.sp,
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      height: 19.5.sp,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12.sp),
                                      ),
                                      child: rectangleCornerButtonText600(
                                          rightText ?? 'Log Out', () {
                                        Navigator.pop(context);
                                        onCall();
                                      },
                                          bgColor:
                                          ColorConstants.cAppButtonColour,
                                          textSize: 11.5.sp,
                                          textColor: Colors.white))),
                              SizedBox(
                                width: 13.sp,
                              ),
                              Expanded(
                                  child: Container(
                                      height: 19.5.sp,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12.sp),
                                      ),
                                      child: rectangleCornerButtonText600(
                                          leftText ?? 'Cancel', () {
                                        Navigator.pop(context);
                                      },
                                          bgColor: Colors.white,
                                          textSize: 11.5.sp,
                                          boderColor: ColorConstants
                                              .cAppButtonColour,
                                          textColor: ColorConstants
                                              .cAppButtonColour))),
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  static Future<void> showCustomDialogOk(BuildContext context,
      String title,
      String message,
      {
        bool? barrierDismissible,
        // String? leftText,
        // String? rightText,
        Function? onCall,
      }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                    color: Colors.black
                        .withOpacity(0.2)), // Optional: Add overlay color
              ),
              // Dialog
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 23.w,
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Text(
                          title,
                          style: getText600(
                            colors: ColorConstants.cAppColors,
                            size: 12.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.sp, right: 8.sp, bottom: 12.sp),
                        child: Text(message,
                            style: getText500(
                              colors: ColorConstants.cAppButtonColour,
                              size: 11.5.sp,
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 26.sp,
                              ),
                              Expanded(
                                  child: Container(
                                      height: 19.5.sp,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12.sp),
                                      ),
                                      child: rectangleCornerButtonText600(
                                          'Close', () {
                                        Navigator.pop(context);
                                        if(onCall!=null){
                                          onCall();
                                        }
                                      },
                                          bgColor: ColorConstants
                                              .cAppButtonColour,
                                          textSize: 11.5.sp,
                                          boderColor: ColorConstants
                                              .cAppButtonColour,
                                          textColor: ColorConstants
                                              .white))),
                              SizedBox(
                                width: 26.sp,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  static Future<void> showView(BuildContext context,
      Widget showWidget, {
        bool? barrierDismissible,
      }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                    color: Colors.black
                        .withOpacity(0.2)), // Optional: Add overlay color
              ),
              // Dialog
              Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: showWidget,
              )
            ],
          );
        });
  }

  static Future<void> showViewWithoutBlur(BuildContext context,
      Widget showWidget, {
        bool? barrierDismissible,
      }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: Container(
                    color: Colors.black
                        .withOpacity(0.2)), // Optional: Add overlay color
              ),
              // Dialog
              Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: showWidget,
              )
            ],
          );
        });
  }

}

class AlertActionWithReturnString {
  final AlertAction alertAction;
  final String reasonString;

  AlertActionWithReturnString(this.alertAction, this.reasonString);
}
