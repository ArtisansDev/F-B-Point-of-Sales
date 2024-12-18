import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_request.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/login/login_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/product/product_api.dart';
import 'package:fnb_point_sale_base/locator.dart';
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

class ConfigurationScreenController extends GetxController {
  final localApi = locator.get<LoginApi>();
  final productApi = locator.get<ProductApi>();
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  RxBool isLogin = true.obs;

  ConfigurationScreenController() {
    getPackageInfo();
  }

  RxString version = ''.obs;

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  isConfigurationCheck() {
    if (userNameController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the configuration key');
    } else {
      configurationApiCall();
    }
  }

  void configurationApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        final localApi = locator.get<LoginApi>();
        ConfigurationRequest mConfigurationRequest = ConfigurationRequest(
            accessToken: userNameController.value.text.trim());
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postConfiguration(mConfigurationRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          ConfigurationResponse mConfigurationResponse =
              mWebResponseSuccess.data;
          var configurationLocalApi = locator.get<ConfigurationLocalApi>();
          await configurationLocalApi.save(mConfigurationResponse);
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          Get.offNamed(
            RouteConstants.rLoginScreen,
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
