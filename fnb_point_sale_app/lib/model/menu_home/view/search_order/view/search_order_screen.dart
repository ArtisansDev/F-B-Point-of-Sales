import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/search_order/view/search_view/search_view.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/search_order/view/select_menu_view/select_menu_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../common_view/button_view/button_view.dart';
import '../../../home_base_controller/home_base_controller.dart';
import 'menu_view/menu_view.dart';

class SearchOrderScreen extends StatelessWidget {
  late HomeBaseController controller;

  SearchOrderScreen({super.key}) {
    controller = Get.find<HomeBaseController>();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
            margin: EdgeInsets.only(top: 7.sp, left: 11.sp, right: 8.sp),
            child: Column(
              children: [
                ///search
                SearchView(),

                ///select menu
                SelectMenuView(),

                ///MenuView
                Expanded(child: MenuView()),

                ///button view Hold,cancel...
                const ButtonView(),
              ],
            )));
  }
}
