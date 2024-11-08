import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/top_bar/view/top_bar_profile_view.dart';
import 'package:fnb_point_sale_app/model/dashboard_screen/view/top_bar/view/top_bar_row.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/top_bar_controller.dart';

class TopBarScreen extends GetView<TopBarController> {
  const TopBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TopBarController());
    return Scaffold(
        backgroundColor: ColorConstants.cAppColors, body: sideMenuView());
  }

  sideMenuView() {
    Get.lazyPut(() => TopBarController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
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
                  child: SizedBox(
                height: 20.sp,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(0),
                  itemCount: controller
                      .mDashboardScreenController.mTobBarModel.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TopBarRow(
                      index: index,
                    );
                  },
                ),
              )),

              ///show Profile
              TopBarProfileView()
            ],
          ),
        ));
  }

}
