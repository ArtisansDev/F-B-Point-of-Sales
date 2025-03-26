import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/payment_type/payment_type_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/manager_credentials/manager_credentials_request.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/opening_balance/opening_balance_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/opening_balance/opening_balance_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_login_status/update_login_status_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_payment_type/update_payment_type_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/balance/balance_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/login/login_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/get_device_details.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/login/login_request.dart';
import 'package:fnb_point_sale_base/data/mode/login/login_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';

import '../../../common_view/logout_expired.dart';
import '../../../routes/route_constants.dart';
import '../../payment_screen/payment_type/credit_card_view/controller/credit_card_view_controller.dart';
import '../../payment_screen/payment_type/credit_card_view/view/credit_card_view.dart';
import '../../payment_screen/payment_type/debit_card_view/controller/debit_card_view_controller.dart';
import '../../payment_screen/payment_type/debit_card_view/view/debit_card_view.dart';
import '../../payment_screen/payment_type/qr_code_view/controller/qr_view_controller.dart';
import '../../payment_screen/payment_type/qr_code_view/view/qr_view.dart';

class PaymentTypeController extends GetxController {
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  Rxn<GetAllPaymentTypeResponse> mGetAllPaymentTypeResponse =
      Rxn<GetAllPaymentTypeResponse>();
  Rxn<OrderHistoryData> mOrderHistoryData = Rxn<OrderHistoryData>();
  RxList<GetAllPaymentTypeData> mGetAllPaymentTypeData =
      <GetAllPaymentTypeData>[].obs;
  RxBool isSuccess = false.obs;
  PaymentTypeController(OrderHistoryData mSelectOrderHistoryData) {
    mOrderHistoryData.value = mSelectOrderHistoryData;
  }

  loadPaymentType() async {
    var mPaymentTypeLocalApi = locator.get<PaymentTypeLocalApi>();
    mGetAllPaymentTypeResponse.value =
        await mPaymentTypeLocalApi.getPaymentTypeResponse() ??
            GetAllPaymentTypeResponse();
    mGetAllPaymentTypeData.clear();
    mGetAllPaymentTypeData.addAll(mGetAllPaymentTypeResponse.value?.data ?? []);
    mGetAllPaymentTypeData.removeWhere(
      (element) {
        return element.paymentGatewayNo.toString() ==
            mOrderHistoryData.value?.paymentGatewayNo.toString();
      },
    );
    mGetAllPaymentTypeResponse.refresh();
    mGetAllPaymentTypeData.refresh();
  }

  RxBool isSelectPayment = false.obs;
  Rx<GetAllPaymentTypeData> mGetAllPaymentType = GetAllPaymentTypeData().obs;

  isSelectPaymentType(index) {
    for (int i = 0; i < mGetAllPaymentTypeData.length; i++) {
      mGetAllPaymentTypeData[i].setIsSelect(false);
    }
    isSelectPayment.value = true;
    mGetAllPaymentTypeData[index].setIsSelect(true);
    mGetAllPaymentType.value = mGetAllPaymentTypeData[index];
    mGetAllPaymentTypeData.refresh();
    isSelectPayment.refresh();
  }

  void isCheck() async {
    if (!isSelectPayment.value) {
      AppAlert.showSnackBar(Get.context!, 'Please select the payment type');
    } else if (reasonController.value.text.isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter the reason');
    } else {
      ///payment
      switch (mGetAllPaymentType.value.paymentGatewayNo) {
        case "5":

          ///Debit Card
          await AppAlert.showViewWithoutBlur(Get.context!, DebitCardView(
            onPayment: (String value) {
              mGetAllPaymentType.value.setRequestData(value);
            },
          ));
          if (Get.isRegistered<DebitCardViewController>()) {
            Get.delete<DebitCardViewController>();
          }
          break;
        case "6":

          ///Credit Card
          await AppAlert.showViewWithoutBlur(Get.context!, CreditCardView(
            onPayment: (String value) {
              mGetAllPaymentType.value.setRequestData(value);
            },
          ));
          if (Get.isRegistered<CreditCardViewController>()) {
            Get.delete<CreditCardViewController>();
          }
          break;
        case "7":

          ///Qr code
          await AppAlert.showViewWithoutBlur(
              Get.context!,
              QrView(
                mSelectPaymentType: mGetAllPaymentType.value,
                onPayment: (String sValue) {
                  mGetAllPaymentType.value.setRequestData(sValue);
                },
              ));
          if (Get.isRegistered<QrViewController>()) {
            await Get.delete<QrViewController>();
          }
          break;
      }
      await callUpdatePaymentType();
    }
  }

  callUpdatePaymentType() async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          UpdatePaymentTypeRequest mUpdatePaymentTypeRequest =
              UpdatePaymentTypeRequest(
            branchIDF: mOrderHistoryData.value?.branchIDF ?? '',
            restaurantIDF: mOrderHistoryData.value?.restaurantIDF ?? '',
            trackingOrderID: mOrderHistoryData.value?.trackingOrderID,
            paymentGatewayIDF: mGetAllPaymentType.value.paymentGatewayIDP,
            paymentGatewaySettingIDF:
                mGetAllPaymentType.value.paymentGatewaySettingIDP,
            reasonForChangingPaymentType: reasonController.value.text,
            userIDF: await SharedPrefs().getUserId(),
            requestData: mGetAllPaymentType.value.requestData,
          );
          WebResponseSuccess mWebResponseSuccess = await orderPlaceApi
              .postUpdatePaymentType(mUpdatePaymentTypeRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
            isSuccess.value = true;
            Get.back();
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
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }
}
