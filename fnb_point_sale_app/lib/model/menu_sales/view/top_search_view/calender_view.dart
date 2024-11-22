/*
 * Project      : fnb_point_sale_app
 * File         : table_row_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common_view/date_range_picker/models.dart';
import '../../../../common_view/date_range_picker/widgets/inputs/field.dart';
import '../../controller/menu_sales_controller.dart';

class CalenderView extends StatelessWidget {
  late MenuSalesController controller;

  CalenderView({super.key}) {
    controller = Get.find<MenuSalesController>();
  }

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerRight,
      child: DateRangeField(
        imageString: ImageAssetsConstants.appCalendar,
        onDateRangeSelected: (value) {
          if (value?.start != null) {
            if (value?.end != null) {
              controller.selectedDateRange = value;
              controller.onDateSelected(
                  controller.selectedDateRange?.start, controller.selectedDateRange?.end);
            } else {
              controller.selectedDateRange = DateRangeModel(value!.start, value.start);
              controller.onDateSelected(
                  controller.selectedDateRange?.start, controller.selectedDateRange?.end);
            }
          }
        },
        selectedDateRange: controller.selectedDateRange,
        pickerBuilder: controller.datePickerBuilder,
      ),
    );

  }
}
