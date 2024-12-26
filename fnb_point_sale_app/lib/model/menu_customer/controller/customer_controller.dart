// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/customer/customer_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_request.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class CustomerController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rxn<GetAllCustomerData> mGetAllCustomerData = Rxn<GetAllCustomerData>();
  Rxn<List<GetAllCustomerList>> mGetAllCustomerList =
      Rxn<List<GetAllCustomerList>>();
  final customerLocalApi = locator.get<CustomerLocalApi>();

  void addCustomer() {}

  ///sync update
  onCustomerUpdate() {
    mDashboardScreenController.onUpdate(() async {
      await getAllCustomerList();
    });
  }

  getAllCustomerList() async {
    GetAllCustomerResponse mGetAllCustomerResponse =
        await customerLocalApi.getAllCustomerResponse() ??
            GetAllCustomerResponse();
    mGetAllCustomerData.value =
        mGetAllCustomerResponse.getAllCustomerData ?? GetAllCustomerData();

    mGetAllCustomerList.value = [];
    mGetAllCustomerList.value
        ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
    mGetAllCustomerList.refresh();

    if ((mGetAllCustomerList.value ?? []).isEmpty) {
      callGetAllCustomer();
    }
  }

  void callGetAllCustomer() async {
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
            final customerLocalApi = locator.get<CustomerLocalApi>();
            await customerLocalApi.save(mGetAllCustomerResponse);

            ///GetAllCustomerResponse
            mGetAllCustomerData.value =
                mGetAllCustomerResponse.getAllCustomerData ??
                    GetAllCustomerData();
            ///
            mGetAllCustomerList.value = [];
            mGetAllCustomerList.value
                ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
            mGetAllCustomerList.refresh();
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
