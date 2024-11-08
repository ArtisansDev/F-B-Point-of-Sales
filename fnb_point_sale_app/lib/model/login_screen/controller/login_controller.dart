import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/login/login_api.dart';
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
      Get.offNamed(
        RouteConstants.rDashboardScreen,
      );
      // loginApiCall();
    }
  }

  void loginApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        final localApi = locator.get<LoginApi>();
        LoginRequest mLoginRequest = LoginRequest(
            email: userNameController.value.text.trim(),
            password: passwordController.value.text.trim());
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postLogin(mLoginRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          LoginResponse mLoginResponse = mWebResponseSuccess.data;
          await SharedPrefs().setUserToken(mLoginResponse.accessToken);
          await SharedPrefs().setUserDetails(jsonEncode(mLoginResponse.user));
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
