import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SplashScreenController());

    return Scaffold(
        backgroundColor: ColorConstants.cAppColorsMaterial,
        body: Obx(
          () {
            return splashView();
          },
        ));
  }

  splashView() {
    return FocusDetector(
        onVisibilityGained: () {
          controller.getPackageInfo();
        },
        onVisibilityLost: () {
          Get.delete<SplashScreenController>();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              ImageAssetsConstants.appLogo,
              fit: BoxFit.fitWidth,
              width: 40.w,
            ),
            Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.all(25.sp),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Version : ${controller.version.value ?? ''}',
                style: getText600(size: 13.sp),
              ),
            )
          ],
        ));
  }
}
