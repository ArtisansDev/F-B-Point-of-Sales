import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controller/menu_view_controller.dart';
import 'menu_row_view.dart';


class MenuView extends GetView<MenuViewController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuViewController());
    return Container(
      padding: EdgeInsets.all(11.sp),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.all(
           Radius.circular(8.sp),
        ),
      ),
      child: DynamicHeightGridView(
          itemCount: controller.menuList.value.length,
          crossAxisCount: 4,
          crossAxisSpacing: 11.sp,
          mainAxisSpacing: 11.sp,
          builder: (ctx, index) {
            /// return your widget here.
            return MenuRowView(
              index: index,
            );
          }),
    );
  }
}
