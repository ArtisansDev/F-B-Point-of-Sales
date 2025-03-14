import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/customer/get_all_customer/get_all_customer_response.dart';
import '../../../mode/order_history/order_history_request.dart';
import '../../../mode/order_history/order_history_response.dart';
import '../../../mode/table_status/get_all_tables_by_table_status_response.dart';
import '../../web_response_failed.dart';
import 'order_place_api.dart';

class OrderPlaceApiImpl extends AllApiImpl with OrderPlaceApi {
  ///post post Order Place
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

  ///post post Order History
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

 ///post post Table Status
  @override
  Future<WebResponseSuccess> postTableStatus(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionUpdateTableStatus, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      WebResponseSuccess mWebResponseSuccess =
      WebResponseSuccess.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mWebResponseSuccess,
        statusMessage: '',
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginFailedResponse,
        statusMessage:mWebResponseFailed.statusMessage,
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode400) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
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

  ///post GetAll TablesByTableStatus
  @override
  Future<WebResponseSuccess> postGetAllTablesByTableStatus(exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllTablesByTableStatus, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllTablesByTableStatusResponse mGetAllTablesByTableStatusResponse =
      GetAllTablesByTableStatusResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllTablesByTableStatusResponse,
        statusMessage: '',
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginFailedResponse,
        statusMessage:mWebResponseFailed.statusMessage,
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode400) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
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
