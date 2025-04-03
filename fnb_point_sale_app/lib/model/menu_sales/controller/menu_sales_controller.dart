// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/alert_action.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/date_range_picker.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/offline_place_order/offline_place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/manager_credentials/manager_credentials_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_request.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_place/process_multiple_orders_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/table_status_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/utils/create_order_place_request.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../branch_manager_credentials_screen/controller/branch_manager_controller.dart';
import '../../branch_manager_credentials_screen/view/branch_manager_screen.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../../payment_screen/payment_type/cash_view/controller/cash_view_controller.dart';
import '../../payment_screen/payment_type/cash_view/view/cash_view.dart';
import '../../payment_screen/payment_type/credit_card_view/controller/credit_card_view_controller.dart';
import '../../payment_screen/payment_type/credit_card_view/view/credit_card_view.dart';
import '../../payment_screen/payment_type/debit_card_view/controller/debit_card_view_controller.dart';
import '../../payment_screen/payment_type/debit_card_view/view/debit_card_view.dart';
import '../../payment_screen/payment_type/qr_code_view/controller/qr_view_controller.dart';
import '../../payment_screen/payment_type/qr_code_view/view/qr_view.dart';
import '../../payment_type_screen/controller/payment_type_controller.dart';
import '../../payment_type_screen/view/payment_type_screen.dart';
import '../../refund_payment_type_screen/controller/refund_payment_type_controller.dart';
import '../../refund_payment_type_screen/view/refund_payment_type_screen.dart';
import '../view/item_payment_screen/controller/item_payment_screen_controller.dart';
import '../view/item_payment_screen/view/item_payment_screen.dart';
import '../view/item_summary/controller/item_summary_controller.dart';
import '../view/item_summary/view/item_summary_order_screen.dart';

