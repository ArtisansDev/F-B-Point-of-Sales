import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../constants/web_constants.dart';
import '../../../mode/configuration/configuration_response.dart';
import '../../../mode/login/login_response.dart';
import '../../../mode/manager_credentials/manager_credentials_response.dart';
import '../../web_response_failed.dart';
import 'login_api.dart';

class LoginApiImpl extends AllApiImpl with LoginApi {
  ///post Login
  @override
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionLogin, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      LoginResponse mLoginResponse =
          LoginResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mLoginResponse,
        statusMessage: "Login successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      WebResponseFailed mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage ?? '',
        error: false,
      );
    } else {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    }

    return mWebResponseSuccess;
  }

  ///post Configuration
  @override
  Future<WebResponseSuccess> postConfiguration(dynamic exhibitorsListRequest,
      {bool flag = true}) async {
    if (flag) {
      AppAlert.showProgressDialog(Get.context!);
    }
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionConfiguration, exhibitorsListRequest);
    if (flag) {
      AppAlert.hideLoadingDialog(Get.context!);
    }
    if (cases.statusCode == WebConstants.statusCode200) {
      ConfigurationResponse mConfigurationResponse =
          ConfigurationResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mConfigurationResponse,
        statusMessage: "Configuration successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode404) {
      WebResponseFailed mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage ?? '',
        error: false,
      );
    } else {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    }

    return mWebResponseSuccess;
  }

  ///post actionUpdatePOSLoginStatus
  @override
  Future<WebResponseSuccess> postUpdatePOSLoginStatus(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionUpdatePOSLoginStatus, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      // ConfigurationResponse mConfigurationResponse =
      //     ConfigurationResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mConfigurationResponse,
        statusMessage: "",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode404) {
      WebResponseFailed mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage ?? '',
        error: false,
      );
    } else {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    }

    return mWebResponseSuccess;
  }

  ///post actionManagerCredentialsStatus
  @override
  Future<WebResponseSuccess> postManagerCredentials(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionManagerCredentialsStatus, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      ManagerCredentialsResponse mManagerCredentialsResponse =
          ManagerCredentialsResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mManagerCredentialsResponse,
        statusMessage: mManagerCredentialsResponse.statusMessage,
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseSuccess =
          WebResponseSuccess.fromJson(processResponseToJson(cases));
    } else {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    }

    return mWebResponseSuccess;
  }
}
