import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_settings/view/settings_row_view.dart';
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common_view/button_view/button_view.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends GetView<SettingsMenuController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SettingsMenuController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child:Column(
          children: [
            Expanded(child: Container(
              margin: EdgeInsets.only(top: 11.sp, left: 11.sp, right: 11.sp),
              padding: EdgeInsets.all(11.sp),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.sp),
                ),
              ),
              alignment: Alignment.topLeft,
              child:  DynamicHeightGridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.settingsMenu.length,
                  crossAxisCount: 5,
                  crossAxisSpacing: 11.sp,
                  mainAxisSpacing: 11.sp,
                  builder: (ctx, index) {
                    /// return your widget here.
                    return SettingsRowView(
                      index: index,
                    );
                  })
            )),
            const ButtonView()
          ],
        )
        );
  }
}
