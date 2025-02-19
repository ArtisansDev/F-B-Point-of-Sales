// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/customer/customer_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_request.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/save/customer_save_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import '../../../common_view/customer_drop_down.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../menu_customer/customer_utils/add_customer.dart';

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

  void onCreateOrder() async {
    if (mSelectCustomer.value != null) {
      if (mSelectCustomer.value?.name.toString() == '_new_') {
        AddCustomer mAddCustomer = AddCustomer(
            name: enterNameController.value.text,
            phoneCode: phoneCode.value,
            phone: sPhoneNumberController.value.text,
            onSelectCustomer: (GetAllCustomerList mGetAllCustomerList) {
              mSelectCustomer.value = mGetAllCustomerList;
              createOrder();
            });
        await mAddCustomer.onSubmit();
      } else {
        createOrder();
      }
    } else {
      createOrder();
    }
  }

  createOrder() {
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
    mDashboardScreenController.value?.mOrderPlace.value?.mSelectCustomer =
        mSelectCustomer.value ?? GetAllCustomerList();

    Get.back();
  }

  Rxn<String> sTableNumber = Rxn<String>();
  Rxn<GetAllTablesResponseData> sTablesData = Rxn<GetAllTablesResponseData>();

  void setTableNumber(GetAllTablesResponseData? mGetAllTablesResponseData) {
    isCreateOrder.value = false;
    sTablesData.value = mGetAllTablesResponseData ?? GetAllTablesResponseData();
    sTableNumber.value = mGetAllTablesResponseData?.seatNumber ?? '';
    if (sTableNumber.value != null) {
      sTableNoController.value.text = sTableNumber.value ?? '';
      sTableNoController.refresh();
    }
  }

  ///customer
  Rxn<GetAllCustomerList> mSelectCustomer = Rxn<GetAllCustomerList>();

  getAllCustomer({bool showCustomer = false}) async {
    List<GetAllCustomerList> allCustomerList = [];
    await mDashboardScreenController.value?.getAllCustomerList();
    allCustomerList.clear();
    allCustomerList.addAll(
        (mDashboardScreenController.value?.mAllCustomerList.value ?? []));

    if (showCustomer) {
      showCustomerBottomSheet(allCustomerList,
          (GetAllCustomerList mGetAllCustomerList) {
        debugPrint('Selected: ${jsonEncode(mGetAllCustomerList)}');
        mSelectCustomer.value = mGetAllCustomerList;
        sPhoneNumberController.value.text =
            mGetAllCustomerList.phoneNumber ?? '';
        enterNameController.value.text = "";
        if (mGetAllCustomerList.name != "_new_") {
          enterNameController.value.text = mGetAllCustomerList.name ?? '';
        }
      });
    }
  }

  ///add new customer
  onSubmit() async {
    if (sPhoneNumberController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterMobileNumber.tr);
    } else if (sPhoneNumberController.value.text.trim().length < 9) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterValidMobileNumber.tr);
    } else if (enterNameController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterName.tr);
    } else {
      await callSaveCustomer();
    }
  }

  callSaveCustomer() async {
    ///api Customer call
    final customerApi = locator.get<CustomerApi>();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        CustomerSaveRequest mCustomerSaveRequest = CustomerSaveRequest(
            email: '',
            name: enterNameController.value.text,
            phoneCountryCode: '+$phoneCode',
            phoneNumber: sPhoneNumberController.value.text,
            dateOfBirth: '',
            address: '',
            userIDF: await SharedPrefs().getUserId(),
            restaurantIDF:
                (mConfigurationResponse.configurationData?.restaurantData ?? [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .first
                        .restaurantIDP);
        WebResponseSuccess mWebResponseSuccess =
            await customerApi.postCustomerSave(mCustomerSaveRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          await callGetAllCustomer();
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

  ///get all Customer
  final customerLocalApi = locator.get<CustomerLocalApi>();

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
            if ((mGetAllCustomerResponse
                        .getAllCustomerData?.getAllCustomerList ??
                    [])
                .isNotEmpty) {
              mSelectCustomer.value = (mGetAllCustomerResponse
                          .getAllCustomerData?.getAllCustomerList ??
                      [])
                  .first;
            }
            // mGetAllCustomerData.value =
            //     mGetAllCustomerResponse.getAllCustomerData ??
            //         GetAllCustomerData();
            // mAllCustomerList.value = [];
            // mAllCustomerList.value
            //     ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
            // mAllCustomerList.refresh();
            //
            // if ((mAllCustomerList.value ?? []).isNotEmpty) {
            //   (mSelectCustomerList.value ?? []).clear();
            //   mSelectCustomerList.refresh();
            //   selectPage();
            // }
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
