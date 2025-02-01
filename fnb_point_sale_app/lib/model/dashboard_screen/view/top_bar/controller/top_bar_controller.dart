// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/common_view/logout_expired.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/database/table_list/table_list_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_request.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_login_status/update_login_status_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/login/login_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/types/test_printing.dart';
import 'package:fnb_point_sale_base/printer/widgets/printer_configuration_widget.dart';
import 'package:fnb_point_sale_base/serialportdevices/widgets/serial_port_device_config_widget.dart';
import 'package:fnb_point_sale_base/utils/get_device_details.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../../hold_sales/controller/hold_sales_controller.dart';
import '../../../../hold_sales/view/hold_sales_screen.dart';
import '../../../../menu_home/view/selected_order/controller/selected_order_controller.dart';
import '../../../../profile/controller/profile_controller.dart';
import '../../../../profile/view/profile_screen.dart';
import '../../../controller/dashboard_screen_controller.dart';

class TopBarController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///top bar Menu select
  void onClickTopBarMenu(int index) async {
    // if (index == 3) {
    //   ///Reservation Table
    //   await AppAlert.showView(
    //       Get.context!, const ReservationTableSelectScreen(),
    //       barrierDismissible: true);
    //   if (Get.isRegistered<ReservationTableSelectController>()) {
    //     Get.delete<ReservationTableSelectController>();
    //   }
    // } else
    if (index == 3) {
      /// hold sale
      await AppAlert.showView(Get.context!, const HoldSalesScreen(),
          barrierDismissible: true);

      if (Get.isRegistered<HoldSalesController>()) {
        Get.delete<HoldSalesController>();
      }

      if (mDashboardScreenController.selectMenu.value != 0 &&
          mDashboardScreenController.mOrderPlace.value != null) {
        mDashboardScreenController.selectMenu.value = 0;
        mDashboardScreenController.selectMenu.refresh();
      } else if (mDashboardScreenController.mOrderPlace.value != null) {
        if (Get.isRegistered<SelectedOrderController>()) {
          SelectedOrderController mSelectedOrderController =
              Get.find<SelectedOrderController>();
          mSelectedOrderController.onOrderPlaceAnotherPage();
        }
      }
      if (mDashboardScreenController.onUpdateHold.value != null) {
        mDashboardScreenController.onUpdateHold.value!();
      }
    } else {
      mDashboardScreenController.setTopBarValue(index, 0);
    }
  }

  void onSelectedProfileMenu(int value) async {
    switch (value) {
      case 0:

        ///profile
        await AppAlert.showView(Get.context!, const ProfileScreen());
        if (Get.isRegistered<ProfileController>()) {
          Get.delete<ProfileController>();
        }
        break;
      case 1:

        ///mDashboardScreenController.selectMenu.value = 5;
        AppAlert.showCustomDialogYesNoLogout(
            Get.context!, 'Logout!', 'Do you want to log out?', () async {
          mPlaceOrderSaleModel.value =
              await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
                  PlaceOrderSaleModel();
          if (getInValue(mDashboardScreenController.mTobBarModel[3].value) >
              0) {
            AppAlert.showCustomDialogOk(Get.context!, 'Alert',
                'Ensure the hold sale is cleared before initiating the Logout.');
            return;
          } else if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? []).isEmpty) {
            updateLoginStatusApiCall(true);
          } else {
            AppAlert.showCustomDialogOk(Get.context!, 'Alert',
                'Ensure the cart is cleared before initiating the Logout.');
          }
        });
        break;
      case 2:
        AppAlert.showCustomDialogYesNoLogout(
            Get.context!,
            'Logout & Clear Configuration!',
            'Do you want to Logout & Clear Configuration?', () async {
          mPlaceOrderSaleModel.value =
              await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
                  PlaceOrderSaleModel();
          if (getInValue(mDashboardScreenController.mTobBarModel[3].value) >
              0) {
            AppAlert.showCustomDialogOk(Get.context!, 'Alert',
                'Ensure the hold sale is cleared before initiating the Logout & Clear Configuration.');
            return;
          } else if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? []).isEmpty) {
            updateLoginStatusApiCall(false);
          } else {
            AppAlert.showCustomDialogOk(Get.context!, 'Alert',
                'Ensure the cart is cleared before initiating the Logout & Clear Configuration');
          }
        });
        break;
      case 3:
        exit(0);
        break;
      case 4:
        printPdf();
        break;
      case 5:
        _searchPrinterDialog();
        break;
      case 6:
        _searchSerialPortDevicesDialog();
        break;
    }
  }

  Future<void> _searchPrinterDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) => const PrinterConfigurationWidget(),
    );
  }

  Future<void> _searchSerialPortDevicesDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) => const SerialPortDeviceConfigWidget(),
    );
  }

  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  Rx<ConfigurationResponse> mConfigurationResponse =
      ConfigurationResponse().obs;

  ///sync update
  onHomeUpdate() async {
    await allOrderPlace();
    mDashboardScreenController.onTopBarUpdate(fUpdateTopBar: () async {
      await updateDetails();
      await loadAllTables();
    });

    await updateDetails();
  }

  updateDetails() async {
    mConfigurationResponse.value =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    mConfigurationResponse.refresh();
  }

  ///OrderPlace
  Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
  var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

  allOrderPlace() async {
    callGetAllTableStatus();
  }

  ///all table
  RxList<GetAllTablesResponseData> mGetAllTablesList =
      <GetAllTablesResponseData>[].obs;

  loadAllTables() async {
    var mTableListLocalApi = locator.get<TableListLocalApi>();
    GetAllTablesResponse mGetAllTablesResponse =
        await mTableListLocalApi.getTablesListResponse() ??
            GetAllTablesResponse();
    mGetAllTablesList.clear();
    mGetAllTablesList.addAll(mGetAllTablesResponse.data ?? []);
    mGetAllTablesList.refresh();

    ///groupTable
    groupTable();

    ///show table count
    showTableCount();
  }

  showTableCount() {
    String totalTable = (mGetAllTablesList.length ?? 0).toString();
    int occupiedTable = 0;
    String openTable = totalTable;
    String value = jsonEncode(mGetAllTablesList);
    for (OrderPlace totalOrder
        in (mPlaceOrderSaleModel.value ?? PlaceOrderSaleModel()).mOrderPlace ??
            []) {
      if (value.contains(totalOrder.tableNo.toString())) {
        occupiedTable = occupiedTable + 1;
      }
    }

    mDashboardScreenController.mTobBarModel[0].value = totalTable;
    mDashboardScreenController.mTobBarModel[1].value =
        (int.parse(openTable) - occupiedTable).toString();
    mDashboardScreenController.mTobBarModel[2].value = occupiedTable.toString();
    mDashboardScreenController.mTobBarModel.refresh();
  }

  RxMap<String, List<GetAllTablesResponseData>> groupedByDepartment =
      <String, List<GetAllTablesResponseData>>{}.obs;

  groupTable() {
    /// Create a map for grouping
    for (var mTable in mGetAllTablesList) {
      groupedByDepartment.putIfAbsent(mTable.locationType ?? '', () => []);
      groupedByDepartment[mTable.locationType]!.add(mTable);
    }
    groupedByDepartment.refresh();
    // debugPrint(groupedByDepartment as String?);
  }

  Rxn<GetAllTablesByTableStatusResponse> mGetAllTablesStatus =
      Rxn<GetAllTablesByTableStatusResponse>();

  ///get All TableStatus
  callGetAllTableStatus() async {
    try {
      var configurationLocalApi = locator.get<ConfigurationLocalApi>();
      ConfigurationResponse mConfigurationResponse =
          await configurationLocalApi.getConfigurationResponse() ??
              ConfigurationResponse();

      final orderPlaceApi = locator.get<OrderPlaceApi>();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          GetAllTablesByTableStatusRequest mGetAllTablesByTableStatusRequest =
              GetAllTablesByTableStatusRequest(
                  tableStatus: 'O',
                  restaurantIDF: (mConfigurationResponse
                                  .configurationData?.restaurantData ??
                              [])
                          .isEmpty
                      ? ""
                      : (mConfigurationResponse
                                  .configurationData?.restaurantData ??
                              [])
                          .first
                          .restaurantIDP,
                  branchIDF: (mConfigurationResponse
                                  .configurationData?.branchData ??
                              [])
                          .isEmpty
                      ? ""
                      : (mConfigurationResponse.configurationData?.branchData ??
                              [])
                          .first
                          .branchIDP);

          WebResponseSuccess mWebResponseSuccess = await orderPlaceApi
              .postGetAllTablesByTableStatus(mGetAllTablesByTableStatusRequest);

          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            mGetAllTablesStatus.value = mWebResponseSuccess.data;
            mGetAllTablesStatus.refresh();
            String totalTable = (mGetAllTablesList.length ?? 0).toString();
            mDashboardScreenController.mTobBarModel[0].value = totalTable;
            mDashboardScreenController.mTobBarModel[1].value =
                (int.parse(totalTable) -
                        (mGetAllTablesStatus.value?.data?.length ?? 0))
                    .toString();
            mDashboardScreenController.mTobBarModel[2].value =
                (mGetAllTablesStatus.value?.data?.length ?? 0).toString();
            mDashboardScreenController.mTobBarModel.refresh();
          } else {
            mGetAllTablesStatus.value = null;
            mGetAllTablesStatus.refresh();
            String totalTable = (mGetAllTablesList.length ?? 0).toString();
            mDashboardScreenController.mTobBarModel[0].value = totalTable;
            mDashboardScreenController.mTobBarModel[1].value = totalTable;
            mDashboardScreenController.mTobBarModel[2].value = 0.toString();
            mDashboardScreenController.mTobBarModel.refresh();
            // mGetAllTablesStatus.value = null;
            // mGetAllTablesStatus.refresh();
            // offLineCount();
          }
        } else {
          // offLineCount();
        }
      });
    } catch (e) {
      // offLineCount();
    }
  }

  offLineCount() async {
    mPlaceOrderSaleModel.value =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
    showTableCount();
  }

  void updateLoginStatusApiCall(bool isLogout) async {
    DeviceInfo mDeviceInfo = await getDeviceDetails();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        final localApi = locator.get<LoginApi>();
        UpdateLoginStatusRequest mUpdateLoginStatusRequest =
            UpdateLoginStatusRequest(
                deviceInfo: mDeviceInfo,
                userIDF: await SharedPrefs().getUserId(),
                counterIDF: (mConfigurationResponse
                                .value.configurationData?.counterData ??
                            [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .value.configurationData?.counterData ??
                            [])
                        .first
                        .counterIDP,
                isLoggedIn: false);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdatePOSLoginStatus(mUpdateLoginStatusRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          if (isLogout) {
            logout();
          } else {
            clearConfiguration();
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
  }
}
