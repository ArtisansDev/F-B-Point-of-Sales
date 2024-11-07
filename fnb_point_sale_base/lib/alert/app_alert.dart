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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
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
                  padding: EdgeInsets.all(18.5.sp),
                  height: 90,
                  width: 90,
                  child: const CircularProgressIndicator()),
            ),
          );
        });
  }

  static hideLoadingDialog(BuildContext context) {
    Get.back();
  }

  static Future<void> showCustomDialogYesNoLogout(
    BuildContext context,
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
          return Stack(alignment: Alignment.center, children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Container(
                color:
                    Colors.white.withOpacity(0), // Optional transparent color
              ),
            ),
            SizedBox(
                height: 38.h,
                width: 35.w,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(13.sp),
                          child: Text(
                            title,
                            style: getText600(
                              colors: ColorConstants.cAppColors,
                              size: 14.5.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 13.sp, right: 13.sp, bottom: 15.sp),
                          child: Text(message,
                              style: getTextRegular(
                                colors: ColorConstants.black,
                                size: 13.5.sp,
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.all(13.sp),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        height: 19.5.sp,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.sp),
                                        ),
                                        child: rectangleCornerButton(
                                            leftText ?? 'Cancel', () {
                                          Get.back();
                                        },
                                            bgColor: ColorConstants.cAppColors,
                                            textSize: 12.5.sp,
                                            textColor: Colors.white))),
                                SizedBox(
                                  width: 15.sp,
                                ),
                                Expanded(
                                    child: Container(
                                        height: 19.5.sp,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.sp),
                                        ),
                                        child: rectangleCornerButton(
                                            rightText ?? 'Log Out', () {
                                          Get.back();
                                          onCall();
                                        },
                                            bgColor: Colors.red,
                                            textSize: 12.5.sp,
                                            textColor: Colors.white))),
                              ],
                            ))
                      ],
                    ),
                  ),
                ))
          ]);
        });
  }

  static Future<void> showChangePassword(
      BuildContext context, Function onCall) async {
    ///change password
    final TextEditingController mCurrentPasswordController =
        TextEditingController();
    final TextEditingController mNewPasswordController =
        TextEditingController();
    final TextEditingController mConfirmPasswordController =
        TextEditingController();

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Builder(
              builder: (context) {
                return Container(
                  margin: EdgeInsets.all(12.sp),
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Text(
                              sChangePassword.tr,
                              style: getText500(
                                  colors: Colors.black, size: 16.5.sp),
                            ),
                            SizedBox(
                              height: 7.sp,
                            ),
                            Text(
                              sChangeYourPasswordDetails.tr,
                              maxLines: 4,
                              style: getText500(
                                  colors: ColorConstants.black, size: 14.5.sp),
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sCurrentPassword.tr,
                              controller: mCurrentPasswordController,
                              errorText: null,
                              textInputType: TextInputType.emailAddress,
                              hintText: sCurrentPasswordHint.tr,
                              showFloatingLabel: true,
                              // prefixIcon: Icons.email_rounded,
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sNewPassword.tr,
                              controller: mNewPasswordController,
                              errorText: null,
                              textInputType: TextInputType.text,
                              hintText: sNewPasswordHint.tr,
                              showFloatingLabel: true,
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sConfirmPassword.tr,
                              controller: mConfirmPasswordController,
                              errorText: null,
                              textInputType: TextInputType.text,
                              hintText: sConfirmPasswordHint.tr,
                              showFloatingLabel: true,
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            Container(
                                height: 26.5.sp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: rectangleCornerButton(sUpdate.tr, () {
                                  String message = '';
                                  if (mCurrentPasswordController
                                      .value.text.isEmpty) {
                                    message = sCurrentPasswordHint.tr;
                                  } else if (mNewPasswordController
                                      .value.text.isEmpty) {
                                    message = sNewPasswordHint.tr;
                                  } else if (mNewPasswordController
                                          .value.text.length <
                                      6) {
                                    message = sPasswordErrorValid.tr;
                                  } else if (mConfirmPasswordController
                                      .value.text.isEmpty) {
                                    message = sConfirmPasswordHint.tr;
                                  } else if (mConfirmPasswordController
                                          .value.text.length <
                                      6) {
                                    message = sPasswordErrorValid.tr;
                                  } else if (mNewPasswordController
                                          .value.text !=
                                      mConfirmPasswordController.value.text) {
                                    message =
                                        'New password doesn\'t match with confirm password';
                                  }
                                  if (message.isEmpty) {
                                    onCall(mCurrentPasswordController.text,
                                        mNewPasswordController.text);
                                  } else {
                                    AppAlert.showSnackBar(
                                        Get.context!, message);
                                  }
                                },
                                    bgColor: ColorConstants.cAppColors,
                                    textColor: Colors.white)),
                            SizedBox(
                              height: 14.sp,
                            ),
                            Container(
                                height: 26.5.sp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: rectangleCornerButton('Cancel', () {
                                  Get.back();
                                },
                                    bgColor: ColorConstants.cAppColors,
                                    textColor: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  static Future<void> showsForgottenPassword(
      BuildContext context, Function onCall) async {
    ///change password
    final TextEditingController mEmailIdController = TextEditingController();

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Builder(
              builder: (context) {
                return Container(
                  width: 35.w,
                  margin: EdgeInsets.all(12.sp),
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Text(
                              sForgottenPassword.tr,
                              style: getText500(
                                  colors: Colors.black, size: 14.5.sp),
                            ),
                            SizedBox(
                              height: 7.sp,
                            ),
                            Text(
                              sForgottenPasswordDetails.tr,
                              maxLines: 4,
                              style: getText500(
                                  colors: ColorConstants.black, size: 12.5.sp),
                            ),
                            SizedBox(
                              height: 15.5.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sEnterUsername.tr,
                              controller: mEmailIdController,
                              errorText: null,
                              textInputType: TextInputType.emailAddress,
                              hintText: sEnterUsername.tr,
                              showFloatingLabel: true,
                              // prefixIcon: Icons.email_rounded,
                            ),
                            SizedBox(
                              height: 16.5.sp,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        height: 21.5.sp,
                                        alignment: Alignment.center,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(5.sp),
                                        // ),
                                        child: rectangleCornerButton('Cancel',
                                            () {
                                          Get.back();
                                        },
                                            textSize: 13.sp,
                                            bgColor: ColorConstants.cAppColors,
                                            textColor: Colors.white))),
                                SizedBox(
                                  width: 15.sp,
                                ),
                                Expanded(
                                    child: Container(
                                        height: 21.5.sp,
                                        alignment: Alignment.center,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(5.sp),
                                        // ),
                                        child: rectangleCornerButton(sSubmit.tr,
                                            () {
                                          if (mEmailIdController
                                              .text.isNotEmpty) {
                                            Get.back();
                                            onCall(
                                              mEmailIdController.text,
                                            );
                                          } else {
                                            AppAlert.showSnackBar(Get.context!,
                                                sForgottenPasswordDetails.tr);
                                          }
                                        },
                                            textSize: 13.sp,
                                            bgColor: ColorConstants.cAppColors,
                                            textColor: Colors.white))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

class AlertActionWithReturnString {
  final AlertAction alertAction;
  final String reasonString;

  AlertActionWithReturnString(this.alertAction, this.reasonString);
}
