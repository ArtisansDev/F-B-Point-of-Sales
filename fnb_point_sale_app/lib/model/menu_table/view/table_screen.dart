import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_view/table_view.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_view/top_search_view/table_search_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common_view/button_view/button_view.dart';
import '../controller/table_controller.dart';

class TableScreen extends GetView<TableController> {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TableController());
    return FocusDetector(
        onVisibilityGained: ()  {
          controller.onRefresh();
        },
        onVisibilityLost: () {},
        child: Container(
          margin: EdgeInsets.only(
            top: 10.5.sp,
            left: 10.5.sp,
            right: 10.5.sp,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              TableSearchView(),
              Expanded(child: TableView()),
              const ButtonView()
            ],
          ),
        ));
  }
}
