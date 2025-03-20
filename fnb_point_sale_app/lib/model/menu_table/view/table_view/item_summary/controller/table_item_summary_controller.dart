// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../../menu_sales/view/item_payment_screen/controller/item_payment_screen_controller.dart';
import '../../../../../menu_sales/view/item_payment_screen/view/item_payment_screen.dart';
import '../../../../../payment_screen/payment_type/credit_card_view/controller/credit_card_view_controller.dart';
import '../../../../../payment_screen/payment_type/credit_card_view/view/credit_card_view.dart';
import '../../../../../payment_screen/payment_type/debit_card_view/controller/debit_card_view_controller.dart';
import '../../../../../payment_screen/payment_type/debit_card_view/view/debit_card_view.dart';
import '../../../../../payment_screen/payment_type/qr_code_view/controller/qr_view_controller.dart';
import '../../../../../payment_screen/payment_type/qr_code_view/view/qr_view.dart';
import '../../../../controller/table_controller.dart';

class TableItemSummaryController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  TableController mTableController = Get.find<TableController>();
  RxBool isOrderBottomView = true.obs;

  // MenuSalesController mMenuSalesController = Get.find<MenuSalesController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rx<OrderHistoryData> mOrderPlace = OrderHistoryData().obs;
  RxInt index = (-1).obs;

  TableItemSummaryController(OrderHistoryData mOrder, int iIndex) {
    index.value = iIndex;
    mOrderPlace.value = mOrder;
    remarkController.value.text =
        (mOrderPlace.value.additionalNotes ?? '').isEmpty
            ? 'No remark'
            : (mOrderPlace.value.additionalNotes ?? '');
    remarkController.refresh();
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
  }

  void onCancelOrder() {
    AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Cancel Order!',
        'Are you sure you want to cancel this order?', () async {
      Get.back();
      await mTableController.orderCancelPayment(mOrderPlace.value);
    }, rightText: 'Yes');
  }

  void onPayment() async {
    Get.back();
    await AppAlert.showViewWithoutBlur(
        Get.context!,
        ItemPaymentScreen(
          mOrderPlace.value,
          onPayment: (GetAllPaymentTypeData mGetAllPaymentTypeData,
              GetAllCustomerList? mGetAllCustomerList) async {
            Get.back();

            switch (mGetAllPaymentTypeData.paymentGatewayNo) {
              case "5":

                ///Debit Card
                await AppAlert.showViewWithoutBlur(Get.context!, DebitCardView(
                  onPayment: (String value) {
                    mGetAllPaymentTypeData.setRequestData(value);
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
                    mGetAllPaymentTypeData.setRequestData(value);
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
                      mSelectPaymentType: mGetAllPaymentTypeData,
                      onPayment: (String sValue) {
                        mGetAllPaymentTypeData.setRequestData(sValue);
                      },
                    ));
                if (Get.isRegistered<QrViewController>()) {
                  await Get.delete<QrViewController>();
                }
                break;
            }

            if ((mGetAllPaymentTypeData.paymentGatewayNo == "5" ||
                    mGetAllPaymentTypeData.paymentGatewayNo == "6" ||
                    mGetAllPaymentTypeData.paymentGatewayNo == "7") &&
                mGetAllPaymentTypeData.requestData == 'Cancel') {
              return;
            }

            mTableController.orderPayment(
                mGetAllPaymentTypeData, mOrderPlace.value, mGetAllCustomerList);
          },
        ),
        barrierDismissible: true);
    if (Get.isRegistered<ItemPaymentScreenController>()) {
      Get.delete<ItemPaymentScreenController>();
    }
  }

  void addMore() async {
    await allOrderPlace();

    ///get OrderPlace
    OrderPlace mSelectOrderPlace =
        getOrderPlace(mOrderPlace.value.seatIDF ?? '');

    ///
    if ((mSelectOrderPlace.sOrderNo ?? '').isNotEmpty) {
      mDashboardScreenController.value?.mOrderPlace.value =
          getOrderPlace(mOrderPlace.value.seatIDF ?? '');
      // if ((mDashboardScreenController.value?.mOrderPlace.value?.cartItem ?? [])
      //     .isNotEmpty) {
      //   mDashboardScreenController.value?.mOrderHistoryPlace.value = null;
      //   Get.back();
      //   mDashboardScreenController.value?.selectMenu.value = 0;
      //   mDashboardScreenController.value?.selectMenu.refresh();
      // } else
      {
        mDashboardScreenController.value?.mOrderPlace.value = null;
        mDashboardScreenController.value?.mOrderHistoryPlace.value =
            mOrderPlace.value;
        Get.back();
        mDashboardScreenController.value?.selectMenu.value = 0;
        mDashboardScreenController.value?.selectMenu.refresh();
      }
    }
  }

  Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
  var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

  allOrderPlace() async {
    mPlaceOrderSaleModel.value =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
  }

  OrderPlace getOrderPlace(String sSeatIDP) {
    OrderPlace mOrderPlace = OrderPlace();
    if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? []).isEmpty) {
      return mOrderPlace;
    }
    int? value = mPlaceOrderSaleModel.value?.mOrderPlace?.indexWhere(
      (element) => element.seatIDP.toString() == sSeatIDP.toString(),
    );
    if ((value ?? -1) == -1) {
      return mOrderPlace;
    } else {
      mOrderPlace =
          mPlaceOrderSaleModel.value?.mOrderPlace?[value ?? -1] ?? OrderPlace();
      return mOrderPlace;
    }
  }
}
