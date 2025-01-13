import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/opening_balance/opening_balance_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/opening_balance/opening_balance_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/balance/balance_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/login/login_api.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
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

import '../../../routes/route_constants.dart';

class OpenCounterController extends GetxController {
  Rx<TextEditingController> openCounterController = TextEditingController().obs;

  OpenCounterController() {
    openCounterController.value.text = "";
    getPackageInfo();
  }

  RxString version = ''.obs;

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  isOpenStore() {
    openingBalanceApiCall();
  }

  openingBalanceApiCall() async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        var configurationLocalApi = locator.get<ConfigurationLocalApi>();
        ConfigurationResponse mConfigurationResponse =
            await configurationLocalApi.getConfigurationResponse() ??
                ConfigurationResponse();
        String sUserId = await SharedPrefs().getUserId();
        final localApi = locator.get<BalanceApi>();
        OpeningBalanceRequest mOpeningBalanceRequest = OpeningBalanceRequest(
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
            userID: sUserId,
            openingBalance: getDoubleValue(openCounterController.value.text),
            openingBalanceDateTime: getUTCValue(DateTime.now()));
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdateOpeningBalance(mOpeningBalanceRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          OpeningBalanceResponse mOpeningBalanceResponse =
              mWebResponseSuccess.data;
          await SharedPrefs()
              .setHistoryID(mOpeningBalanceResponse.data?.historyID ?? '');
          WebConstants.isFastTimeLogin = true;
          Get.offNamed(
            RouteConstants.rDashboardScreen,
          );
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
