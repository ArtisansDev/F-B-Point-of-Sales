import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/top_bar/view/top_bar_profile_view.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/top_bar/view/top_bar_row.dart';
import 'package:fnb_point_sale_base/common/custom_image.dart';
import 'package:fnb_point_sale_base/common/my_ink_well_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/top_bar_controller.dart';

class TopBarScreen extends GetView<TopBarController> {
  const TopBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TopBarController());
    controller.mDashboardScreenController.fastTimeSync();
    return Scaffold(
        backgroundColor: ColorConstants.cAppColors, body: sideMenuView());
  }

  sideMenuView() {
    Get.lazyPut(() => TopBarController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Obx(
          () {
            return Container(
              height: 6.w,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///show table view
                  SizedBox(
                    width: 18.sp,
                  ),
                  Text(
                    'Tables',
                    style: getText500(
                        colors: ColorConstants.cAppButtonColour, size: 12.sp),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                      flex: 5,
                      child: SizedBox(
                        height: 20.sp,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(0),
                          itemCount: controller.mDashboardScreenController
                              .mTobBarModel.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TopBarRow(
                              index: index,
                            );
                          },
                        ),
                      )),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              MyInkWellWidget(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      svgView(
                                        key: const ValueKey('topBarSync'),
                                        color: ColorConstants.cAppButtonColour,
                                        ImageAssetsConstants.topBarSync,
                                        height: 2.9.h,
                                        width: 2.9.h,
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text('Sync',
                                          style: getText500(
                                            size: 11.sp,
                                            colors:
                                                ColorConstants.cAppButtonColour,
                                          )),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.mDashboardScreenController
                                        .onSync();
                                  }),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.mDashboardScreenController
                                        .sDownloadText.value,
                                    style: getText500(
                                        size: 11.sp,
                                        colors:
                                            ColorConstants.cAppButtonColour),
                                  ))
                            ]),
                      )),
                  SizedBox(
                    width: 1.5.w,
                  ),

                  ///show Profile
                  TopBarProfileView()
                ],
              ),
            );
          },
        ));
  }
}
