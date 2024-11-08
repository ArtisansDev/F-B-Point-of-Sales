// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';
import '../../../routes/route_constants.dart';

class SplashScreenController extends GetxController {
  RxString version = ''.obs;

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
    nextPage();
  }

  void nextPage() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        // String sLoginStatus = await SharedPrefs().getUserToken();
        await Future.delayed(const Duration(seconds: 2));
        // Get.delete<SplashScreenController>();
        // if(sLoginStatus.trim().isNotEmpty){
        //   Get.offNamed(
        //     RouteConstants.rDashboardScreen,
        //   );
        // } else {
        Get.offNamed(
          RouteConstants.rLoginScreen,
        );
        // }
      }
    });
  }
}
