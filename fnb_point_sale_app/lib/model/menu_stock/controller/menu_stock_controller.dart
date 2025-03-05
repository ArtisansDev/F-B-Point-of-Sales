// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/download_data/jobs/download_product_menu_job.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/get_menu_stock/get_menu_stock_request.dart';
import 'package:fnb_point_sale_base/data/mode/get_menu_stock/get_menu_stock_response.dart';
import 'package:fnb_point_sale_base/data/mode/menu_stock/menu_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/product/product_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class MenuStockController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///"StockStatus": null, // nullable, null for all, 1 for stoke in data, 2 for stoke out data
  RxString sLoading = 'Loading...'.obs;
  RxString selectStockStatus = 'Stock Out'.obs;
  RxList<String> stockStatusList = <String>['Stock In', 'Stock Out'].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;


  ///search
  void onTextChange(value) {
    sLoading.value = 'Loading...';
    sLoading.refresh();
    onStockItem();
  }

  ///in stock -  out stock
  onStockInOutItem(GetMenuStockData mGetMenuStockData) async {
    final productApiImpl = locator.get<ProductApi>();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        List<UpdateStokeData> updateStokeData = [
          UpdateStokeData(
            categoryIDF: mGetMenuStockData.categoryData?.first.categoryIDF ?? '',
            menuItemIDF: mGetMenuStockData.menuItemIDP ?? '',
          )
        ];
        MenuRequest mMenuRequest = MenuRequest(
            restaurantIDF:
                (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .first
                        .restaurantIDP,
            branchIDF:
                (mConfigurationResponse
                                .configurationData?.branchData ??
                            [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.branchData ??
                            [])
                        .first
                        .branchIDP,
            isStockOut: !(mGetMenuStockData.isStockOut??false),
            updateStokeData: updateStokeData);
        debugPrint("mMenuRequest ${jsonEncode(mMenuRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await productApiImpl.postUpdateStockStatus(mMenuRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          await downloadProductMenuList((value) {});
          onStockItem();
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

  ///in stock -  out stock list
  RxList<GetMenuStockData> mGetMenuStockData = <GetMenuStockData>[].obs;

  ///api call
  onStockItem() async {
    final productApiImpl = locator.get<ProductApi>();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetMenuStockRequest mGetMenuStockRequest = GetMenuStockRequest(
            searchValue: searchController.value.text.isEmpty
                ? null
                : searchController.value.text,
            restaurantIDF:
                (mConfigurationResponse.configurationData?.restaurantData ?? [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .first
                        .restaurantIDP,
            branchIDF: (mConfigurationResponse.configurationData?.branchData ??
                        [])
                    .isEmpty
                ? ""
                : (mConfigurationResponse.configurationData?.branchData ?? [])
                    .first
                    .branchIDP,
            stockStatus: selectStockStatus.value == "Stock Out" ? "2" : "1");
        debugPrint("mGetMenuStockRequest ${jsonEncode(mGetMenuStockRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await productApiImpl.postGetStockData(mGetMenuStockRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetMenuStockResponse mGetMenuStockResponse = mWebResponseSuccess.data;
          mGetMenuStockData.clear();
          mGetMenuStockData.addAll(mGetMenuStockResponse.data ?? []);
          mGetMenuStockData.refresh();
          sLoading.value = '';
          sLoading.refresh();
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
