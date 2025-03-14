import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/side_menu/view/side_menu_row.dart';
import 'package:fnb_point_sale_base/common/custom_image.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/side_menu_controller.dart';

class SideMenuScreen extends GetView<SideMenuController> {
  const SideMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SideMenuController());
    return Scaffold(
        backgroundColor: ColorConstants.cAppColors,
        body: Obx(
          () {
            return sideMenuView();
          },
        ));
  }

  sideMenuView() {
    Get.lazyPut(() => SideMenuController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Column(
          children: [
            ///top image
            Container(
              height: 6.w,
              width: 6.w,
              padding: EdgeInsets.all(8.sp),
              child:
                  (controller.mDashboardScreenController.mRestaurantData.value
                                  ?.restaurantLogoPath ??
                              '')
                          .isEmpty
                      ? Image.asset(
                          ImageAssetsConstants.appLogo,
                          fit: BoxFit.fitWidth,
                        )
                      : cacheCoursesImageAppLogo(
                          (controller.mDashboardScreenController.mRestaurantData
                                  .value?.restaurantLogoPath ??
                              ''),
                          ImageAssetsConstants.appLogo,
                          18.w),
            ),
            SizedBox(
              height: 15.sp,
            ),

            ///all menu
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: controller.sideMenu.value.length,
              itemBuilder: (BuildContext context, int index) {
                return SideMenuRow(
                  index: index,
                );
              },
            )),

            ///Artisans logo
            Image.asset(
              ImageAssetsConstants.appArtisansLogo,
              fit: BoxFit.fitWidth,
              width: 20.sp,
            ),

            ///Version
            Container(
              margin: EdgeInsets.all(11.sp),
              child: Column(
                children: [
                  Text(
                    'Version',
                    style: getText500(size: 11.sp),
                  ),
                  Text(
                    '${controller.mDashboardScreenController.version}',
                    style: getText600(
                        size: 10.sp, colors: ColorConstants.cAppButtonColour),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
          ],
        ));
  }
}
