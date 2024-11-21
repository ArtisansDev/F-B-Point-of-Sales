import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_view/table_row_view.dart';
import 'package:fnb_point_sale_base/common/dynamic_height_grid_view.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/button_bar/button_bar_model.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/table_controller.dart';

class TableView extends StatelessWidget {
  late TableController controller;

  TableView({super.key}) {
    controller = Get.find<TableController>();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
        itemCount: 12,
        crossAxisCount: 4,
        crossAxisSpacing: 10.sp,
        mainAxisSpacing: 13.sp,
        builder: (ctx, index) {
          /// return your widget here.
          return TableRowView(
            index: index,
          );
        });
  }
}
