// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
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

  void onPayment() async {
    await AppAlert.showView(
        Get.context!, PaymentScreen(mOrderPlace.value ?? OrderPlace()),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
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

  @override
  void onClose() {
    ///delete all sub Controller
    super.onClose();
  }

  void onCancelSale() async {
    await AppAlert.showView(Get.context!, CancelOrderScreen(this),
        barrierDismissible: true);
    if (Get.isRegistered<CancelOrderController>()) {
      Get.delete<CancelOrderController>();
    }
  }

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
}
