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
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../add_customer/controller/add_customer_controller.dart';
import '../add_customer/view/add_customer_screen.dart';

class CustomerController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rxn<GetAllCustomerData> mGetAllCustomerData = Rxn<GetAllCustomerData>();
  Rxn<List<GetAllCustomerList>> mAllCustomerList =
      Rxn<List<GetAllCustomerList>>();

  Rxn<List<GetAllCustomerList>> mSelectCustomerList =
      Rxn<List<GetAllCustomerList>>();
  final customerLocalApi = locator.get<CustomerLocalApi>();
  RxInt pageNumber = 0.obs;
  RxInt totalPage = 0.obs;

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

    mAllCustomerList.value = [];
    mAllCustomerList.value
        ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
    mAllCustomerList.refresh();

    if ((mAllCustomerList.value ?? []).isEmpty) {
      callGetAllCustomer();
    } else {
      (mSelectCustomerList.value ?? []).clear();
      mSelectCustomerList.refresh();
      selectPage();
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
            await customerLocalApi.save(mGetAllCustomerResponse);

            ///GetAllCustomerResponse
            mGetAllCustomerData.value =
                mGetAllCustomerResponse.getAllCustomerData ??
                    GetAllCustomerData();
            mAllCustomerList.value = [];
            mAllCustomerList.value
                ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
            mAllCustomerList.refresh();

            if ((mAllCustomerList.value ?? []).isNotEmpty) {
              (mSelectCustomerList.value ?? []).clear();
              mSelectCustomerList.refresh();
              selectPage();
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
      MyLogUtils.logDebug('downloadTableList failed with exception $e');
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }

  ///addCustomer
  addCustomer() async {
    await AppAlert.showViewWithoutBlur(Get.context!,  AddCustomerScreen(
      mCustomer: GetAllCustomerList(),
    ),
        barrierDismissible: true);
    bool isAddMember = false;
    if (Get.isRegistered<AddCustomerController>()) {
      AddCustomerController mAddCustomerController =
          Get.find<AddCustomerController>();
      isAddMember = mAddCustomerController.isAddMember;
      Get.delete<AddCustomerController>();
    }

    if (isAddMember) {
      callGetAllCustomer();
    }
  }

  RxInt page = 1.obs;
  RxInt perPage = 15.obs;

  selectPage() {
    (mSelectCustomerList.value ?? []).clear();
    mSelectCustomerList.value = [];
    if ((mAllCustomerList.value ?? []).length >
        (perPage.value) * (page.value)) {
      mSelectCustomerList.value?.addAll((mAllCustomerList.value ?? []).getRange(
          (perPage.value) * (page.value - 1), (perPage.value) * (page.value)));
    } else {
      mSelectCustomerList.value?.addAll((mAllCustomerList.value ?? []).getRange(
          (perPage.value) * (page.value - 1),
          (mAllCustomerList.value ?? []).length));
    }
    pageNumberCalculation();
  }

  void pageNumberCalculation() {
    int len = (mAllCustomerList.value ?? []).length;
    totalPage.value = (len % perPage.value) == 0
        ? getInValue(len / perPage.value)
        : getInValue((len / perPage.value) + 1);
    if (totalPage.value > 0 && pageNumber.value == 0) {
      pageNumber.value = 1;
    }
    totalPage.refresh();
    pageNumber.refresh();
    mSelectCustomerList.refresh();
  }

  void onTextChange(value) {
    if (value.toString().isEmpty) {
      mAllCustomerList.value = [];
      mAllCustomerList.value
          ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
      if ((mAllCustomerList.value ?? []).isNotEmpty) {
        (mSelectCustomerList.value ?? []).clear();
        mSelectCustomerList.refresh();
        selectPage();
      }
    } else {
      mAllCustomerList.value = [];
      mAllCustomerList.value
          ?.addAll((mGetAllCustomerData.value?.getAllCustomerList ?? []).where(
        (element) {
          return element.name
                  .toString()
                  .toLowerCase()
                  .contains(value.toString().toLowerCase()) ||
              element.phoneNumber
                  .toString()
                  .toLowerCase()
                  .contains(value.toString().toLowerCase());
        },
      ));

      if ((mAllCustomerList.value ?? []).isNotEmpty) {
        (mSelectCustomerList.value ?? []).clear();
        mSelectCustomerList.refresh();
      }
      selectPage();
    }
  }

  ///edit
  void onEdit(int index, GetAllCustomerList mCustomer) async {
    await AppAlert.showViewWithoutBlur(
        Get.context!, AddCustomerScreen(mCustomer: mCustomer),
        barrierDismissible: true);
    bool isAddMember = false;
    if (Get.isRegistered<AddCustomerController>()) {
      AddCustomerController mAddCustomerController =
          Get.find<AddCustomerController>();
      isAddMember = mAddCustomerController.isAddMember;
      Get.delete<AddCustomerController>();
    }

    if (isAddMember) {
      callGetAllCustomer();
    }
  }


}
