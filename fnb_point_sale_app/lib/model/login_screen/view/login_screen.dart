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

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

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
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Row(
          children: [
            Expanded(
                child: Container(
                    height: 100.h,
                    color: ColorConstants.cAppColorsMaterial,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                            tag: 'appLogo', // Hero tag for transition
                            child: Image.asset(
                              ImageAssetsConstants.appLogo,
                              fit: BoxFit.fitWidth,
                              height: 35.w,
                              width: 35.w,
                            )),
                        Container(
                          width: 100.w,
                          height: 100.h,
                          padding: EdgeInsets.all(30.sp),
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Version: ',
                                style: getTextRegular(size: 14.sp),
                              ),
                              Text(
                                controller.version.value ?? '',
                                style: getText600(size: 14.sp),
                              )
                            ],
                          ),
                        )
                      ],
                    ))),
            Expanded(
                child: Container(
                    color: ColorConstants.primaryBackgroundColor,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        width: 35.w,
                        padding: EdgeInsets.all(14.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                  colors: ColorConstants.cAppButtonColour,
                                  size: 14.5.sp),
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sUsername.tr,
                              controller: controller.userNameController.value,
                              errorText: null,
                              textInputType: TextInputType.emailAddress,
                              hintText: sUsernameHint.tr,
                              showFloatingLabel: false,
                              prefixIcon: Icons.person_rounded,
                              topPadding: 5.sp,
                              onFilteringTextInputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(AppUtilConstants.patternOnlyString)),
                              ],
                            ),
                            SizedBox(
                              height: 13.sp,
                            ),
                            TextInputWidget(
                                placeHolder: sPassword.tr,
                                controller: controller.passwordController.value,
                                errorText: null,
                                textInputType: TextInputType.text,
                                hintText: sPasswordHint.tr,
                                showFloatingLabel: false,
                                prefixIcon: Icons.password,
                                topPadding: 5.sp,
                                hidePassword: true),
                            SizedBox(
                              height: 15.sp,
                            ),
                            rectangleCornerButtonText600(
                              sLogin.tr,
                              () {
                                controller.isLoginCheck();
                              },
                            ),
                            SizedBox(
                              height: 2.h,
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
