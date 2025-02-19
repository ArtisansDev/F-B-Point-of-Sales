import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/keyboard_widget.dart';
import 'package:fnb_point_sale_base/common/numeric_keyboard.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/verification_controller.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VerificationController());
    return Scaffold(body: Obx(
      () {
        return loginView();
      },
    ));
  }

  loginView() {
    return FocusDetector(
      onVisibilityGained: () {
        // controller.getPackageInfo();
      },
      onVisibilityLost: () {},
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
            color: ColorConstants.cAppColors,
            image: DecorationImage(
              image: AssetImage(
                ImageAssetsConstants.loginBackground,
              ),
              fit: BoxFit.fill,
            )),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 100.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssetsConstants.appLogo,
                          fit: BoxFit.fitWidth,
                          width: 23.w,
                        ),
                        Container(
                          width: 30.w,
                          alignment: Alignment.center,
                          child: Text(
                            'Effortless Ordering,',
                            style: getTextRegular(size: 18.sp),
                          ),
                        ),
                        Container(
                          width: 30.w,
                          margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                          alignment: Alignment.center,
                          child: Text(
                            'Elevated Dining.',
                            style: getText600(size: 18.sp),
                          ),
                        ),
                        Container(
                          width: 30.w,
                          alignment: Alignment.center,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                            textAlign: TextAlign.center,
                            style: getTextRegular(size: 16.sp),
                          ),
                        ),
                      ],
                    ))),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        width: 28.w,
                        padding: EdgeInsets.all(14.sp),
                        decoration: BoxDecoration(
                          color:
                              ColorConstants.cAppButtonColour.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(11.sp),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              // Shadow color
                              spreadRadius: 1,
                              // Spread radius
                              blurRadius: 3,
                              // Blur radius
                              offset: const Offset(0,
                                  0), // Shadow position (horizontal, vertical)
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              'Welcome Back',
                              style: getText600(
                                  colors: ColorConstants.white, size: 14.sp),
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Pinput(
                              controller: controller.pinputController.value,
                              defaultPinTheme: controller.defaultPinTheme,
                              keyboardType: TextInputType.number,
                              length: 4,
                              obscureText: true,
                              obscuringCharacter:'*',
                              readOnly: true,
                              separatorBuilder: (index) =>  SizedBox(width: 8.sp),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(AppUtilConstants.patternOnlyNumber),
                                ),
                              ],
                              validator: (value) {},
                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                controller.isPinCheck();
                              },
                              onChanged: (value) {

                              },
                              focusedPinTheme: controller.defaultPinTheme.copyWith(
                                decoration: controller.defaultPinTheme.decoration!.copyWith(
                                  color: ColorConstants.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorConstants.black),
                                ),
                              ),
                              submittedPinTheme: controller.defaultPinTheme.copyWith(
                                decoration: controller.defaultPinTheme.decoration!.copyWith(
                                  color: ColorConstants.cAppButtonColour,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorConstants.cAppButtonColour),
                                ),
                              ),
                              errorPinTheme: controller.defaultPinTheme.copyBorderWith(
                                border: Border.all(color: Colors.redAccent),
                              ),
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            KeyboardWidget(
                                requestFocus: false,
                                child: NumericKeyboard(
                                    onKeyboardTap: controller.onKeyboardTap,
                                    textColor: ColorConstants.appNumberText,
                                    rightButtonFn: () {
                                      controller.isPinCheck();
                                    },
                                    rightIcon:  Icon(
                                      Icons.check,
                                      size: 14.sp,
                                      color: ColorConstants.white,
                                    ),
                                    leftButtonFn: () {
                                      controller.onDeletePress();
                                    },
                                    leftIcon:  Icon(
                                      Icons.backspace,
                                      color: ColorConstants.white,
                                      size: 14.sp,
                                    ),
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly),
                                onEsc: () {},
                                onNumber: (value) {
                                  controller.onKeyboardTap('$value');
                                },
                                onDecimal: () {},
                                onPeriod: () {},
                                onDelete: () {
                                  controller.onDeletePress();
                                },
                                onEnter: () {
                                  controller.isPinCheck();
                                }),
                            SizedBox(
                              height: 2.5.h,
                            ),
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
