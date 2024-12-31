// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/date_range_picker.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_request.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../payment_screen/controller/payment_screen_controller.dart';
import '../../payment_screen/view/payment_screen.dart';
import '../view/item_summary/controller/item_summary_controller.dart';
import '../view/item_summary/view/item_summary_order_screen.dart';

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
    OrderHistoryData mOrderData =  mOrderHistoryData[index];
    await AppAlert.showView(
        Get.context!,
         Row(
          children: [
            const Expanded(flex: 7, child: SizedBox()),
            Expanded(flex: 3, child: ItemSummaryOrderScreen(mOrderData))
          ],
        ),
        barrierDismissible: true);
    if (Get.isRegistered<ItemSummaryController>()) {
      Get.delete<ItemSummaryController>();
    }
  }

  void onPayNow(int index) async {
    // await AppAlert.showView(
    //     Get.context!,
    //     const Row(
    //       children: [
    //         Expanded(flex: 7, child: SizedBox()),
    //         Expanded(flex: 3, child: PayNowOrderScreen())
    //       ],
    //     ),
    //     barrierDismissible: true);
    // if (Get.isRegistered<PayNowController>()) {
    //   Get.delete<PayNowController>();
    // }
    await AppAlert.showView(Get.context!, PaymentScreen(OrderPlace(),  onPayment: () {
      Get.back();
    },),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }

  // void onDeleteSale(int index) async{
  //   await AppAlert.showView(Get.context!, const CancelOrderScreen(),
  //       barrierDismissible: true);
  //   if (Get.isRegistered<CancelOrderController>()) {
  //     Get.delete<CancelOrderController>();
  //   }
  // }

  ///api call
  RxInt pageNumber = 1.obs;
  RxInt totalPageNumber = 0.obs;
  RxList<OrderHistoryData> mOrderHistoryData = <OrderHistoryData>[].obs;
  RxString sLoading = 'Loading...'.obs;

  void callOrderHistory({
    String search = "",
    String trackingOrderID = "",
    int orderType = 0,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          var configurationLocalApi = locator.get<ConfigurationLocalApi>();
          ConfigurationResponse mConfigurationResponse =
              await configurationLocalApi.getConfigurationResponse() ??
                  ConfigurationResponse();
          OrderHistoryRequest mOrderHistoryRequest = OrderHistoryRequest(
              rowsPerPage: 20,
              counterIDF:
                  (mConfigurationResponse.configurationData?.counterData ?? [])
                          .isEmpty
                      ? ""
                      : (mConfigurationResponse
                                  .configurationData?.counterData ??
                              [])
                          .first
                          .counterIDP,
              pageNumber: pageNumber.value,
              searchValue: search,
              fromDate: fromDate == null ? "" : getUTCValue(fromDate),
              toDate: toDate == null ? "" : getUTCValue(toDate),
              orderType: orderType,
              trackingOrderID: trackingOrderID);
          WebResponseSuccess mWebResponseSuccess =
              await orderPlaceApi.postOrderHistory(mOrderHistoryRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            OrderHistoryResponse mOrderHistoryResponse =
                mWebResponseSuccess.data;

            totalPageNumber.value =
                mOrderHistoryResponse.mOrderHistoryResponseData?.totalPage ?? 0;
            if (totalPageNumber.value == 0) {
              sLoading.value = "No sale history found";
              sLoading.refresh();
            } else {
              sLoading.value = "";
              sLoading.refresh();

              mOrderHistoryData.clear();
              mOrderHistoryData.addAll(
                  mOrderHistoryResponse.mOrderHistoryResponseData?.data ?? []);
              totalPageNumber.refresh();
              mOrderHistoryData.refresh();
            }
          } else {
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
          }
        } else {
          AppAlert.showSnackBar(
              Get.context!, MessageConstants.noInternetConnection);
        }
      });
    } catch (e) {
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }
}
