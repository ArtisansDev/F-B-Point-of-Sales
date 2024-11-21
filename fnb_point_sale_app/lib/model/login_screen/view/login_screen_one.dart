import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/login_controller.dart';

class LoginScreenOne extends GetView<LoginScreenController> {
  const LoginScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginScreenController());
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
                ImageAssetsConstants.loginBackground1,
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
                            style: getTextRegular(size: 17.sp),
                          ),
                        ),
                        Container(
                          width: 30.w,
                          margin: EdgeInsets.only(top: 10.sp,bottom: 10.sp),
                          alignment: Alignment.center,
                          child: Text(
                            'Elevated Dining.',
                            style: getText600(size: 17.sp),
                          ),
                        ),
                        Container(
                          width: 30.w,
                          alignment: Alignment.center,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                            textAlign: TextAlign.center,
                            style: getTextRegular(size: 14.5.sp),
                          ),
                        ),
                      ],
                    ))),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        width: 30.w,
                        padding: EdgeInsets.only(top:14.sp,bottom:14.sp,left: 19.sp,right: 19.sp),
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
                              height: 15.sp,
                            ),
                            Text(
                              'Welcome Back',
                              style: getText600(
                                  colors: ColorConstants.white, size: 14.sp),
                            ),
                            SizedBox(
                              height: 18.sp,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.white,
                                borderRadius: BorderRadius.circular(8.sp),
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
                              child: TextInputWidget(
                                placeHolder: sUsername.tr,
                                controller: controller.userNameController.value,
                                errorText: null,
                                textInputType: TextInputType.emailAddress,
                                hintText: sUsernameHint.tr,
                                showFloatingLabel: false,
                                prefixIcon: Icons.person_rounded,
                                topPadding: 5.sp,

                                onFilteringTextInputFormatter: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      AppUtilConstants.patternOnlyString)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 13.sp,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.white,
                                  borderRadius: BorderRadius.circular(8.sp),
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
                                child: TextInputWidget(
                                    placeHolder: sPassword.tr,
                                    controller:
                                        controller.passwordController.value,
                                    errorText: null,
                                    textInputType: TextInputType.text,
                                    hintText: sPasswordHint.tr,
                                    showFloatingLabel: false,
                                    prefixIcon: Icons.password,
                                    topPadding: 5.sp,
                                    hidePassword: true)),
                            SizedBox(
                              height: 15.sp,
                            ),
                            rectangleCornerButtonText600(
                              sLogin.tr,
                              textSize: 12.5.sp,
                              () {
                                controller.isLoginCheck();
                              },
                            ),
                            SizedBox(
                              height: 18.sp,
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