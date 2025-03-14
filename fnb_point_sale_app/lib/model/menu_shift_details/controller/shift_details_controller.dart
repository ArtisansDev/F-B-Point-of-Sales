// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/cash_model/cash_model.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/closing_balance/closing_balance_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/shift_details/shift_details_request.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/shift_details/shift_details_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/balance/balance_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../common_view/logout_expired.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../hold_sales/controller/hold_sales_controller.dart';
import '../../hold_sales/view/hold_sales_screen.dart';
import '../view/details/controller/details_screen_controller.dart';
import '../view/open_cash_drawer/controller/open_cash_drawer_screen_controller.dart';

class ShiftDetailsController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<TextEditingController> reasonController = TextEditingController().obs;

  @override
  void onClose() {
    if (Get.isRegistered<OpenCashDrawerScreenController>()) {
      Get.delete<OpenCashDrawerScreenController>();
    }
    if (Get.isRegistered<DetailsScreenController>()) {
      Get.delete<DetailsScreenController>();
    }
    super.onClose();
  }

  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  Rx<ConfigurationResponse> mConfigurationResponse =
      ConfigurationResponse().obs;

  void getAllDetails() async {
    mConfigurationResponse.value =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    mConfigurationResponse.refresh();
  }

  onDeleteHoldSale() {
    mDashboardScreenController.onUpdate(() async {}, updateHoldSale: () async {
      if (Get.isRegistered<ShiftDetailsController>()) {
        sMessage.value = "Loading...";
        sMessage.refresh();
        postShiftDetailsApiCall();
      }
    });
  }

  RxBool isShiftClose = false.obs;
  RxString sLoading = "Loading...".obs;
  RxString sMessage = "Loading...".obs;
  Rx<ShiftDetailsResponse> mShiftDetailsResponse = ShiftDetailsResponse().obs;

  ///postShiftDetailsApiCall
  void postShiftDetailsApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
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
        var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
        Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel =
            Rxn<PlaceOrderSaleModel>();
        mPlaceOrderSaleModel.value =
            await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
                PlaceOrderSaleModel();
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          mShiftDetailsResponse.value = mWebResponseSuccess.data;

          isShiftClose.value =
              mShiftDetailsResponse.value.data?.hasPendingPayments ?? false;
          if (isShiftClose.value) {
            sMessage.value =
                "Please ensure all the tables are cleared and/or no outstanding orders before performing the shift close.";
            AppAlert.showCustomDialogOk(Get.context!, 'Alert',
                'Please ensure all the tables are cleared and/or no outstanding orders before performing the shift close.',
                onCall: () {
              // mDashboardScreenController.selectMenu.value = 2;
              // mDashboardScreenController.deleteController();
            });
          }
          // else if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? [])
          //     .isNotEmpty) {
          //   sMessage.value =
          //       "Please complete your sale then you can go for shift close2";
          // }
          else if (getInValue(
                  mDashboardScreenController.mTobBarModel[3].value) >
              0) {
            sMessage.value =
                "Please clear all hold sale then you can go for shift close";
            AppAlert.showCustomDialogOk(Get.context!, 'Alert',
                'Please clear all hold sale then you can go for shift close',
                onCall: () async {
              // await AppAlert.showView(Get.context!, const HoldSalesScreen(),
              //     barrierDismissible: true);
              // bool isCancel = false;
              // if (Get.isRegistered<HoldSalesController>()) {
              //   isCancel = Get.find<HoldSalesController>().cancel.value;
              //   Get.delete<HoldSalesController>();
              // }
              // if (!isCancel) {
              //   sMessage.value = "Loading...";
              //   sMessage.refresh();
              //   postShiftDetailsApiCall();
              // }
            });
          } else {
            sMessage.value = "";
            sMessage.refresh();
          }
          sLoading.value = "";
          sLoading.refresh();
          isShiftClose.refresh();
        } else {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          sLoading.value = mWebResponseSuccess.statusMessage.toString();
          sLoading.refresh();
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
        sLoading.value = MessageConstants.noInternetConnection;
        sLoading.refresh();
      }
    });
  }

  ///calculation
  RxDouble totalCashCollected = 0.00.obs;
  RxList<CashModel> mCashModelList = <CashModel>[].obs;

  void addAmount() {
    mCashModelList.clear();
    // mCashModelList.add(CashModel(amount: 0.01, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.05, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.10, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.20, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.50, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 1.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 5.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 10.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 20.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 50.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 100.00, qty: 0, totalAmount: 0.0));
  }

  void onTextQtyChange(int index) {
    CashModel mCashModel = mCashModelList[index];
    if (mCashModel.qtyController.value.text.isEmpty) {
      mCashModelList[index].qty = 0;
      mCashModelList[index].totalAmount = 0.0;
    } else {
      mCashModelList[index].qty =
          getInValue(mCashModel.qtyController.value.text);
      mCashModelList[index].totalAmount = getDoubleValue(
          (mCashModelList[index].qty ?? 0) *
              (mCashModelList[index].amount ?? 1));
    }
    mCashModelList.refresh();

    totalCalculate();
  }

  void totalCalculate() {
    double value = 0.0;
    for (CashModel mCashModel in mCashModelList ?? []) {
      value = value + (mCashModel.totalAmount ?? 0);
    }
    totalCashCollected.value = value;
    totalCashCollected.refresh();
    isCheckTotalAmount();
  }

  RxBool isCheckAmount = false.obs;

  isCheckTotalAmount() {
    isCheckAmount.value = false;
    if (totalCashCollected.value > 0) {
      if (totalCashCollected.value ==
          getDoubleValue(mShiftDetailsResponse.value.data?.cashPayment ?? 0)) {
        isCheckAmount.value = true;
      }
    }
    isCheckAmount.refresh();
  }

  calculateAmount(String amount) async {
    double calculateAmount = getDoubleValue(amount);
    List<CashCounter> mCashCounterList = [];
    if (calculateAmount > 0) {
      for (CashModel mCashModel in mCashModelList ?? []) {
        if ((mCashModel.qty ?? 0) > 0) {
          CashCounter mCashCounter = CashCounter(
              denomination: mCashModel.amount.toString(),
              quantity: mCashModel.qty);
          mCashCounterList.add(mCashCounter);
        }
      }
    }
    if (!isCheckAmount.value && reasonController.value.text.isEmpty) {
      AppAlert.showSnackBar(Get.context!,
          'cash payment not match. Please check cash from your cash drawer or put your reason');
    } else {
      closeBalanceApiCall(amount, mCashCounterList);
    }
    // }
    // else {
    //   AppAlert.showSnackBar(Get.context!, 'please select the calculate amount');
    // }
  }

  ///closeBalanceApiCall
  void closeBalanceApiCall(String amount, List<CashCounter> mCashCounterList) {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        var configurationLocalApi = locator.get<ConfigurationLocalApi>();
        ConfigurationResponse mConfigurationResponse =
            await configurationLocalApi.getConfigurationResponse() ??
                ConfigurationResponse();
        String sUserId = await SharedPrefs().getUserId();
        String sHistoryID = await SharedPrefs().getHistoryID();
        final localApi = locator.get<BalanceApi>();
        ClosingBalanceRequest mClosingBalanceRequest = ClosingBalanceRequest(
            branchID: (mConfigurationResponse.configurationData?.branchData ?? [])
                    .isEmpty
                ? ""
                : (mConfigurationResponse.configurationData?.branchData ?? [])
                    .first
                    .branchIDP,
            counterID: (mConfigurationResponse.configurationData?.counterData ?? [])
                    .isEmpty
                ? ""
                : (mConfigurationResponse.configurationData?.counterData ?? [])
                    .first
                    .counterIDP,
            userID: sUserId,
            historyIDP: sHistoryID,
            newClosingBalance: amount,
            closingBalanceDateTime: getUTCValue(DateTime.now()),
            currency:
                mDashboardScreenController.mCurrencyData.currencyCode ?? '',
            remark: reasonController.value.text,
            cashJson: CashJson(cashCounter: mCashCounterList),
            originalBalance:
                getDoubleValue(mShiftDetailsResponse.value.data?.cashPayment ?? 0)
                    .toString(),
            isMismatchBalance: getDoubleValue(getDoubleValue(
                        mShiftDetailsResponse.value.data?.cashPayment ?? 0) -
                    getDoubleValue(totalCashCollected.value))
                .toStringAsFixed(2));

        ///print
        // await onPrintShiftClose(amount, mClosingBalanceRequest,mCashModelList);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdateClosingBalance(mClosingBalanceRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');

          ///print
          await onPrintShiftClose(
              amount, mClosingBalanceRequest, mCashModelList);

          ///open counter
          openCounter();
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

  void sPrintOpeningBalance() async {
    // await onPrintShiftClose("0.0", ClosingBalanceRequest(),mCashModelList);
    await onPrintShiftClose((mShiftDetailsResponse.value.data?.openingBalance??0.0).toString(), ClosingBalanceRequest(), []);
  }

  onPrintShiftClose(String amount, ClosingBalanceRequest mClosingBalanceRequest,
      List<CashModel> mCashModelList) async {
    final myPrinterService = locator.get<MyPrinterService>();
    await myPrinterService.shiftDetailsOpeningBalance(
        amount,
        mClosingBalanceRequest,
        mCashModelList,
        mConfigurationResponse.value,
        mShiftDetailsResponse.value);
  }
}
