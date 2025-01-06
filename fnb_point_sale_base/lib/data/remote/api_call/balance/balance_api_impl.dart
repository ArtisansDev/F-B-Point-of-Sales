import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/customer/get_all_customer/get_all_customer_response.dart';
import '../../../mode/update_balance/opening_balance/opening_balance_response.dart';
import '../../web_response_failed.dart';
import 'balance_api.dart';

class BalanceApiImpl extends AllApiImpl with BalanceApi {
  ///post UpdateOpeningBalance
  @override
  Future<WebResponseSuccess> postUpdateOpeningBalance(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionUpdateOpeningBalance, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      OpeningBalanceResponse mOpeningBalanceResponse =
      OpeningBalanceResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mOpeningBalanceResponse,
        statusMessage: "Get all category downloaded successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode400) {
      // LoginFailedResponse mLoginFailedResponse =
      //     LoginFailedResponse.fromJson(json.decode(jsonEncode(cases.body)));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginFailedResponse,
        statusMessage: '',
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

  ///post UpdateClosingBalance
  @override
  Future<WebResponseSuccess> postUpdateClosingBalance(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionUpdateClosingBalance, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      mWebResponseSuccess =
          WebResponseSuccess.fromJson(processResponseToJson(cases));
      // mWebResponseSuccess = WebResponseSuccess(
      //   statusCode: cases.statusCode,
      //   data: mMenuItemResponse,
      //   statusMessage: "Get all menu item downloaded successfully",
      //   error: false,
      // );
    } else if (cases.statusCode == WebConstants.statusCode409) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginFailedResponse,
        statusMessage: mWebResponseFailed.statusMessage,
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
