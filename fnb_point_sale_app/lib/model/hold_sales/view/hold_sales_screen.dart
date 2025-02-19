import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/hold_sales/view/sales_list/hold_sales_list_view.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/sales_list/sales_list_view.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/top_search_view/search_date_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/hold_sales_controller.dart';

class HoldSalesScreen extends GetView<HoldSalesController> {
  const HoldSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HoldSalesController());
    return FocusDetector(
        onVisibilityGained: () {
          controller.getAllHoldSale();
        },
        onVisibilityLost: () {},
        child: Container(
            height: 70.h,
            width: 70.w,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(11.sp),
              ),
            ),
            child: HoldSalesListView()));
  }
}
