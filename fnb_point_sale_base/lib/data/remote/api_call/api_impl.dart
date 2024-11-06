import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/web_constants.dart';
import '../../mode/login/login_failed_response.dart';
import '../../mode/login/login_response.dart';
import '../web_response.dart';
import '../web_response_failed.dart';
import 'api_adapter.dart';
import 'api_provider.dart';

class AllApiImpl implements IApiRepository {
  WebProvider mWebProvider = WebProvider();
  late WebResponseSuccess mWebResponseSuccess;
  late WebResponseFailed mWebResponseFailed;

  Map processResponseToJson(Response response) {
    var responseBody = response.body;
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
      case 400:
        Map responseJson = json.decode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 400 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 403:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 403 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 404:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 404 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 500:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 500 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 502:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 502 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 503:
        Map responseJson = json.decode(WebConstants.statusCode503Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 503 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      default:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
    }
  }

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
