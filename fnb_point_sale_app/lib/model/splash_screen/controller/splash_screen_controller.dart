// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';
import '../../../routes/route_constants.dart';

class SplashScreenController extends GetxController {
  RxString version = ''.obs;

  getPackageInfo() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    version.value = dotenv.env['APP_VERSION'] ?? '';
    version.refresh();
    nextPage();
  }

  void nextPage() async{
    // NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
    //   if (isInternetAvailable) {
        String sLoginStatus = await SharedPrefs().getUserToken();
        await Future.delayed(const Duration(seconds: 1));
        if (sLoginStatus.trim().isNotEmpty) {
          String sHistoryID = await SharedPrefs().getHistoryID();
          if(sHistoryID.isEmpty){
            Get.offNamed(
              RouteConstants.rOpenCounterScreen,
            );
          }else {
            Get.offNamed(
              RouteConstants.rDashboardScreen,
            );
          }
        } else {
          var configurationLocalApi = locator.get<ConfigurationLocalApi>();
          ConfigurationResponse mConfigurationResponse =
              await configurationLocalApi.getConfigurationResponse() ??
                  ConfigurationResponse();
          if (mConfigurationResponse.error ?? false) {
            Get.offNamed(
              RouteConstants.rConfigurationScreen,
            );
          } else {
            Get.offNamed(
              RouteConstants.rConfigurationScreen,
            );
            // Get.offNamed(
            //   RouteConstants.rLoginScreen,
            // );
          }
        }
    //   }
    // });
  }
}
