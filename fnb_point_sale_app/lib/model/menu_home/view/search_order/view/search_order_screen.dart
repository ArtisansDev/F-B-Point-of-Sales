import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/search_order/view/search_view/search_view.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/search_order/view/select_menu_view/select_menu_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../common_view/button_view/button_view.dart';
import '../controller/search_order_controller.dart';
import 'menu_view/menu_view.dart';

class SearchOrderScreen extends GetView<SearchOrderController> {
  const SearchOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SearchOrderController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
            margin: EdgeInsets.only(
                top: 7.sp, left: 11.sp, right: 8.sp, bottom: 8.sp),
            child: const Column(
              children: [
                ///search
                SearchView(),

                ///select menu
                SelectMenuView(),

                ///MenuView
                Expanded(child: MenuView()),

                ///button view Hold,cancel...
                ButtonView(),
              ],
            )));
  }
}
