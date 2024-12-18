import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/product/product_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/product/get_all_category/get_all_category_response.dart';
import '../../web_response_failed.dart';

class ProductApiImpl extends AllApiImpl with ProductApi {

  ///post GetAllCategory
  @override
  Future<WebResponseSuccess> postGetAllCategory(exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllCategory, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllCategoryResponse mGetAllCategoryResponse =
          GetAllCategoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllCategoryResponse,
        statusMessage: "User login successfully",
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

  ///post GetAllMenuItem
  @override
  Future<WebResponseSuccess> postGetAllMenuItem(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllMenuItem, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      // LoginResponse mLoginResponse =
      //     LoginResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginResponse,
        statusMessage: "User login successfully",
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

  ///post GetAllModifier
  @override
  Future<WebResponseSuccess> postGetAllModifier(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllModifier, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      // LoginResponse mLoginResponse =
      //     LoginResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginResponse,
        statusMessage: "User login successfully",
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

  ///post GetAllVariant
  @override
  Future<WebResponseSuccess> postGetAllVariant(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllVariant, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      // LoginResponse mLoginResponse =
      //     LoginResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mLoginResponse,
        statusMessage: "User login successfully",
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
