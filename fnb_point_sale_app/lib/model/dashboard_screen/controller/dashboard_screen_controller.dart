// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_app/model/menu_home/home_base_controller/home_base_controller.dart';
import 'package:fnb_point_sale_app/model/menu_sales/view/menu_sales_screen.dart';
import 'package:fnb_point_sale_app/model/menu_settings/view/settings_screen.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_screen.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/download_data/download_data_view_model.dart';
import 'package:fnb_point_sale_base/common/download_data/ui/download_data_menu_widget.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/customer/customer_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/button_bar/button_bar_model.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_request.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';

import '../../menu_customer/controller/customer_controller.dart';
import '../../menu_customer/view/customer_screen.dart';
import '../../menu_home/view/home_screen.dart';
import '../../menu_home/view/selected_order/controller/selected_order_controller.dart';
import '../../menu_sales/controller/menu_sales_controller.dart';
import '../../menu_settings/controller/settings_controller.dart';
import '../../menu_shift_details/controller/shift_details_controller.dart';
import '../../menu_shift_details/view/shift_details_screen.dart';
import '../../menu_table/controller/table_controller.dart';
import '../view/top_bar/model/tob_bar_model.dart';

class DashboardScreenController extends GetxController {
  RxString version = ''.obs;
  RxInt selectMenu = 0.obs;
  RxList<TobBarModel> mTobBarModel = <TobBarModel>[
    TobBarModel(
      name: 'ALL',
      value: '20',
    ),
    TobBarModel(name: 'OPEN', value: '0'),
    TobBarModel(name: 'OCCUPIED', value: '0'),
    // TobBarModel(name: 'RESERVED', value: '0'),
    TobBarModel(name: 'HOLD SALE', value: '0'),
  ].obs;
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();

  ///set Top Bar value
  RxInt topBarIndex = 0.obs;

  setTopBarValue(int index, int value) {
    if (index < 3) {
      topBarIndex.value = index;
      topBarIndex.refresh();
      if (Get.isRegistered<TableController>()) {
        if (onUpdateTable.value != null) {
          onUpdateTable.value!();
        }
      } else {
        selectMenu.value = 1;
        selectMenu.refresh();
      }
    }
  }

