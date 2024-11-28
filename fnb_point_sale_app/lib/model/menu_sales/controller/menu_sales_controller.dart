// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/date_range_picker.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../cancel_order/controller/cancel_order_controller.dart';
import '../../cancel_order/view/cancel_order_screen.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../menu_table/view/table_view/table_summary/controller/table_summary_controller.dart';
import '../../menu_table/view/table_view/table_summary/view/table_summary_order_screen.dart';
import '../../pay_now/controller/pay_now_controller.dart';
import '../../pay_now/view/pay_now_order_screen.dart';

class MenuSalesController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString selectType = sAll.tr.obs;
  Rx<TextEditingController> sSelectDateRangeController =
      TextEditingController().obs;
  DateRangeModel? selectedDateRange;
  List<DateTime> disabledDates = [];

  Widget datePickerBuilder(BuildContext context,
      dynamic Function(DateRangeModel?) onDateRangeChanged) {
    disabledDates.clear();
    for (var i = 1; i < 360; i++) {
      disabledDates.add(DateTime.now().add(Duration(days: i)));
    }
    return DateRangePickerWidget(
      doubleMonth: true,
      maximumDateRangeLength: 180,
      quickDateRanges: [
        QuickDateRange(dateRange: null, label: 'Remove date range'),
        QuickDateRange(
          label: 'Last 3 days',
          dateRange: DateRangeModel(
            DateTime.now().subtract(const Duration(days: 3)),
            DateTime.now(),
          ),
        ),
        QuickDateRange(
          label: 'Last 7 days',
          dateRange: DateRangeModel(
            DateTime.now().subtract(const Duration(days: 7)),
            DateTime.now(),
          ),
        ),
        QuickDateRange(
          label: 'Last 30 days',
          dateRange: DateRangeModel(
            DateTime.now().subtract(const Duration(days: 30)),
            DateTime.now(),
          ),
        ),
        QuickDateRange(
          label: 'Last 90 days',
          dateRange: DateRangeModel(
            DateTime.now().subtract(const Duration(days: 90)),
            DateTime.now(),
          ),
        ),
        QuickDateRange(
          label: 'Last 180 days',
          dateRange: DateRangeModel(
            DateTime.now().subtract(const Duration(days: 180)),
            DateTime.now(),
          ),
        ),
      ],
      minimumDateRangeLength: 1,
      initialDateRange: selectedDateRange,
      disabledDates: disabledDates,
      initialDisplayedDate: selectedDateRange?.start ?? DateTime.now(),
      onDateRangeChanged: onDateRangeChanged,
      height: 43.h,
      theme: CalendarTheme(
        selectedColor: ColorConstants.cAppButtonColour,
        dayNameTextStyle:
            getTextRegular(colors: ColorConstants.cAppTaxColour, size: 10.4.sp),
        inRangeColor: ColorConstants.cAppButtonLightColour,
        inRangeTextStyle:
            getText500(colors: ColorConstants.cAppButtonColour, size: 11.sp),
        selectedTextStyle: getText500(size: 11.sp),
        todayTextStyle: getText600(colors: ColorConstants.black, size: 10.4.sp),
        defaultTextStyle:
            getTextRegular(colors: ColorConstants.black, size: 11.sp),
        radius: 10,
        tileSize: 40,
        disabledTextStyle: const TextStyle(color: Colors.grey),
        quickDateRangeBackgroundColor:
            ColorConstants.cAppTaxColour.withOpacity(0.05),
        selectedQuickDateRangeColor: ColorConstants.cAppButtonColour,
      ),
    );
  }

  void onDateSelected(DateTime? fromDate, DateTime? toDate) {
    MyLogUtils.logDebug('fromDate : $fromDate, toDate : $toDate');
    sSelectDateRangeController.value.text =
        '${DateFormat('dd/MM/yyyy').format(fromDate!)} - ${DateFormat('dd/MM/yyyy').format(toDate!)}';
  }

  void onEdit(int index) async {
    await AppAlert.showView(
        Get.context!,
        const Row(
          children: [
            Expanded(flex: 7, child: SizedBox()),
            Expanded(flex: 3, child: TableSummaryOrderScreen())
          ],
        ),
        barrierDismissible: true);
    if (Get.isRegistered<TableSummaryController>()) {
      Get.delete<TableSummaryController>();
    }
  }

  void onPayNow(int index) async {
    await AppAlert.showView(
        Get.context!,
        const Row(
          children: [
            Expanded(flex: 7, child: SizedBox()),
            Expanded(flex: 3, child: PayNowOrderScreen())
          ],
        ),
        barrierDismissible: true);
    if (Get.isRegistered<PayNowController>()) {
      Get.delete<PayNowController>();
    }
  }

  void onDeleteSale(int index) async{
    await AppAlert.showView(Get.context!, const CancelOrderScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<CancelOrderController>()) {
      Get.delete<CancelOrderController>();
    }
  }
}
