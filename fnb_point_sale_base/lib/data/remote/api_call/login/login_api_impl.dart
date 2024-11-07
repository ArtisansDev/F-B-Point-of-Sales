

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../constants/web_constants.dart';
import '../../../mode/login/login_failed_response.dart';
import '../../../mode/login/login_response.dart';
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
        statusMessage: "User login successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode400) {
      LoginFailedResponse mLoginFailedResponse =
      LoginFailedResponse.fromJson(json.decode(jsonEncode(cases.body)));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mLoginFailedResponse,
        statusMessage: mLoginFailedResponse.msg ?? '',
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
}
