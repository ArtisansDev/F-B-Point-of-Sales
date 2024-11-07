import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../login_screen/controller/login_controller.dart';
import '../controller/dashboard_screen_controller.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardScreenController());

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
          Get.delete<LoginScreenController>();
        },
        onVisibilityLost: () {},
        child: Stack(
          alignment: Alignment.center,
          children: [
            Hero(
                tag: 'appLogo', // Hero tag for transition
                child: Image.asset(
                  ImageAssetsConstants.appLogo,
                  fit: BoxFit.fitWidth,
                  height: 50.w,
                  width: 50.w,
                )),
            Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.all(30.sp),
              alignment: Alignment.bottomCenter,
              child: Text(
                controller.version.value ?? '',
                style: getText600(size: 14.sp),
              ),
            )
          ],
        ));
  }
}
