// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_request.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_place/process_multiple_orders_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/table_status_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/utils/create_order_place_request.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../../table_select/controller/table_select_controller.dart';
import '../../table_select/view/table_select_screen.dart';
import '../view/table_view/item_summary/controller/table_item_summary_controller.dart';
import '../view/table_view/item_summary/view/table_item_summary_order_screen.dart';
import '../view/table_view/table_summary/controller/table_summary_controller.dart';

class TableController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString search = "".obs;

  TopBarController mTopBarController = Get.find<TopBarController>();

  ///table click
  void onTableSelectClick(GetAllTablesResponseData mGetAllTablesResponseData,
      TablesByTableStatusData mTablesByTableStatusData) async {
    // OrderPlace mOrderPlace =
    //     getOrderPlace(mGetAllTablesResponseData.seatIDP ?? '');
    // if ((mOrderPlace.cartItem ?? []).isNotEmpty) {
    if ((mTablesByTableStatusData.seatIDP ?? '').isNotEmpty) {
      ///show details
      showView(mTablesByTableStatusData);
      // await AppAlert.showViewWithoutBlur(
      //     Get.context!,
      //     Row(
      //       children: [
      //         const Expanded(flex: 7, child: SizedBox()),
      //         Expanded(flex: 3, child: TableSummaryOrderScreen(mOrderPlace))
      //       ],
      //     ),
      //     barrierDismissible: true);
      if (Get.isRegistered<TableSummaryController>()) {
        Get.delete<TableSummaryController>();
      }
    } else {
      bool value = (!(mGetAllTablesResponseData.isDeleted ?? false) &&
          (mGetAllTablesResponseData.isActive ?? false));
      if (value) {
        bool isCreateOrder = false;
        await AppAlert.showViewWithoutBlur(Get.context!,
            TableSelectScreen(tableNumber: mGetAllTablesResponseData),
            barrierDismissible: true);
        if (Get.isRegistered<TableSelectController>()) {
          isCreateOrder = Get.find<TableSelectController>().isCreateOrder.value;
          Get.delete<TableSelectController>();
        }
        if (isCreateOrder) {
          mDashboardScreenController.selectMenu.value = 0;
          mDashboardScreenController.selectMenu.refresh();
        }
      }
    }
  }

  ///order place
  // Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
  // var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

  // allOrderPlace() async {
  //   mPlaceOrderSaleModel.value =
  //       await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
  //           PlaceOrderSaleModel();
  // }
  //
  // OrderPlace getOrderPlace(String sSeatIDP) {
  //   OrderPlace mOrderPlace = OrderPlace();
  //   if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? []).isEmpty) {
  //     return mOrderPlace;
  //   }
  //   int? value = mPlaceOrderSaleModel.value?.mOrderPlace?.indexWhere(
  //     (element) => element.seatIDP.toString() == sSeatIDP.toString(),
  //   );
  //   if ((value ?? -1) == -1) {
  //     return mOrderPlace;
  //   } else {
  //     mOrderPlace =
  //         mPlaceOrderSaleModel.value?.mOrderPlace?[value ?? -1] ?? OrderPlace();
  //     return mOrderPlace;
  //   }
  // }

  TablesByTableStatusData getTablesByTableStatusData(String sSeatIDP) {
    TablesByTableStatusData mTablesByTableStatusData =
        TablesByTableStatusData();
    if ((mTopBarController.mGetAllTablesStatus.value?.data ?? []).isEmpty) {
      return mTablesByTableStatusData;
    }
    int? value = mTopBarController.mGetAllTablesStatus.value?.data?.indexWhere(
      (element) => element.seatIDP.toString() == sSeatIDP.toString(),
    );
    if ((value ?? -1) == -1) {
      return mTablesByTableStatusData;
    } else {
      mTablesByTableStatusData =
          mTopBarController.mGetAllTablesStatus.value?.data?[value ?? -1] ??
              TablesByTableStatusData();
      return mTablesByTableStatusData;
    }
  }

  ///all table
  List<GetAllTablesResponseData> selectGetAllTablesResponseData = [];
  List<GetAllTablesResponseData> selectAllSearch = [];
  RxMap<String, List<GetAllTablesResponseData>> groupedByDepartment =
      <String, List<GetAllTablesResponseData>>{}.obs;

  RxString valueLoading = 'Loading..'.obs;

  onUpdateViewTable() async {
    valueLoading.value = 'Loading..';
    // await allOrderPlace();
    mDashboardScreenController.onUpdateViewTable(() {
      setGroupTable();
    });
    setGroupTable();
    valueLoading.refresh();
  }

  setGroupTable() {
    ///
    List<TablesByTableStatusData> mTablesByTableStatusData = [];
    mTablesByTableStatusData.clear();
    mTablesByTableStatusData.addAll(
        (mTopBarController.mGetAllTablesStatus.value?.data ?? []).toList());

    ///offline
    List<GetAllTablesResponseData> selectTablesData = [];
    selectGetAllTablesResponseData.clear();
    selectAllSearch.clear();
    selectGetAllTablesResponseData
        .addAll(mTopBarController.mGetAllTablesList.toList());
    selectAllSearch.addAll(mTopBarController.mGetAllTablesList.toList());

    ///
    valueLoading.value = 'Loading..';
    valueLoading.refresh();
    groupedByDepartment.clear();
    groupedByDepartment.refresh();

    ///offline
    // if (mDashboardScreenController.topBarIndex.value == 1) {
    //   for (OrderPlace mOrderPlace
    //       in mPlaceOrderSaleModel.value?.mOrderPlace ?? []) {
    //     selectTablesData.clear();
    //     selectTablesData.addAll(selectGetAllTablesResponseData.toList());
    //     selectGetAllTablesResponseData.clear();
    //     selectGetAllTablesResponseData.addAll(selectTablesData.where(
    //       (element) {
    //         if (mOrderPlace.seatIDP.toString() != element.seatIDP.toString()) {
    //           return true;
    //         } else {
    //           return false;
    //         }
    //       },
    //     ).toList());
    //   }
    // } else if (mDashboardScreenController.topBarIndex.value == 2) {
    //   for (OrderPlace mOrderPlace
    //       in mPlaceOrderSaleModel.value?.mOrderPlace ?? []) {
    //     selectTablesData.addAll(selectGetAllTablesResponseData.where(
    //       (element) {
    //         if (mOrderPlace.seatIDP.toString() == element.seatIDP.toString()) {
    //           return true;
    //         } else {
    //           return false;
    //         }
    //       },
    //     ).toList());
    //   }
    //   selectGetAllTablesResponseData.clear();
    //   selectGetAllTablesResponseData.addAll(selectTablesData.toList());
    // }

    ///online
    if (mDashboardScreenController.topBarIndex.value == 1) {
      for (TablesByTableStatusData mOrderPlace
          in mTablesByTableStatusData ?? []) {
        selectTablesData.clear();
        selectTablesData.addAll(selectGetAllTablesResponseData.toList());
        selectGetAllTablesResponseData.clear();
        selectGetAllTablesResponseData.addAll(selectTablesData.where(
          (element) {
            if (mOrderPlace.seatIDP.toString() != element.seatIDP.toString()) {
              return true;
            } else {
              return false;
            }
          },
        ).toList());
      }
    } else if (mDashboardScreenController.topBarIndex.value == 2) {
      for (TablesByTableStatusData mOrderPlace
          in mTablesByTableStatusData ?? []) {
        selectTablesData.addAll(selectGetAllTablesResponseData.where(
          (element) {
            if (mOrderPlace.seatIDP.toString() == element.seatIDP.toString()) {
              return true;
            } else {
              return false;
            }
          },
        ).toList());
      }
      selectGetAllTablesResponseData.clear();
      selectGetAllTablesResponseData.addAll(selectTablesData.toList());
    }
    groupTable();
  }

  groupTable() {
    /// Create a map for grouping
    for (var mTable in selectGetAllTablesResponseData) {
      groupedByDepartment.putIfAbsent(mTable.locationType ?? '', () => []);
      groupedByDepartment[mTable.locationType]!.add(mTable);
    }
    if (groupedByDepartment.isEmpty) {
      valueLoading.value = 'No Table found';
    } else {
      valueLoading.value = '';
    }
    valueLoading.refresh();
    groupedByDepartment.refresh();
  }

  ///clear table
  void onClear(TablesByTableStatusData mTablesByTableStatusData) {
    AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Clear Table!',
        'Are you sure you want to clear this table?', () {
      Get.back();
      callUpdateTableStatus(mTablesByTableStatusData);
    }, rightText: 'Yes');
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
          onRefresh();
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

  ///show details
  void showView(TablesByTableStatusData mOrderPlace) async {
    callOrderHistory(
        trackingOrderID: mOrderPlace.occupiedTrackingOrderID ?? '');
  }

  RxList<OrderHistoryData> mOrderHistoryData = <OrderHistoryData>[].obs;

  callOrderHistory({
    String trackingOrderID = "",
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
              rowsPerPage: 1,
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
              searchValue: null,
              orderSource: null,
              paymentStatus: null,
              fromDate: null,
              toDate: null,
              orderType: null,
              trackingOrderID: trackingOrderID);
          WebResponseSuccess mWebResponseSuccess =
              await orderPlaceApi.postOrderHistory(mOrderHistoryRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            OrderHistoryResponse mOrderHistoryResponse =
                mWebResponseSuccess.data;

            if ((mOrderHistoryResponse.mOrderHistoryResponseData?.totalPage ??
                    0) >
                0) {
              mOrderHistoryData.clear();
              mOrderHistoryData.addAll(
                  mOrderHistoryResponse.mOrderHistoryResponseData?.data ?? []);
              mOrderHistoryData.refresh();
              if (mOrderHistoryData.isNotEmpty) {
                onViewDetails(0);
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

  void onViewDetails(int index) async {
    OrderHistoryData mOrderData = mOrderHistoryData[index];
    await AppAlert.showViewWithoutBlur(
        Get.context!,
        Row(
          children: [
            const Expanded(flex: 7, child: SizedBox()),
            Expanded(
                flex: 3, child: TableItemSummaryOrderScreen(mOrderData, index))
          ],
        ),
        barrierDismissible: true);
    if (Get.isRegistered<TableItemSummaryController>()) {
      Get.delete<TableItemSummaryController>();
    }
  }

  ///print kot
  void onPrintKot(int index) async {
    OrderHistoryData mOrderData = mOrderHistoryData[index];
    final myPrinterService = locator.get<MyPrinterService>();
    await myPrinterService.salePaymentKot(mOrderData);

    await myPrinterService.salePaymentKot(mOrderData, duplicate: true);
  }

  ///search table
  void searchTable() {
    if (search.value.isEmpty) {
      setGroupTable();
    } else {
      selectGetAllTablesResponseData.clear();
      groupedByDepartment.clear();
      selectGetAllTablesResponseData.addAll(selectAllSearch.where(
        (element) {
          if (element.seatNumber
              .toString()
              .toLowerCase()
              .contains(search.value.toLowerCase())) {
            return true;
          } else {
            return false;
          }
        },
      ).toList());
      groupTable();
    }
  }

  /// orderPayment
  void orderPayment(
      GetAllPaymentTypeData mGetAllPaymentTypeData,
      OrderHistoryData mOrderHistory,
      GetAllCustomerList? mGetAllCustomerList) async {
    ///
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
    await mTopBarController.allOrderPlace();

    ///clear table
    TablesByTableStatusData mTablesByTableStatusData = TablesByTableStatusData(
      occupiedOrderID: mOrderDetailList.trackingOrderID ?? '',
      seatIDP: mOrderDetailList.seatIDF ?? '',
    );
    await callUpdateTableStatus(mTablesByTableStatusData);
    // await callOrderHistory();
    await onRefresh();
    Get.back();
  }

  ///Cancel Payment
  orderCancelPayment(
    OrderHistoryData mOrderHistory,
  ) async {
    Get.back();

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
    await mTopBarController.allOrderPlace();

    ///clear table
    TablesByTableStatusData mTablesByTableStatusData = TablesByTableStatusData(
      occupiedOrderID: mOrderDetailList.trackingOrderID ?? '',
      seatIDP: mOrderDetailList.seatIDF ?? '',
    );
    await callUpdateTableStatus(mTablesByTableStatusData);

    /// await callOrderHistory();
    await onRefresh();
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
            // if (isPayment) {
            //   ///offline save
            //   var mOfflinePlaceOrderSaleLocalApi =
            //   locator.get<OfflinePlaceOrderSaleLocalApi>();
            //   ProcessMultipleOrdersRequest mProcessMultipleOrders =
            //       await mOfflinePlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            //           ProcessMultipleOrdersRequest();
            //   if ((mProcessMultipleOrders.orderDetailList ?? []).isEmpty) {
            //     await mOfflinePlaceOrderSaleLocalApi
            //         .save(mProcessMultipleOrdersRequest);
            //   } else {
            //     if ((mProcessMultipleOrdersRequest.orderDetailList ?? [])
            //         .isNotEmpty) {
            //       await mOfflinePlaceOrderSaleLocalApi.getPlaceOrderAdd(
            //           (mProcessMultipleOrdersRequest.orderDetailList ?? [])
            //               .first);
            //     }
            //   }
            //
            //   ///remove
            //   var mPlaceOrderSaleLocalApi =
            //   locator.get<PlaceOrderSaleLocalApi>();
            //   await mPlaceOrderSaleLocalApi
            //       .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
            // }
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

  ///print
  printOrderPayment(
    OrderDetailList mOrderDetailList,
    OrderHistoryData mOrderHistory,
  ) async {
    final myPrinterService = locator.get<MyPrinterService>();
    await myPrinterService.saleAfterPayment(mOrderDetailList, mOrderHistory);
  }

  onRefresh() async {
    await mTopBarController.callGetAllTableStatus();
    await onUpdateViewTable();
  }
}
