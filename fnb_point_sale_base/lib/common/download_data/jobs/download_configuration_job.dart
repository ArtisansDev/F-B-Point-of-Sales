// ignore_for_file: depend_on_referenced_packages, avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'package:get/get.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/database/configuration/configuration_local_api.dart';
import '../../../data/local/database/modifier/modifier_local_api.dart';
import '../../../data/local/database/product/all_category/all_category_local_api.dart';
import '../../../data/local/database/table_list/table_list_local_api.dart';
import '../../../data/local/database/variant/variant_local_api.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/configuration/configuration_request.dart';
import '../../../data/mode/configuration/configuration_response.dart';
import '../../../data/mode/product/get_all_category/get_all_category_response.dart';
import '../../../data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../../../data/mode/product/get_all_tables/get_all_tables_response.dart';
import '../../../data/mode/product/get_all_variant/get_all_variant_response.dart';
import '../../../data/mode/product/product_request.dart';
import '../../../data/remote/api_call/login/login_api.dart';
import '../../../data/remote/api_call/product/product_api.dart';
import '../../../data/remote/web_response.dart';
import '../../../locator.dart';
import '../../../utils/my_log_utils.dart';
import '../../../utils/network_utils.dart';

Future<void> downloadConfiguration(Function onError) async {
  try {
    ///api product call
    final localApi = locator.get<LoginApi>();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        ConfigurationRequest mConfigurationRequest = ConfigurationRequest(
            accessToken: await SharedPrefs().getConfigurationAccessToken(),
            counterIDP:
                (mConfigurationResponse.configurationData?.counterData ?? [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse.configurationData?.counterData ??
                            [])
                        .first
                        .counterIDP);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postConfiguration(mConfigurationRequest,flag: false);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          ConfigurationResponse mConfigurationResponseData =
              mWebResponseSuccess.data;
          var configurationLocalApi = locator.get<ConfigurationLocalApi>();
          await configurationLocalApi.save(mConfigurationResponseData);
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
    onError('downloadTableList failed with exception $e');
  }
}
