import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/search_order/view/search_order_screen.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/selected_order/view/selected_order_screen.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../home_base_controller/home_base_controller.dart';

class HomeScreen extends GetView<HomeBaseController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeBaseController());
    return FocusDetector(
        onVisibilityGained: () {
          controller.onHomeUpdate();
        },
        onVisibilityLost: () {},
        child:  Row(
          children: [
            Expanded(flex: 7, child: SearchOrderScreen()),
            const Expanded(flex: 3, child: SelectedOrderScreen())
          ],
        ));
  }
}
