import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/sales_list/sales_list_view.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/top_search_view/search_date_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';

import '../controller/menu_sales_controller.dart';

class MenuSalesScreen extends GetView<MenuSalesController> {
  const MenuSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuSalesController());
    // controller.setCurrentPage();
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Column(
          children: [SearchDateView(), Expanded(child: SalesListView())],
        ));
  }
}
