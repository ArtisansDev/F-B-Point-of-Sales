// ignore_for_file: depend_on_referenced_packages



import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/closing_balance/closing_balance_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/balance/balance_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../common_view/logout_expired.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../view/details/controller/details_screen_controller.dart';
import '../view/open_cash_drawer/controller/open_cash_drawer_screen_controller.dart';

class ShiftDetailsController extends GetxController {
  DashboardScreenController mDashboardScreenController = Get.find<DashboardScreenController>();

  @override
  void onClose() {
    if (Get.isRegistered<OpenCashDrawerScreenController>()) {
      Get.delete<OpenCashDrawerScreenController>();
    }
    if (Get.isRegistered<DetailsScreenController>()) {
      Get.delete<DetailsScreenController>();
    }
    super.onClose();
  }

  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  Rx<ConfigurationResponse> mConfigurationResponse =
      ConfigurationResponse().obs;

  void getAllDetails() async {
    mConfigurationResponse.value =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    mConfigurationResponse.refresh();
  }



  ///
  void closeBalanceApiCall(String amount) {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        var configurationLocalApi = locator.get<ConfigurationLocalApi>();
        ConfigurationResponse mConfigurationResponse =
            await configurationLocalApi.getConfigurationResponse() ??
                ConfigurationResponse();
        String sUserId = await SharedPrefs().getUserId();
        final localApi = locator.get<BalanceApi>();
        ClosingBalanceRequest mClosingBalanceRequest = ClosingBalanceRequest(
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
            newClosingBalance: amount,
            closingBalanceDateTime: getUTCValue(DateTime.now()));
        WebResponseSuccess mWebResponseSuccess =
        await localApi.postUpdateClosingBalance(mClosingBalanceRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          logout();
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
