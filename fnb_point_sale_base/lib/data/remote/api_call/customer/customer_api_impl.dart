import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/product/product_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/customer/get_all_customer/get_all_customer_response.dart';
import '../../../mode/product/get_all_category/get_all_category_response.dart';
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import '../../../mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../../../mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import '../../../mode/product/get_all_tables/get_all_tables_response.dart';
import '../../../mode/product/get_all_variant/get_all_variant_response.dart';
import '../../web_response_failed.dart';
import 'customer_api.dart';

class CustomerApiImpl extends AllApiImpl with CustomerApi {
  ///post postGetAllCustomer
  @override
  Future<WebResponseSuccess> postGetAllCustomer(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllCustomer, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllCustomerResponse mGetAllCustomerResponse =
          GetAllCustomerResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllCustomerResponse,
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

  ///post postCustomerSave
  @override
  Future<WebResponseSuccess> postCustomerSave(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionCustomerSave, exhibitorsListRequest);
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
