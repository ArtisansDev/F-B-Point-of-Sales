import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_stock/view/top_search_view/menu_stock_search_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/menu_stock_controller.dart';
import 'menu_stock_list/menu_stock_list_view.dart';

class MenuStockScreen extends GetView<MenuStockController> {
  const MenuStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuStockController());
    return FocusDetector(
        onVisibilityGained: () {
          controller.onStockItem();
        },
        onVisibilityLost: () {},
        child: Container(
          margin: EdgeInsets.only(top: 11.sp, left: 11.sp, right: 11.sp),
          padding: EdgeInsets.only(bottom: 11.sp),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.sp),
              topLeft: Radius.circular(8.sp),
              bottomLeft: Radius.circular(8.sp),
              bottomRight: Radius.circular(8.sp),
            ),
          ),
          width: 80.w,
          height: 80.h,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 10.sp, left: 11.sp, right: 11.sp, bottom: 10.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.cAppButtonLightColour,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.sp),
                    topLeft: Radius.circular(8.sp),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.sp,
                    ),
                    Expanded(
                        child: Text(
                      sStockAvailability.tr,
                      style: getText600(
                          colors: ColorConstants.appTextSalesHader,
                          size: 12.sp),
                    )),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10.sp),
                        height: 16.5.sp,
                        width: 16.5.sp,
                        padding: EdgeInsets.all(4.5.sp),
                        decoration: BoxDecoration(
                          color: ColorConstants.cAppButtonColour,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.sp),
                          ),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: ColorConstants.white,
                          size: 11.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              MenuStockSearchView(),
              Expanded(child: MenuStockListView())
            ],
          ),
        ));
  }
}
