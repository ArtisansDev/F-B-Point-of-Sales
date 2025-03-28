import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/manager_credentials/manager_credentials_request.dart';
import 'package:fnb_point_sale_base/data/mode/manager_credentials/manager_credentials_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/opening_balance/opening_balance_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/opening_balance/opening_balance_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_login_status/update_login_status_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/balance/balance_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/login/login_api.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/get_device_details.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/login/login_request.dart';
import 'package:fnb_point_sale_base/data/mode/login/login_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';

import '../../../common_view/logout_expired.dart';
import '../../../routes/route_constants.dart';

class BranchManagerController extends GetxController {
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  RxBool hidePassword = true.obs;
  RxBool isSuccess = false.obs;
  Rx<ManagerCredentialsResponse> mManagerCredentialsResponse = ManagerCredentialsResponse().obs;

  isLoginCheck() {
    if (userNameController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the email');
    } else if (passwordController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the password');
    } else {
      managerCredentialsApiCall();
    }
  }

  void managerCredentialsApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        var configurationLocalApi = locator.get<ConfigurationLocalApi>();
        ConfigurationResponse mConfigurationResponse =
            await configurationLocalApi.getConfigurationResponse() ??
                ConfigurationResponse();
        final localApi = locator.get<LoginApi>();
        ManagerCredentialsRequest mManagerCredentialsRequest = ManagerCredentialsRequest(
            branchIDF: (mConfigurationResponse.configurationData?.branchData ??
                        [])
                    .isEmpty
                ? ""
                : (mConfigurationResponse.configurationData?.branchData ?? [])
                    .first
                    .branchIDP,
            email: userNameController.value.text.trim(),
            password: passwordController.value.text.trim());
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postManagerCredentials(mManagerCredentialsRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          mManagerCredentialsResponse.value = mWebResponseSuccess.data;
          isSuccess.value = true;
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          Get.back();
         }else  if (mWebResponseSuccess.statusCode == WebConstants.statusCode401) {
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
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
