import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/side_menu/view/side_menu_screen.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/top_bar/view/top_bar_screen.dart';
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
        backgroundColor: ColorConstants.cAppColors,
        body: FocusDetector(
            onVisibilityGained: () {
              controller.getPackageInfo();
              Get.delete<LoginScreenController>();
            },
            onVisibilityLost: () {},
            child: Obx(
              () {
                return Row(
                  children: [
                    SizedBox(
                      width: 6.w,
                      child: const SideMenuScreen(),
                    ),
                    Expanded(child: dashboardView())
                  ],
                );
              },
            )));
  }

  dashboardView() {
    return Column(
      children: [
        SizedBox(
          height: 6.w,
          child: const TopBarScreen(),
        ),
        Expanded(child: showView()),
      ],
    );
  }

  showView() {
    return Container(
        decoration: BoxDecoration(
          color: ColorConstants.appBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.sp),
          ),
        ),
        child: controller.getView());
  }
}
