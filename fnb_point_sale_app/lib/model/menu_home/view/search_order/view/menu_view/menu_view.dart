import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../home_base_controller/home_base_controller.dart';
import 'category_row_view.dart';
import 'menu_row_view.dart';

class MenuView extends StatelessWidget {
  late HomeBaseController controller;

  MenuView({super.key}) {
    controller = Get.find<HomeBaseController>();
  }

  @override
  Widget build(BuildContext context) {
    controller.getAllCategoryList();
    return Obx(
      () {
        return Container(
          padding: EdgeInsets.all(11.sp),
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.sp),
            ),
          ),
          child: (controller.mGetAllCategoryView.isEmpty &&
                  controller.mMenuItemData.isEmpty)
              ? const Center(
                  child: Text("Loading...."),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///CategoryView
                      if ((controller.selectGetAllCategory ?? []).isEmpty ||
                          (controller.selectGetAllCategory ?? [])
                              .last
                              ?.subCategories
                              .isNotEmpty)
                        DynamicHeightGridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.mGetAllCategoryView.length,
                            crossAxisCount: 4,
                            crossAxisSpacing: 11.sp,
                            mainAxisSpacing: 11.sp,
                            builder: (ctx, index) {
                              /// return your widget here.
                              return CategoryRowView(
                                index: index,
                              );
                            })
                      else
                        const SizedBox(),

                      ///no sub Category
                      if ((controller.selectGetAllCategory ?? []).isEmpty ||
                          (controller.selectGetAllCategory ?? [])
                              .last
                              ?.subCategories
                              .isNotEmpty)
                        const SizedBox()
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 11.sp, left: 13.sp),
                          child: Visibility(
                              visible: (controller.selectGetAllCategory ?? [])
                                  .last
                                  ?.subCategories
                                  .isEmpty,
                              child: Text(
                                'No Sub Category',
                                style: getText500(
                                    colors: ColorConstants.cAppColors,
                                    size: 12.sp),
                              )),
                        ),

                      ///mMenuItemData
                      (controller.selectGetAllCategory ?? []).isEmpty
                          ? controller.mMenuItemData.isEmpty
                              ? const SizedBox()
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: 11.sp, bottom: 11.sp, left: 13.sp),
                                  child: Text(
                                    'Menu Items',
                                    style: getText600(
                                        colors: ColorConstants.cAppColors,
                                        size: 12.sp),
                                  ))
                          : Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: 11.sp, bottom: 11.sp, left: 13.sp),
                              child: Visibility(
                                  visible: controller
                                          .mMenuItemData.isNotEmpty &&
                                      (controller.selectGetAllCategory ?? [])
                                          .isNotEmpty,
                                  child: Text(
                                    '${(controller.selectGetAllCategory.last ?? GetAllCategoryData()).categoryName} Menu Items',
                                    style: getText600(
                                        colors: ColorConstants.cAppColors,
                                        size: 12.sp),
                                  )),
                            ),
                      DynamicHeightGridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.mMenuItemData.length,
                          crossAxisCount: 4,
                          crossAxisSpacing: 11.sp,
                          mainAxisSpacing: 11.sp,
                          builder: (ctx, index) {
                            /// return your widget here.
                            return MenuRowView(
                              index: index,
                            );
                          })
                    ],
                  ),
                ),
        );
      },
    );
  }
}
