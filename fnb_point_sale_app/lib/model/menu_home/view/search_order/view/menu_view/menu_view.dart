import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'category_row_view.dart';
import 'controller/menu_view_controller.dart';
import 'menu_row_view.dart';

class MenuView extends GetView<MenuViewController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuViewController());
    controller.onHomeUpdate();
    controller.getAllCategoryList();
    return Obx(
      () {
        if (controller.mGetAllCategoryView.isEmpty &&
            controller.mMenuItemData.isEmpty) {
          return const SizedBox();
        } else {
          return Container(
            padding: EdgeInsets.all(11.sp),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///CategoryView
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   margin: EdgeInsets.only(bottom: 11.sp, left: 15.sp),
                  //   child: Visibility(
                  //       visible: controller.mGetAllCategoryView.isNotEmpty,
                  //       child: Text(
                  //         'Items',
                  //         style: getText600(
                  //             colors: ColorConstants.cAppColors,
                  //             size: 12.sp),
                  //       )),
                  // ),
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
                      }),

                  ///no sub Category
                  if ((controller.mSelectMenuViewController.value
                                  ?.selectGetAllCategory ??
                              [])
                          .isEmpty ||
                      (controller.mSelectMenuViewController.value
                                  ?.selectGetAllCategory ??
                              [])
                          .last
                          ?.subCategories
                          .isNotEmpty)
                    const SizedBox()
                  else
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 11.sp, left: 13.sp),
                      child: Visibility(
                          visible: (controller.mSelectMenuViewController.value
                                      ?.selectGetAllCategory ??
                                  [])
                              .last
                              ?.subCategories
                              .isEmpty,
                          child: Text(
                            'No Sub Category',
                            style: getText500(
                                colors: ColorConstants.cAppColors, size: 12.sp),
                          )),
                    ),

                  ///mMenuItemData
                  (controller.mSelectMenuViewController.value
                                  ?.selectGetAllCategory ??
                              [])
                          .isEmpty
                      ? const SizedBox()
                      : Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              top: 11.sp, bottom: 11.sp, left: 13.sp),
                          child: Visibility(
                              visible: controller.mMenuItemData.isNotEmpty &&
                                  (controller.mSelectMenuViewController.value
                                              ?.selectGetAllCategory ??
                                          [])
                                      .isNotEmpty,
                              child: Text(
                                '${(controller.mSelectMenuViewController.value?.selectGetAllCategory.last ?? GetAllCategoryData()).categoryName} Menu Items',
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
        }
      },
    );
  }
}