class MenuSalesController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  TopBarController mTopBarController = Get.find<TopBarController>();

  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString selectType = 'Select Type'.obs;
  RxList<String> selectTypeList =
      <String>[sAll.tr, sDine_In.tr, sTake_Away.tr].obs;

  RxString selectOrderSourceType = 'Select Source'.obs;
  RxList<String> orderSourceList =
      <String>[sAll.tr, 'Mobile App', 'Pos', 'Web'].obs;

  RxString selectPaymentStatus = 'Payment Status'.obs;
  RxList<String> paymentStatusList =
      <String>[sAll.tr, 'Success', 'Pending', 'Refund', 'Cancel'].obs;

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
        '${DateFormat('dd/MM/yyyy').format(selectedDateRange?.start ?? DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(selectedDateRange?.end ?? DateTime.now())}';
    sSelectDateRangeController.refresh();

    MyLogUtils.logDebug(
        "######## ${selectedDateRange?.start ?? DateTime.now()}");
    MyLogUtils.logDebug("######## ${selectedDateRange?.end ?? DateTime.now()}");

    ///api call
    pageNumber.value = 1;
    sLoading.value = 'Loading...';
    callOrderHistory();

    ///
  }

  void onView(int index) async {
    OrderHistoryData mOrderData = mOrderHistoryData[index];
    await AppAlert.showViewWithoutBlur(
        Get.context!,
        Row(
          children: [
            const Expanded(flex: 7, child: SizedBox()),
            Expanded(flex: 3, child: ItemSummaryOrderScreen(mOrderData, index))
          ],
        ),
        barrierDismissible: true);
    if (Get.isRegistered<ItemSummaryController>()) {
      Get.delete<ItemSummaryController>();
    }
  }

  void onAlertView(int index) async {
    AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Change Payment type!',
        'Do you want to change the payment type?', () {
      onPayNow(index);
    }, rightText: 'Yes');
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
  RxInt orderSource = 0.obs;
  RxInt totalPageNumber = 0.obs;
  RxList<OrderHistoryData> mOrderHistoryData = <OrderHistoryData>[].obs;
  RxString sLoading = 'Loading...'.obs;
  int orderType = 0;
  RxString search = "".obs;
  Rxn<String> paymentStatus = Rxn<String>();
  Rxn<String> sCounterBalanceHistoryIDF = Rxn<String>();

  callOrderHistory({
    String trackingOrderID = "",
  }) async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();
      sCounterBalanceHistoryIDF.value = await SharedPrefs().getHistoryID();
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
              searchValue: search.value,
              orderSource: orderSource.value.toString(),
              paymentStatus: paymentStatus.value,
              fromDate: selectedDateRange == null
                  ? ""
                  : (selectedDateRange?.start ?? DateTime.now()).toString(),
              toDate: selectedDateRange == null
                  ? ""
                  : (selectedDateRange?.end ?? DateTime.now()).toString(),
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

  ///payment
  void onPayNow(int index) async {
    OrderHistoryData mOrderHistory = mOrderHistoryData[index];
    await AppAlert.showViewWithoutBlur(
        Get.context!,
        ItemPaymentScreen(
          mOrderHistory,
          onPayment: (GetAllPaymentTypeData mGetAllPaymentTypeData,
              GetAllCustomerList? mGetAllCustomerList) async {
            Get.back();
            orderPayment(
                mGetAllPaymentTypeData, mOrderHistory, mGetAllCustomerList);
          },
        ),
        barrierDismissible: true);
    if (Get.isRegistered<ItemPaymentScreenController>()) {
      Get.delete<ItemPaymentScreenController>();
    }
  }

  ///Cancel Payment
  void orderCancelPayment(
    OrderHistoryData mOrderHistory,
  ) async {
    ///
    OrderDetailList mOrderDetailList = await cancelOrder(
      remarksController: mOrderHistory.additionalNotes ?? '',
      mOrderPlace: mOrderHistory,
      // printOrderPayment: mGetAllPaymentTypeData,
      // mGetAllCustomerList: mGetAllCustomerList,
    );
    debugPrint("OrderDetail ----- ${jsonEncode(mOrderDetailList)}");

    ///printOrderPayment

    /// var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
    /// await mPlaceOrderSaleLocalApi
    ///     .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
    ///  await printOrderPayment(mOrderDetailList,mOrderHistory);

    await callSaveOrder(mOrderDetailList, mOrderHistory,
        isPayment: true, isCancel: true);

    ///
    await mDashboardScreenController.onUpdateHoldSale();
    await callOrderHistory();

    ///remove hold
    await mTopBarController.removeHoldSale(
      mOrderDetailList.trackingOrderID ?? '',
    );

    ///clear table
    if ((mOrderDetailList.tableNo ?? "").isNotEmpty) {
      TablesByTableStatusData mTablesByTableStatusData =
          TablesByTableStatusData(
        occupiedTrackingOrderID: mOrderDetailList.trackingOrderID ?? '',
        occupiedOrderID: mOrderDetailList.trackingOrderID ?? '',
        seatIDP: mOrderDetailList.seatIDF ?? '',
      );
      await callUpdateTableStatus(mTablesByTableStatusData);
    }

    await mTopBarController.allOrderPlace();
  }

  ///
  void orderPayment(
      GetAllPaymentTypeData mGetAllPaymentTypeData,
      OrderHistoryData mOrderHistory,
      GetAllCustomerList? mGetAllCustomerList) async {
    ///payment
    switch (mGetAllPaymentTypeData.paymentGatewayNo) {
      case "0":
        OrderPlace orderPlace = OrderPlace();
        orderPlace.totalPrice = mOrderHistory.totalAmount ?? 0.0;

        ///Cash
        await AppAlert.showViewWithoutBlur(
            Get.context!,
            CashViewScreen(
              mOrderPlace: orderPlace,
              onPayment: (String sValue) {
                mGetAllPaymentTypeData.setRequestData(sValue);
              },
            ));
        bool isSuccess = false;
        if (Get.isRegistered<CashViewController>()) {
          isSuccess = Get.find<CashViewController>().isSuccess.value;
          await Get.delete<CashViewController>();
        }
        debugPrint(
            "## mGetAllPaymentTypeData ----- ${jsonEncode(mGetAllPaymentTypeData)}");
        if (!isSuccess) {
          return;
        }
        break;
      case "5":

        ///Debit Card
        await AppAlert.showViewWithoutBlur(Get.context!, DebitCardView(
          onPayment: (String value) {
            mGetAllPaymentTypeData.setRequestData(value);
          },
        ));
        if (Get.isRegistered<DebitCardViewController>()) {
          Get.delete<DebitCardViewController>();
        }
        break;
      case "6":

        ///Credit Card
        await AppAlert.showViewWithoutBlur(Get.context!, CreditCardView(
          onPayment: (String value) {
            mGetAllPaymentTypeData.setRequestData(value);
          },
        ));
        if (Get.isRegistered<CreditCardViewController>()) {
          Get.delete<CreditCardViewController>();
        }
        break;
      case "7":

        ///Qr code
        await AppAlert.showViewWithoutBlur(
            Get.context!,
            QrView(
              mSelectPaymentType: mGetAllPaymentTypeData,
              onPayment: (String sValue) {
                mGetAllPaymentTypeData.setRequestData(sValue);
              },
            ));
        if (Get.isRegistered<QrViewController>()) {
          await Get.delete<QrViewController>();
        }
        break;
    }

    if ((mGetAllPaymentTypeData.paymentGatewayNo == "5" ||
            mGetAllPaymentTypeData.paymentGatewayNo == "6" ||
            mGetAllPaymentTypeData.paymentGatewayNo == "7") &&
        mGetAllPaymentTypeData.requestData == 'Cancel') {
      return;
    }
    OrderDetailList mOrderDetailList =
        await createOrderPlaceRequestFromOrderHistory(
      remarksController: mOrderHistory.additionalNotes ?? '',
      mOrderPlace: mOrderHistory,
      printOrderPayment: mGetAllPaymentTypeData,
      mGetAllCustomerList: mGetAllCustomerList,
    );
    debugPrint("OrderDetail ----- ${jsonEncode(mOrderDetailList)}");

    ///printOrderPayment

    /// var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
    /// await mPlaceOrderSaleLocalApi
    ///     .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
    ///  await printOrderPayment(mOrderDetailList,mOrderHistory);

    await callSaveOrder(mOrderDetailList, mOrderHistory, isPayment: true);

    ///
    await mDashboardScreenController.onUpdateHoldSale();
    await callOrderHistory();

    ///remove hold
    await mTopBarController.removeHoldSale(
      mOrderDetailList.trackingOrderID ?? '',
    );

    ///clear table
    if ((mOrderDetailList.tableNo ?? "").isNotEmpty) {
      TablesByTableStatusData mTablesByTableStatusData =
          TablesByTableStatusData(
        occupiedTrackingOrderID: mOrderDetailList.trackingOrderID ?? '',
        occupiedOrderID: mOrderDetailList.trackingOrderID ?? '',
        seatIDP: mOrderDetailList.seatIDF ?? '',
      );
      await callUpdateTableStatus(mTablesByTableStatusData);
    }

    ///
    await mTopBarController.allOrderPlace();
  }

  ///SaveOrder
  callSaveOrder(
      OrderDetailList mOrderDetailList, OrderHistoryData mOrderHistory,
      {bool isPayment = false, bool isCancel = false}) async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          ProcessMultipleOrdersRequest mProcessMultipleOrdersRequest =
              ProcessMultipleOrdersRequest(orderDetailList: [mOrderDetailList]);
          WebResponseSuccess mWebResponseSuccess =
              await orderPlaceApi.postOrderPlace(mProcessMultipleOrdersRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            ///print....
            if (!isCancel) {
              await printOrderPayment(mOrderDetailList, mOrderHistory);
            }

            ///remove from local data base
            if (isPayment) {
              var mPlaceOrderSaleLocalApi =
                  locator.get<PlaceOrderSaleLocalApi>();
              await mPlaceOrderSaleLocalApi
                  .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
            }
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
          } else {
            ///off line save
            if (isPayment) {
              ///offline save
              var mOfflinePlaceOrderSaleLocalApi =
                  locator.get<OfflinePlaceOrderSaleLocalApi>();
              ProcessMultipleOrdersRequest mProcessMultipleOrders =
                  await mOfflinePlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
                      ProcessMultipleOrdersRequest();
              if ((mProcessMultipleOrders.orderDetailList ?? []).isEmpty) {
                await mOfflinePlaceOrderSaleLocalApi
                    .save(mProcessMultipleOrdersRequest);
              } else {
                if ((mProcessMultipleOrdersRequest.orderDetailList ?? [])
                    .isNotEmpty) {
                  await mOfflinePlaceOrderSaleLocalApi.getPlaceOrderAdd(
                      (mProcessMultipleOrdersRequest.orderDetailList ?? [])
                          .first);
                }
              }

              ///remove
              var mPlaceOrderSaleLocalApi =
                  locator.get<PlaceOrderSaleLocalApi>();
              await mPlaceOrderSaleLocalApi
                  .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
            }
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

  ///update table status
  callUpdateTableStatus(
      TablesByTableStatusData mTablesByTableStatusData) async {
    ///api product call
    final orderPlaceApi = locator.get<OrderPlaceApi>();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        TableStatusRequest mTableStatusRequest = TableStatusRequest(
            trackingOrderID:
                mTablesByTableStatusData.occupiedTrackingOrderID ?? '',
            tableStatus: 'A',
            seatIDP: mTablesByTableStatusData.seatIDP,
            userIDF: await SharedPrefs().getUserId());

        WebResponseSuccess mWebResponseSuccess =
            await orderPlaceApi.postTableStatus(mTableStatusRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          // onRefresh();
        } else {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  ///print
  printOrderPayment(
    OrderDetailList mOrderDetailList,
    OrderHistoryData mOrderHistory,
  ) async {
    final myPrinterService = locator.get<MyPrinterService>();
    if (mDashboardScreenController.mPrinterSettingsDataCustomer.printCopies ==
        null) {
      await myPrinterService.saleAfterPayment(
          mOrderDetailList, mOrderHistory, null);
      await myPrinterService.saleAfterPayment(
          mOrderDetailList, mOrderHistory, null);
    } else {
      for (int i = 0;
          i <
              (mDashboardScreenController
                      .mPrinterSettingsDataCustomer.printCopies ??
                  0);
          i++) {
        await myPrinterService.saleAfterPayment(mOrderDetailList, mOrderHistory,
            mDashboardScreenController.mPrinterSettingsDataCustomer);
      }
    }
  }

  void onPrint(int index) async {
    OrderHistoryData mOrderData = mOrderHistoryData[index];
    final myPrinterService = locator.get<MyPrinterService>();
    for (int i = 0;
        i <
            (mDashboardScreenController
                    .mPrinterSettingsDataCustomer.printCopies ??
                0);
        i++) {
      await myPrinterService.salePayment(
          mOrderData, mDashboardScreenController.mPrinterSettingsDataCustomer);
    }
  }

  void onPrintRefund(int index) async {
    OrderHistoryData mOrderData = mOrderHistoryData[index];
    final myPrinterService = locator.get<MyPrinterService>();
    for (int i = 0;
        i <
            (mDashboardScreenController
                    .mPrinterSettingsDataCustomer.printCopies ??
                0);
        i++) {
      await myPrinterService.saleRefundPayment(
          mOrderData, mDashboardScreenController.mPrinterSettingsDataCustomer);
    }
  }

  void onPrintKot(int index) async {
    OrderHistoryData mOrderData = mOrderHistoryData[index];
    final myPrinterService = locator.get<MyPrinterService>();

    ///Kitchen printCopies
    if (mDashboardScreenController.mPrinterSettingsDataKitchen.printCopies ==
        null) {
      await myPrinterService.salePaymentKot(mOrderData, null);
      await myPrinterService.salePaymentKot(mOrderData, null, duplicate: true);
    } else {
      for (int i = 0;
          i <
              (mDashboardScreenController
                      .mPrinterSettingsDataKitchen.printCopies ??
                  0);
          i++) {
        if (i == 0) {
          await myPrinterService.salePaymentKot(mOrderData,
              mDashboardScreenController.mPrinterSettingsDataKitchen);
        } else {
          await myPrinterService.salePaymentKot(mOrderData,
              mDashboardScreenController.mPrinterSettingsDataKitchen,
              duplicate: true);
        }
      }
    }
  }

  void clickPaymentType(int index) async {
    OrderHistoryData mSelectOrderHistoryData = mOrderHistoryData[index];

    debugPrint(
        "isPaymentTypeChanged ${mSelectOrderHistoryData.paymentGatewayName}");
    if(mSelectOrderHistoryData.paymentStatus != 'R') {
      if (mSelectOrderHistoryData.paymentGatewayName
          .toString()
          .trim()
          .isNotEmpty) {
        debugPrint(
            "isPaymentTypeChanged ${mSelectOrderHistoryData
                .isPaymentTypeChanged}");
        if (!(mSelectOrderHistoryData.isPaymentTypeChanged ?? false)) {
          debugPrint(
              "counterBalanceHistoryIDF ${mSelectOrderHistoryData
                  .counterBalanceHistoryIDF}");

          debugPrint(
              "sCounterBalanceHistoryIDF ${sCounterBalanceHistoryIDF.value}");
          if ((mSelectOrderHistoryData.counterBalanceHistoryIDF ?? '')
              .trim()
              .toString()
              .toUpperCase() ==
              sCounterBalanceHistoryIDF.value.toString().trim().toUpperCase()) {
            await AppAlert.showViewWithoutBlur(
                Get.context!, const BranchManagerScreen());
            bool isManager = false;
            ManagerCredentialsResponse? managerCredentialsResponse;
            if (Get.isRegistered<BranchManagerController>()) {
              BranchManagerController mBranchManagerController =
              Get.find<BranchManagerController>();
              isManager = mBranchManagerController.isSuccess.value;
              managerCredentialsResponse =
                  mBranchManagerController.mManagerCredentialsResponse.value;
              Get.delete<BranchManagerController>();
            }
            if (isManager) {
              isManager = false;
              await AppAlert.showViewWithoutBlur(
                  Get.context!,
                  PaymentTypeScreen(
                      mManagerCredentialsResponse: managerCredentialsResponse ??
                          ManagerCredentialsResponse(),
                      mSelectOrderHistoryData: mSelectOrderHistoryData));
              if (Get.isRegistered<PaymentTypeController>()) {
                PaymentTypeController mPaymentTypeController =
                Get.find<PaymentTypeController>();
                isManager = mPaymentTypeController.isSuccess.value;
                Get.delete<PaymentTypeController>();
              }
            }
            if (isManager) {
              refundOrderHistory(index,
                  search: mSelectOrderHistoryData.trackingOrderID ?? '');
            }
          }
        }
      }
    }
  }

  void onRefund(int index) async {
    OrderHistoryData mSelectOrderHistoryData = mOrderHistoryData[index];
    debugPrint(
        "isPaymentTypeChanged ${mSelectOrderHistoryData.paymentGatewayName}");
    if ((mSelectOrderHistoryData.counterBalanceHistoryIDF ?? '')
            .trim()
            .toString()
            .toUpperCase() ==
        sCounterBalanceHistoryIDF.value.toString().trim().toUpperCase()) {
      await AppAlert.showViewWithoutBlur(
          Get.context!, const BranchManagerScreen());
      bool isManager = false;
      ManagerCredentialsResponse? managerCredentialsResponse;
      if (Get.isRegistered<BranchManagerController>()) {
        BranchManagerController mBranchManagerController =
            Get.find<BranchManagerController>();
        isManager = mBranchManagerController.isSuccess.value;
        managerCredentialsResponse =
            mBranchManagerController.mManagerCredentialsResponse.value;
        Get.delete<BranchManagerController>();
      }
      if (isManager) {
        isManager = false;
        await AppAlert.showViewWithoutBlur(
            Get.context!,
            RefundPaymentTypeScreen(
                mManagerCredentialsResponse:
                    managerCredentialsResponse ?? ManagerCredentialsResponse(),
                mSelectOrderHistoryData: mSelectOrderHistoryData));
        if (Get.isRegistered<RefundPaymentTypeController>()) {
          RefundPaymentTypeController mRefundPaymentTypeController =
              Get.find<RefundPaymentTypeController>();
          isManager = mRefundPaymentTypeController.isSuccess.value;
          Get.delete<RefundPaymentTypeController>();
        }
      }
      if (isManager) {
        refundOrderHistory(index,
            search: mSelectOrderHistoryData.trackingOrderID ?? '');
      }
    }
  }

  ///refund and cancel order
  refundOrderHistory(
    int index, {
    String trackingOrderID = "",
    String search = "",
  }) async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();
      sCounterBalanceHistoryIDF.value = await SharedPrefs().getHistoryID();
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
              pageNumber: 1,
              searchValue: search,
              orderSource: "0",
              paymentStatus: null,
              fromDate: null,
              toDate: null,
              orderType: 0,
              trackingOrderID: trackingOrderID);
          WebResponseSuccess mWebResponseSuccess =
              await orderPlaceApi.postOrderHistory(mOrderHistoryRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            OrderHistoryResponse mOrderHistoryResponse =
                mWebResponseSuccess.data;
            if ((mOrderHistoryResponse.mOrderHistoryResponseData?.data ?? [])
                .isNotEmpty) {
              mOrderHistoryData[index] =
                  (mOrderHistoryResponse.mOrderHistoryResponseData?.data ?? [])
                      .first;
              mOrderHistoryData.refresh();
              if( (mOrderHistoryResponse.mOrderHistoryResponseData?.data ?? [])
                  .first.paymentStatus == 'S'){
                onPrint(index);
              }else  if( (mOrderHistoryResponse.mOrderHistoryResponseData?.data ?? [])
                  .first.paymentStatus == 'R'){
                onPrintRefund(index);
              }
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
