// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_place/process_multiple_orders_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:fnb_point_sale_base/utils/tracking_order_id.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import '../../../../cancel_order/controller/cancel_order_controller.dart';
import '../../../../cancel_order/view/cancel_order_screen.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/view/payment_screen.dart';
import '../../../home_base_controller/home_base_controller.dart';

class SelectedOrderController extends HomeBaseController {
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();

  SelectedOrderController() {
    mSelectedOrderController.value = this;
  }

  ///Order Place from Another page
  onOrderPlaceAnotherPage() async {
    if (mDashboardScreenController.mOrderPlace.value != null) {
      mOrderPlace.value = mDashboardScreenController.mOrderPlace.value;
      mOrderPlace.refresh();
      mDashboardScreenController.mOrderPlace.value = null;
    }
  }

  onSelectOrder(CartItem mCartItem) async {
    mOrderPlace.value ??= OrderPlace(cartItem: []);
    mOrderPlace.value?.cartItem?.add(mCartItem);

    ///getCalculateSubTotal
    getCalculateSubTotal();
  }

  ///onCalculateTotalItem value
  onCalculateTotalPricePerItem(
    int value,
    int index,
    CartItem mCartItem,
  ) {
    if (value == 0) {
      mOrderPlace.value?.cartItem?.removeAt(index);
      mOrderPlace.refresh();
      getCalculateSubTotal();
      return;
    }

    ///count
    mCartItem.count = value;

    ///total price
    mCartItem.totalPrice = getDoubleValue(
        (mCartItem.count ?? 1) * getDoubleValue(mCartItem.price));

    ///
    mOrderPlace.value?.cartItem?[index].count = value;
    mOrderPlace.value?.cartItem?[index].totalPrice = mCartItem.totalPrice;
    getCalculateSubTotal();
  }

  ///Calculate sub total
  getCalculateSubTotal() {
    mOrderPlace.value?.subTotalPrice = 0.0;
    mOrderPlace.value?.taxAmount = 0.0;
    mOrderPlace.value?.totalPrice = 0.0;

    ///subTotal
    for (CartItem mCartItem in mOrderPlace.value?.cartItem ?? []) {
      mOrderPlace.value?.subTotalPrice =
          (mOrderPlace.value?.subTotalPrice ?? 0) +
              ((mCartItem.taxPriceAmount ?? 0) * (mCartItem.count));
    }

    ///taxPrice
    for (TaxData mTaxData in mDashboardScreenController.taxData ?? []) {
      mOrderPlace.value?.taxAmount = (mOrderPlace.value?.taxAmount ?? 0.0) +
          calculatePercentageOf(
              getDoubleValue(mOrderPlace.value?.subTotalPrice ?? 0),
              getDoubleValue(mTaxData.taxPercentage));
    }

    ///TotalPrice
    mOrderPlace.value?.totalPrice = (mOrderPlace.value?.taxAmount ?? 0) +
        (mOrderPlace.value?.subTotalPrice ?? 0);
    mOrderPlace.refresh();
  }

  ///cancel sale
  void onCancelSale() async {
    await AppAlert.showView(Get.context!, CancelOrderScreen(this),
        barrierDismissible: true);
  }

  ///hold sale
  void onHoldSale() async {
    ///local data base save

    var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
    HoldSaleModel mHoldSaleModel =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();

    if ((mHoldSaleModel.mOrderPlace ?? []).isEmpty) {
      mHoldSaleModel = HoldSaleModel(mOrderPlace: [mOrderPlace.value!]);
      await holdSaleLocalApi.save(mHoldSaleModel);
    } else {
      await holdSaleLocalApi.getHoldSaleEdit(mOrderPlace.value!);
    }

    ///clear data
    mOrderPlace.value = null;
    mOrderPlace.refresh();
    mDashboardScreenController.onUpdateHoldSale();
  }

  ///place order
  void onPlaceOrder() async {
    ///local data base save
    var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

    PlaceOrderSaleModel mPlaceOrderSaleModel =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();

    List<CartItem> mCartItemList = mOrderPlace.value?.cartItem ?? [];
    if (mCartItemList.isNotEmpty) {
      List<CartItem> mSetCartItemList = [];
      for (CartItem mCartItem in mCartItemList) {
        mCartItem.placeOrder = true;
        mSetCartItemList.add(mCartItem);
      }
      mOrderPlace.value?.cartItem?.clear();
      mOrderPlace.value?.cartItem?.addAll(mSetCartItemList);
      if ((mPlaceOrderSaleModel.mOrderPlace ?? []).isEmpty) {
        mPlaceOrderSaleModel =
            PlaceOrderSaleModel(mOrderPlace: [mOrderPlace.value!]);
        await mPlaceOrderSaleLocalApi.save(mPlaceOrderSaleModel);
      } else {
        await mPlaceOrderSaleLocalApi.getPlaceOrderSaleEdit(mOrderPlace.value!);
      }
      mTopBarController.allOrderPlace();
      var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
      await holdSaleLocalApi
          .getHoldSaleDelete(mOrderPlace.value?.sOrderNo ?? '');

      OrderDetailList mOrderDetailList = await createOrderPlaceRequest(
          remarksController: remarkController.value.text,
          mOrderPlace: mOrderPlace.value);
      print("####### ${jsonEncode(mOrderDetailList)}");
      callSaveCustomer(mOrderDetailList);

      ///clear data
      // mOrderPlace.value = null;
      // mOrderPlace.refresh();
      // mDashboardScreenController.onUpdateHoldSale();
    } else {
      AppAlert.showSnackBar(Get.context!, 'Please add item in the cart');
    }
  }

  ///Payment
  void onPayment() async {
    await AppAlert.showView(
        Get.context!, PaymentScreen(mOrderPlace.value ?? OrderPlace()),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }

  void callSaveCustomer(OrderDetailList mOrderDetailList) async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();

      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          ProcessMultipleOrdersRequest mProcessMultipleOrdersRequest =
              ProcessMultipleOrdersRequest(orderDetailList: [mOrderDetailList]);
          WebResponseSuccess mWebResponseSuccess =
              await orderPlaceApi.postOrderPlace(mProcessMultipleOrdersRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
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
