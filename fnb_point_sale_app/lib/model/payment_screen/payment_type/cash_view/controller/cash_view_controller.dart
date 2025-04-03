// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/payment_type/cash_payment_type.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/shift_details/shift_details_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/shift_details/shift_details_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/balance/balance_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';

class CashViewController extends GetxController {
  Rx<TextEditingController> amountController = TextEditingController().obs;
  Rxn<Function> onPaymentClick = Rxn<Function>();
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<double> mAmount = 0.0.obs;
  Rx<double> mDueAmount = 0.0.obs;
  Rx<double> mReturnAmount = 0.0.obs;
  Rx<bool> isSuccess = false.obs;
  Rx<bool> isRefund = false.obs;
  RegExp patternDecimalNumberWeight = RegExp(r'^\d+(\.\d{0,2})?$');

  CashViewController(Function onPayment, OrderPlace orderPlace, bool bRefund) {
    isRefund.value = bRefund;
    onPaymentClick.value = onPayment;
    mOrderPlace.value = orderPlace;
    mAmount.value = getDoubleValue(roundToNearestPossible(
        getDoubleValue(mOrderPlace.value?.totalPrice.toStringAsFixed(2))));
    amountController.value.text = "";
    onTextChangeAmount();
  }

  void onDone() {
    if (mDueAmount.value > 0) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the proper amount');
      return;
    } else if (isRefund.value) {
      double dAmount = 0.00;
      if (amountController.value.text.isNotEmpty) {
        dAmount = getDoubleValue(amountController.value.text);
      }
      if (cashPaymentAmount.value < dAmount) {
        AppAlert.showSnackBar(
            Get.context!, "You don't have enough cash in your counter.");
        return;
      }else {
        isSuccess.value = true;
        Get.back();
        CashPaymentType mCashPaymentType = CashPaymentType(
            cash: Cash(
                dueAmount: mDueAmount.value.toStringAsFixed(2),
                payAmount: getDoubleValue(amountController.value.text)
                    .toStringAsFixed(2),
                returnAmount: mReturnAmount.value.toStringAsFixed(2)));
        String value = jsonEncode(mCashPaymentType);
        // "{\"Cash\": {\"Pay_Amount\": \"${getDoubleValue(amountController.value.text).toStringAsFixed(2)}\",\"Due_Amount\": \"${mDueAmount.value.toStringAsFixed(2)}\",\"Return_Amount\": \"${mReturnAmount.value.toStringAsFixed(2)}\"}}";
        onPaymentClick.value!(value);
      }
    } else if (cashPaymentAmount.value < mReturnAmount.value) {
      AppAlert.showSnackBar(
          Get.context!, "You don't have enough cash in your counter.");
      return;
    } else {
      isSuccess.value = true;
      Get.back();
      CashPaymentType mCashPaymentType = CashPaymentType(
          cash: Cash(
              dueAmount: mDueAmount.value.toStringAsFixed(2),
              payAmount: getDoubleValue(amountController.value.text)
                  .toStringAsFixed(2),
              returnAmount: mReturnAmount.value.toStringAsFixed(2)));
      String value = jsonEncode(mCashPaymentType);
      // "{\"Cash\": {\"Pay_Amount\": \"${getDoubleValue(amountController.value.text).toStringAsFixed(2)}\",\"Due_Amount\": \"${mDueAmount.value.toStringAsFixed(2)}\",\"Return_Amount\": \"${mReturnAmount.value.toStringAsFixed(2)}\"}}";
      onPaymentClick.value!(value);
    }
  }

  void onCancelView() {
    Get.back();
    onPaymentClick.value!('Cancel');
  }

  void onTextChangeAmount() {
    double dAmount = 0.00;
    if (amountController.value.text.isNotEmpty) {
      dAmount = getDoubleValue(amountController.value.text);
    }

    ///DueAmount
    mDueAmount.value = dAmount;
    if ((mAmount.value - mDueAmount.value) > 0) {
      mDueAmount.value = mAmount.value - mDueAmount.value;
    } else {
      mDueAmount.value = 0.00;
    }

    ///ReturnAmount
    mReturnAmount.value = dAmount;
    if ((mReturnAmount.value - mAmount.value) > 0) {
      mReturnAmount.value = mReturnAmount.value - mAmount.value;
    } else {
      mReturnAmount.value = 0.00;
    }
  }

  void isPinCheck() {}

  void onDeletePress() {
    String value = amountController.value.text;
    if (value.isNotEmpty) {
      if (value.length == 1) {
        value = "";
      } else {
        value = value.substring(0, value.length - 1);
      }
    } else {
      amountController.value.text = value;
      onTextChangeAmount();
    }
    if (patternDecimalNumberWeight.hasMatch(value)) {
      amountController.value.text = value;
      onTextChangeAmount();
    } else if (value.isEmpty) {
      amountController.value.text = value;
      onTextChangeAmount();
    }
  }

  void onKeyboardTap(String s) {
    String value = amountController.value.text;
    value = value + s;

    if (patternDecimalNumberWeight.hasMatch(value)) {
      amountController.value.text = value;
      onTextChangeAmount();
    }
  }

  void onClear() {
    amountController.value.text = "";
    onTextChangeAmount();
  }

  void onExact() {
    amountController.value.text = mAmount.value.toStringAsFixed(2);
    onTextChangeAmount();
  }

  Rx<ShiftDetailsResponse> mShiftDetailsResponse = ShiftDetailsResponse().obs;
  Rx<double> cashPaymentAmount = 0.0.obs;

  ///postShiftDetailsApiCall
  postShiftDetailsApiCall() async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        var configurationLocalApi = locator.get<ConfigurationLocalApi>();
        ConfigurationResponse mConfigurationResponse =
            await configurationLocalApi.getConfigurationResponse() ??
                ConfigurationResponse();
        String sUserId = await SharedPrefs().getUserId();
        String sHistoryID = await SharedPrefs().getHistoryID();
        final localApi = locator.get<BalanceApi>();
        ShiftDetailsRequest mShiftDetailsRequest = ShiftDetailsRequest(
            counterIDF:
                (mConfigurationResponse.configurationData?.counterData ?? [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse.configurationData?.counterData ??
                            [])
                        .first
                        .counterIDP,
            userIDF: sUserId,
            counterBalanceHistoryIDF: sHistoryID);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postShiftDetails(mShiftDetailsRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          mShiftDetailsResponse.value = mWebResponseSuccess.data;
          cashPaymentAmount.value =
              mShiftDetailsResponse.value.data?.cashPayment ?? 0.0;
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
