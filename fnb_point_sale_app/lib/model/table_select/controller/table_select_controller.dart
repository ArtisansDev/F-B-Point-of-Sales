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
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class TableSelectController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> enterNameController = TextEditingController().obs;
  Rx<TextEditingController> sPhoneNumberController =
      TextEditingController().obs;
  RxString phoneCode = '60'.obs;
  Rx<TextEditingController> sTableNoController = TextEditingController().obs;
  Rx<TextEditingController> scheduleController = TextEditingController().obs;
  Rx<TextEditingController> notesController = TextEditingController().obs;
  RxBool isDineIn = true.obs;
  RxString orderNumber = '1234567890'.obs;
  RxBool isCreateOrder = false.obs;

  TableSelectController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    isCreateOrder.value = false;
    orderNumber.value = getRandomNumber();
  }

  void onCreateOrder() {
    isCreateOrder.value = true;
    mDashboardScreenController.value?.mOrderPlace.value =
        OrderPlace(cartItem: []);
    mDashboardScreenController.value?.mOrderPlace.value?.seatIDP =
        sTablesData.value?.seatIDP ?? '--';
    mDashboardScreenController.value?.mOrderPlace.value?.tableNo =
        sTableNumber.value ?? '--';
    mDashboardScreenController.value?.mOrderPlace.value?.userName =
        enterNameController.value.text;
    mDashboardScreenController.value?.mOrderPlace.value?.userPhone =
        sPhoneNumberController.value.text;
    mDashboardScreenController.value?.mOrderPlace.value?.sOrderNo =
        orderNumber.value;

    Get.back();
  }

  Rxn<String> sTableNumber = Rxn<String>();
  Rxn<GetAllTablesResponseData> sTablesData = Rxn<GetAllTablesResponseData>();

  void setTableNumber(GetAllTablesResponseData? mGetAllTablesResponseData) {
    sTablesData.value = mGetAllTablesResponseData ?? GetAllTablesResponseData();
    sTableNumber.value = mGetAllTablesResponseData?.seatNumber ?? '';
    if (sTableNumber.value != null) {
      sTableNoController.value.text = sTableNumber.value ?? '';
      sTableNoController.refresh();
    }
  }


  ///Customer
  final customerLocalApi = locator.get<CustomerLocalApi>();
  Rxn<GetAllCustomerData> mGetAllCustomerData = Rxn<GetAllCustomerData>();
  Rxn<List<GetAllCustomerList>> mGetAllCustomerList =
  Rxn<List<GetAllCustomerList>>();
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
    // print("###### ${(mGetAllCustomerList.value ?? []).length}");
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
