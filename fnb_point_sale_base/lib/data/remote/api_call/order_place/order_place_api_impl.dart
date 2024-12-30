import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/customer/get_all_customer/get_all_customer_response.dart';
import '../../../mode/order_history/order_history_request.dart';
import '../../../mode/order_history/order_history_response.dart';
import '../../web_response_failed.dart';
import 'order_place_api.dart';

class OrderPlaceApiImpl extends AllApiImpl with OrderPlaceApi {
  ///post postOrderPlace
  @override
  Future<WebResponseSuccess> postOrderPlace(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionPOSOrder, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      mWebResponseSuccess =
          WebResponseSuccess.fromJson(processResponseToJson(cases));
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

  ///post postOrderHistory
  @override
  Future<WebResponseSuccess> postOrderHistory(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionPOSOrderHistory, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      OrderHistoryResponse mOrderHistoryResponse =
      OrderHistoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mOrderHistoryResponse,
        statusMessage: '',
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
}
