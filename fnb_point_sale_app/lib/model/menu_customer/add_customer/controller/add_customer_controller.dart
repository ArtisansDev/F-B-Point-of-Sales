// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/save/customer_save_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

import '../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../controller/customer_controller.dart';

class AddCustomerController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  CustomerController mCustomerController = Get.find<CustomerController>();

  Rx<TextEditingController> enterNameController = TextEditingController().obs;
  Rx<TextEditingController> enterEmailController = TextEditingController().obs;
  Rx<TextEditingController> enterDobController = TextEditingController().obs;
  Rx<TextEditingController> enterAddressController =
      TextEditingController().obs;
  Rx<TextEditingController> sPhoneNumberController =
      TextEditingController().obs;
  RxString phoneCode = '60'.obs;

  ///DateTime
  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly);

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      enterDobController.value.text = getDateDDMMYYYY(pickedDate);
    }
  }

  void onSubmit() {
    if (sPhoneNumberController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterMobileNumber.tr);
    } else if (sPhoneNumberController.value.text.trim().length < 9) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterValidMobileNumber.tr);
    } else {
      callSaveCustomer();
    }
  }
  bool isAddMember = false;

  void callSaveCustomer() async {
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
          CustomerSaveRequest mCustomerSaveRequest = CustomerSaveRequest(
              email: enterEmailController.value.text,
              name: enterNameController.value.text,
              phoneCountryCode: '+$phoneCode',
              phoneNumber: sPhoneNumberController.value.text,
              dateOfBirth: enterDobController.value.text.isNotEmpty
                  ? selectedDate.value.toString()
                  : '',
              address: enterAddressController.value.text,
              userIDF: await SharedPrefs()
                  .getUserId(),
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
              await customerApi.postCustomerSave(mCustomerSaveRequest);

          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            isAddMember = true;
            Get.back();
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
