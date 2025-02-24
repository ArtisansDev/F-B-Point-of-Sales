import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
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

class LoginScreenController extends GetxController {
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  RxBool isLogin = true.obs;

  LoginScreenController() {
    getPackageInfo();
    // userNameController.value.text = 'balajikanna456@gmail.com';
    // passwordController.value.text = 'Password123';
    //getToken();
  }

  RxString version = ''.obs;

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  isLoginCheck() {
    if (userNameController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the UserName');
    } else if (passwordController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the password');
    } else {
      loginApiCall();
    }
  }

  void loginApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        var configurationLocalApi = locator.get<ConfigurationLocalApi>();
        ConfigurationResponse mConfigurationResponse =
            await configurationLocalApi.getConfigurationResponse() ??
                ConfigurationResponse();
        final localApi = locator.get<LoginApi>();
        LoginRequest mLoginRequest = LoginRequest(
            branchID: (mConfigurationResponse.configurationData?.branchData ??
                        [])
                    .isEmpty
                ? ""
                : (mConfigurationResponse.configurationData?.branchData ?? [])
                    .first
                    .branchIDP,
            counterID: (mConfigurationResponse.configurationData?.counterData ??
                        [])
                    .isEmpty
                ? ""
                : (mConfigurationResponse.configurationData?.counterData ?? [])
                    .first
                    .counterIDP,
            email: userNameController.value.text.trim(),
            password: passwordController.value.text.trim());
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postLogin(mLoginRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          LoginResponse mLoginResponse = mWebResponseSuccess.data;
          await SharedPrefs()
              .setUserToken(mLoginResponse.data?.accessToken ?? '');
          await SharedPrefs().setUserId(mLoginResponse.data?.userId ?? '');
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          WebConstants.isFastTimeLogin = true;
          if (mLoginResponse.data?.isAlreadyLoggedIn ?? false) {
            await updateLoginStatusApiCall();
            if ((mLoginResponse.data?.activeCounterHistoryId ?? '')
                .isNotEmpty) {
              await SharedPrefs().setHistoryID(
                  mLoginResponse.data?.activeCounterHistoryId ?? '');
              Get.offNamed(
                RouteConstants.rDashboardScreen,
              );
            } else {
              await SharedPrefs().setHistoryID('');
              Get.offNamed(
                RouteConstants.rOpenCounterScreen,
              );
            }
          } else {
            await SharedPrefs().setHistoryID('');
            Get.offNamed(
              RouteConstants.rOpenCounterScreen,
            );
          }
          // await openingBalanceApiCall();
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

  updateLoginStatusApiCall() async {
    DeviceInfo mDeviceInfo = await getDeviceDetails();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    Rx<ConfigurationResponse> mConfigurationResponse =
        ConfigurationResponse().obs;
    mConfigurationResponse.value =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
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
                isLoggedIn: true);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdatePOSLoginStatus(mUpdateLoginStatusRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
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

  void logOutConfiguration() {
    AppAlert.showCustomDialogYesNoLogout(
        Get.context!,
        'Logout & Clear Configuration!',
        'Do you want to Logout & Clear Configuration?', ()  {
      clearConfiguration();
    });
  }

}