  ///set APP VERSION
  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  getView() {
    deleteController();
    switch (selectMenu.value) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TableScreen();
      case 2:
        return const MenuSalesScreen();
      case 3:
        return const SettingsScreen();
      case 4:
        return const CustomerScreen();
      case 5:
        return const ShiftDetailsScreen();
    }
  }

  deleteController() {
    switch (selectMenu.value) {
      case 0:

        ///home
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        if (Get.isRegistered<CustomerController>()) {
          Get.find<CustomerController>().onClose();
          Get.delete<CustomerController>();
        }
        break;
      case 1:

        ///MenuTable
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<HomeBaseController>()) {
          Get.find<HomeBaseController>().onClose();
          Get.delete<HomeBaseController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<CustomerController>()) {
          Get.find<CustomerController>().onClose();
          Get.delete<CustomerController>();
        }
        return;
      case 2:

        ///MenuSales
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<HomeBaseController>()) {
          Get.find<HomeBaseController>().onClose();
          Get.delete<HomeBaseController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        if (Get.isRegistered<CustomerController>()) {
          Get.find<CustomerController>().onClose();
          Get.delete<CustomerController>();
        }
        break;
      case 3:

        ///MenuSettings
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        if (Get.isRegistered<HomeBaseController>()) {
          Get.find<HomeBaseController>().onClose();
          Get.delete<HomeBaseController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        if (Get.isRegistered<CustomerController>()) {
          Get.find<CustomerController>().onClose();
          Get.delete<CustomerController>();
        }
        break;
      case 4:

        ///CustomerController
        if (Get.isRegistered<HomeBaseController>()) {
          Get.find<HomeBaseController>().onClose();
          Get.delete<HomeBaseController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        if (Get.isRegistered<ShiftDetailsController>()) {
          Get.find<ShiftDetailsController>().onClose();
          Get.delete<ShiftDetailsController>();
        }
        break;
      case 5:

        ///ShiftDetails
        if (Get.isRegistered<HomeBaseController>()) {
          Get.find<HomeBaseController>().onClose();
          Get.delete<HomeBaseController>();
        }
        if (Get.isRegistered<MenuSalesController>()) {
          Get.find<MenuSalesController>().onClose();
          Get.delete<MenuSalesController>();
        }
        if (Get.isRegistered<SettingsMenuController>()) {
          Get.find<SettingsMenuController>().onClose();
          Get.delete<SettingsMenuController>();
        }
        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().onClose();
          Get.delete<TableController>();
        }
        if (Get.isRegistered<CustomerController>()) {
          Get.find<CustomerController>().onClose();
          Get.delete<CustomerController>();
        }
        break;
    }
  }

  ///button bar
  RxList<ButtonBarModel> mButtonBarModel = [
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.newOrderButton,
        buttonBarName: 'New Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.holdOrderButton,
        buttonBarName: 'Hold Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.cancelOrderButton,
        buttonBarName: 'Cancel Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.sendOrderButton,
        buttonBarName: 'Send Order'),
    ButtonBarModel(
        imageAssets: ImageAssetsConstants.reservationButton,
        buttonBarName: 'Reservation'),
  ].obs;

  ///getCurrencyData
  CurrencyData mCurrencyData = CurrencyData();
  var configurationLocalApi = locator.get<ConfigurationLocalApi>();

  getCurrencyData() async {
    mCurrencyData = ((await configurationLocalApi.getConfigurationResponse())
                ?.configurationData
                ?.currencyData ??
            [])
        .first;
    getTexList();
  }

  RxList<TaxData> taxData = <TaxData>[].obs;

  getTexList() async {
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    taxData.clear();
    taxData.addAll(mConfigurationResponse.configurationData?.taxData ?? []);
  }

  ///onSync
  fastTimeSync() {
    getCurrencyData();
    if (WebConstants.isFastTimeLogin) {
      WebConstants.isFastTimeLogin = false;
      unawaited(DownloadDataViewModel().startDownloading((value) {
        sDownloadText.value = value;
        sDownloadText.refresh();
      }, () {
        sDownloadText.value = '';
        sDownloadText.refresh();
        if (onUpdateDate.value != null) {
          onUpdateDate.value!();
        }
        if (updateHomeMenu.value != null) {
          updateHomeMenu.value!();
        }
        if (updateTopBar.value != null) {
          updateTopBar.value!();
        }
      }, (value) {
        sDownloadText.value = '';
        sDownloadText.refresh();
      }, DownloadDataMenu.values, onlyLatestChange: false));
    }
  }

  RxString sDownloadText = ''.obs;

  onSync() async {
    if (Get.isRegistered<SelectedOrderController>()) {
      SelectedOrderController mSelectedOrderController =
          Get.find<SelectedOrderController>();
      if ((mSelectedOrderController.mOrderPlace.value?.cartItem ?? [])
          .isNotEmpty) {
        AppAlert.showSnackBar(Get.context!,
            'Ensure the cart is cleared before initiating the sync process.');
        return;
      }
    }

    if (getInValue(mTobBarModel[2].value) > 0) {
      AppAlert.showSnackBar(Get.context!,
          'Ensure the cart is cleared before initiating the sync process.');
      return;
    } else if (getInValue(mTobBarModel[3].value) > 0) {
      AppAlert.showSnackBar(Get.context!,
          'Ensure the hold sale is cleared before initiating the sync process.');
      return;
    } else {
      await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => DownloadDataMenuWidget(
                onError: (value) {
                  sDownloadText.value = '';
                  sDownloadText.refresh();
                },
                updateMessage: (value) {
                  sDownloadText.value = value;
                  sDownloadText.refresh();
                },
                onCompleted: () {
                  sDownloadText.value = '';
                  sDownloadText.refresh();
                  getTexList();
                  if (onUpdateDate.value != null) {
                    onUpdateDate.value!();
                  }
                  if (updateHomeMenu.value != null) {
                    updateHomeMenu.value!();
                  }
                  if (updateTopBar.value != null) {
                    updateTopBar.value!();
                  }
                },
                onCancel: () {
                  Get.back();
                },
              ));
    }
  }

  Rxn<Function> onUpdateDate = Rxn<Function>();
  Rxn<Function> onUpdateHold = Rxn<Function>();

  onUpdate(Function update, {Function? updateHoldSale}) {
    onUpdateDate.value = update;
    if (updateHoldSale != null) {
      onUpdateHold.value = updateHoldSale;
    }
  }

  Rxn<Function> updateHomeMenu = Rxn<Function>();

  onHomeUpdate({Function? updateHome}) {
    if (updateHome != null) {
      updateHomeMenu.value = updateHome;
    }
  }

  Rxn<Function> updateTopBar = Rxn<Function>();

  onTopBarUpdate({Function? fUpdateTopBar}) {
    if (fUpdateTopBar != null) {
      updateTopBar.value = fUpdateTopBar;
    }
  }

  onUpdateHoldSale() async {
    var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
    HoldSaleModel mHoldSaleModel =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();

    mTobBarModel[3].value =
        (mHoldSaleModel.mOrderPlace ?? []).length.toString();
    mTobBarModel.refresh();
  }

  Rxn<Function> onUpdateTable = Rxn<Function>();

  onUpdateViewTable(Function update) {
    onUpdateTable.value = update;
  }

  ///customer
  final customerLocalApi = locator.get<CustomerLocalApi>();
  Rxn<GetAllCustomerData> mGetAllCustomerData = Rxn<GetAllCustomerData>();
  Rxn<List<GetAllCustomerList>> mAllCustomerList =
      Rxn<List<GetAllCustomerList>>();

  getAllCustomerList() async {
    GetAllCustomerResponse mGetAllCustomerResponse =
        await customerLocalApi.getAllCustomerResponse() ??
            GetAllCustomerResponse();
    mGetAllCustomerData.value =
        mGetAllCustomerResponse.getAllCustomerData ?? GetAllCustomerData();

    mAllCustomerList.value = [];
    mAllCustomerList.value
        ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
    mAllCustomerList.refresh();

    if ((mAllCustomerList.value ?? []).isEmpty) {
      await callGetAllCustomer();
    }
  }

  callGetAllCustomer() async {
    try {
      ///api product call
      final customerApi = locator.get<CustomerApi>();
      var configurationLocalApi = locator.get<ConfigurationLocalApi>();
      ConfigurationResponse mConfigurationResponse =
          await configurationLocalApi.getConfigurationResponse() ??
              ConfigurationResponse();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          GetAllCustomerRequest mGetAllCustomerRequest = GetAllCustomerRequest(
              pageNumber: 1,
              rowsPerPage: 0,
              restaurantIDF: (mConfigurationResponse
                              .configurationData?.restaurantData ??
                          [])
                      .isEmpty
                  ? ""
                  : (mConfigurationResponse.configurationData?.restaurantData ??
                          [])
                      .first
                      .restaurantIDP);
          WebResponseSuccess mWebResponseSuccess =
              await customerApi.postGetAllCustomer(mGetAllCustomerRequest);

          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            GetAllCustomerResponse mGetAllCustomerResponse =
                mWebResponseSuccess.data;
            await customerLocalApi.save(mGetAllCustomerResponse);

            ///GetAllCustomerResponse
            mGetAllCustomerData.value =
                mGetAllCustomerResponse.getAllCustomerData ??
                    GetAllCustomerData();
            mAllCustomerList.value = [];
            mAllCustomerList.value
                ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
            mAllCustomerList.refresh();
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
      MyLogUtils.logDebug('downloadTableList failed with exception $e');
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }
}
