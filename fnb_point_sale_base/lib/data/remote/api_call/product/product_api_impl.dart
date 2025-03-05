import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/product/product_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/get_menu_stock/get_menu_stock_response.dart';
import '../../../mode/product/get_all_category/get_all_category_response.dart';
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import '../../../mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../../../mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import '../../../mode/product/get_all_tables/get_all_tables_response.dart';
import '../../../mode/product/get_all_variant/get_all_variant_response.dart';
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

  ///post GetAllMenuItem
  @override
  Future<WebResponseSuccess> postGetAllMenuItem(exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllMenuItem, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      MenuItemResponse mMenuItemResponse =
          MenuItemResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mMenuItemResponse,
        statusMessage: "Get all menu item downloaded successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
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

  ///post UpdateStockStatus
  @override
  Future<WebResponseSuccess> postUpdateStockStatus(
      exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionPostUpdateStockStatus, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      // MenuItemResponse mMenuItemResponse =
      //     MenuItemResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        //data: mMenuItemResponse,
        statusMessage: "Update Stock Status successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
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

  ///post GetStockData
  @override
  Future<WebResponseSuccess> postGetStockData(exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionPostGetStockData, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetMenuStockResponse mGetMenuStockResponse =
          GetMenuStockResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetMenuStockResponse,
        statusMessage: "Get Stock Status successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
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

  ///post GetAllModifier
  @override
  Future<WebResponseSuccess> postGetAllModifier(exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllModifier, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllModifierResponse mGetAllModifierResponse =
          GetAllModifierResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllModifierResponse,
        statusMessage: "Get all modifier downloaded successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
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

  ///post GetAllVariant
  @override
  Future<WebResponseSuccess> postGetAllVariant(exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllVariant, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllVariantResponse mGetAllVariantResponse =
          GetAllVariantResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllVariantResponse,
        statusMessage: "Get all variant downloaded successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
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

  ///post GetAllTables
  @override
  Future<WebResponseSuccess> postGetAllTables(exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllTables, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllTablesResponse mGetAllTablesResponse =
          GetAllTablesResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllTablesResponse,
        statusMessage: "Get all Tables downloaded successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
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

  ///post GetAllPaymentType
  @override
  Future<WebResponseSuccess> postGetAllPaymentType(
      exhibitorsListRequest) async {
    // AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllPaymentType, exhibitorsListRequest);
    // AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetAllPaymentTypeResponse mGetAllPaymentTypeResponse =
          GetAllPaymentTypeResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllPaymentTypeResponse,
        statusMessage: "Get all Tables downloaded successfully",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
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
