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
    return Obx(
      () => controller.valueLoading.isNotEmpty?
          Container(
            alignment: Alignment.center,
            child: Text(controller.valueLoading.value),
          ):
      controller.groupedByDepartment.isEmpty
          ? Center(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(10.5.sp),
                  height: 25.sp,
                  width: 25.sp,
                  child: const CircularProgressIndicator()),
            ) :
      ListView(
          children: controller.groupedByDepartment.entries.map((entry) {
            final department = entry.key;
            final mGetAllTablesResponseList = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Department Header
                Padding(
                  padding:  EdgeInsets.all(8.sp),
                  child: Text(
                    department,
                    style: getText600(size: 13.sp,colors: Colors.black),
                  ),
                ),
                DynamicHeightGridView(
                    itemCount: mGetAllTablesResponseList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.sp,
                    mainAxisSpacing: 13.sp,
                    builder: (ctx, index) {
                      /// return your widget here.
                      return TableRowView(
                        index: index,
                        mGetAllTablesResponseData: mGetAllTablesResponseList[index],
                      );
                    }),
              ],
            );
          }).toList()

    )

    );
  }
}
