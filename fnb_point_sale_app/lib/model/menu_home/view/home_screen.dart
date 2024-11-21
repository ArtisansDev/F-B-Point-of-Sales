import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/search_order/view/search_order_screen.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/selected_order/view/selected_order_screen.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: const Row(
          children: [
            Expanded(flex: 7, child: SearchOrderScreen()),
            Expanded(flex: 3, child: SelectedOrderScreen())
          ],
        ));
  }
}
