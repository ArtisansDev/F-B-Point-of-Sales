// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/database/offline_place_order/offline_place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_place/process_multiple_orders_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
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
  Rxn<OrderPlace> mOrderPlacePrint = Rxn<OrderPlace>();
  RxBool placeOrder = false.obs;

  SelectedOrderController() {
    mSelectedOrderController.value = this;
  }

  ///Order Place from Another page
  onOrderPlaceAnotherPage() async {
    if (mDashboardScreenController.mOrderPlace.value != null) {
      mOrderPlace.value = mDashboardScreenController.mOrderPlace.value;
      remarkController.value.text = mOrderPlace.value?.remarkController ?? '';
      mOrderPlace.refresh();
      mDashboardScreenController.mOrderPlace.value = null;
    }
  }

  onSelectOrder(CartItem mCartItem) async {
    mOrderPlace.value ??= OrderPlace(cartItem: []);
    mOrderPlace.value?.cartItem?.add(mCartItem);
    placeOrder.value = true;

    ///
    debugPrint(
        "mOrderPlace add ${jsonEncode(mOrderPlace.value ?? OrderPlace())}");
    mOrderPlacePrint.value =
        OrderPlace.fromJson((mOrderPlace.value ?? OrderPlace()).toJson());

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
    placeOrder.value = false;
    mOrderPlace.value?.subTotalPrice = 0.0;
    mOrderPlace.value?.taxAmount = 0.0;
    mOrderPlace.value?.totalPrice = 0.0;

    ///subTotal
    for (CartItem mCartItem in mOrderPlace.value?.cartItem ?? []) {
      mOrderPlace.value?.subTotalPrice =
          (mOrderPlace.value?.subTotalPrice ?? 0) +
              ((mCartItem.taxPriceAmount ?? 0) * (mCartItem.count));
      if (mCartItem.placeOrder == false) {
        placeOrder.value = true;
      }
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
    mOrderPlace.value?.rounOffPrice = getDoubleValue(roundToNearestPossible(getDoubleValue(mOrderPlace.value?.totalPrice)));
    mOrderPlace.refresh();

  }

  ///cancel sale
  void onCancelSale() async {
    await AppAlert.showView(Get.context!, CancelOrderScreen(this),
        barrierDismissible: true);
    if (mDashboardScreenController.mOrderPlace.value == null ||
        (mDashboardScreenController.mOrderPlace.value?.sOrderNo ?? '')
            .isEmpty) {
      remarkController.value.text = "";
    }
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
    placeOrder.value = false;
    mOrderPlace.value = null;
    mOrderPlace.refresh();
    await mDashboardScreenController.onUpdateHoldSale();
  }

  ///place order
  void onPlaceOrder() async {
    ///local data base save
    var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
    PlaceOrderSaleModel mPlaceOrderSaleModel =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
    mOrderPlacePrint.value =
        OrderPlace.fromJson((mOrderPlace.value ?? OrderPlace()).toJson());
    List<CartItem> mCartItemList = mOrderPlace.value?.cartItem ?? [];
    if (mCartItemList.isNotEmpty) {
      List<CartItem> mSetCartItemList = [];
      for (CartItem mCartItem in mCartItemList) {
        mCartItem.placeOrder = true;
        mSetCartItemList.add(mCartItem);
      }
      mOrderPlace.value?.cartItem?.clear();
      mOrderPlace.value?.cartItem?.addAll(mSetCartItemList);
      mOrderPlace.value?.remarkController = remarkController.value.text;
      if ((mPlaceOrderSaleModel.mOrderPlace ?? []).isEmpty) {
        mPlaceOrderSaleModel =
            PlaceOrderSaleModel(mOrderPlace: [mOrderPlace.value!]);
        await mPlaceOrderSaleLocalApi.save(mPlaceOrderSaleModel);
      } else {
        await mPlaceOrderSaleLocalApi.getPlaceOrderSaleEdit(mOrderPlace.value!);
      }
      var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
      await holdSaleLocalApi
          .getHoldSaleDelete(mOrderPlace.value?.sOrderNo ?? '');

      OrderDetailList mOrderDetailList = await createOrderPlaceRequest(
          remarksController: remarkController.value.text,
          mOrderPlace: mOrderPlace.value);

      /// debugPrint("OrderDetail ----- ${jsonEncode(mOrderDetailList)}");
      ///place order print testing
      /// debugPrint("mOrderPlacePrint ----- ${jsonEncode(mOrderPlacePrint.value)}");
      /// printPlaceOrder(mOrderDetailList, mOrderPlacePrint.value ?? OrderPlace());

      await callSaveOrder(mOrderDetailList);

      ///clear data
      placeOrder.value = false;
      mOrderPlace.value = null;
      mOrderPlace.refresh();
      await mDashboardScreenController.onUpdateHoldSale();
      await mTopBarController.allOrderPlace();
      remarkController.value.text = "";
    } else {
      AppAlert.showSnackBar(Get.context!, 'Please add item in the cart');
    }
  }

  ///printPlaceOrder
  // void printPlaceOrder(
  //     OrderDetailList mOrderDetailList, OrderPlace mOrderPlace) async {
  //   final myPrinterService = locator.get<MyPrinterService>();
  //   await myPrinterService.salePlaceOrder(mOrderDetailList, mOrderPlace);
  // }

  ///Payment
  void onPayment() async {
    await AppAlert.showView(
        Get.context!,
        PaymentScreen(
          mOrderPlace.value ?? OrderPlace(),
          onPayment: (GetAllPaymentTypeData mSelectPaymentType,
              GetAllCustomerList? mSelectCustomer) async {
            Get.back();
            if (mSelectCustomer != null) {
              mOrderPlace.value?.mSelectCustomer = mSelectCustomer;
            }

            ///selectPayment type
            debugPrint(
                "mSelectPaymentType ----- ${jsonEncode(mSelectPaymentType)}");

            ///mOrderDetailList
            OrderDetailList mOrderDetailList = await createOrderPlaceRequest(
                remarksController: remarkController.value.text,
                mOrderPlace: mOrderPlace.value,
                printOrderPayment: mSelectPaymentType);
            debugPrint("OrderDetail ----- ${jsonEncode(mOrderDetailList)}");

            ///printOrderPayment
            /// await printOrderPayment(
            ///     mOrderDetailList, mOrderPlacePrint.value ?? OrderPlace(),
            ///     placeOrder: placeOrder.value, isPayment: true);
            ///
            /// var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
            /// await mPlaceOrderSaleLocalApi
            ///     .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');

            await callSaveOrder(mOrderDetailList, isPayment: true);
            placeOrder.value = false;
            mOrderPlace.value = null;
            mOrderPlace.refresh();
            await mDashboardScreenController.onUpdateHoldSale();
            await mTopBarController.allOrderPlace();
            remarkController.value.text = "";
            ///
          },
        ),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }

  ///SaveOrder
  callSaveOrder(OrderDetailList mOrderDetailList,
      {bool isPayment = false}) async {
    try {
      ///api product call
      final orderPlaceApi = locator.get<OrderPlaceApi>();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        ProcessMultipleOrdersRequest mProcessMultipleOrdersRequest =
        ProcessMultipleOrdersRequest(orderDetailList: [mOrderDetailList]);
        if (isInternetAvailable) {
          WebResponseSuccess mWebResponseSuccess =
              await orderPlaceApi.postOrderPlace(mProcessMultipleOrdersRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            ///print....
            await printOrderPayment(
                mOrderDetailList, mOrderPlacePrint.value ?? OrderPlace(),
                placeOrder: placeOrder.value, isPayment: isPayment);

            ///remove from local data base
            if (isPayment) {
              var mPlaceOrderSaleLocalApi =
                  locator.get<PlaceOrderSaleLocalApi>();
              await mPlaceOrderSaleLocalApi
                  .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
            }
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
          } else {

              ///offline save
              var mOfflinePlaceOrderSaleLocalApi =
                  locator.get<OfflinePlaceOrderSaleLocalApi>();
              ProcessMultipleOrdersRequest mProcessMultipleOrders =
                  await mOfflinePlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
                      ProcessMultipleOrdersRequest();
              if ((mProcessMultipleOrders.orderDetailList ?? []).isEmpty) {
                await mOfflinePlaceOrderSaleLocalApi
                    .save(mProcessMultipleOrdersRequest);
              } else {
                if ((mProcessMultipleOrdersRequest.orderDetailList ?? [])
                    .isNotEmpty) {
                  await mOfflinePlaceOrderSaleLocalApi.getPlaceOrderAdd(
                      (mProcessMultipleOrdersRequest.orderDetailList ?? [])
                          .first);
                }
              }
              if (isPayment) {
              ///remove
              var mPlaceOrderSaleLocalApi =
                  locator.get<PlaceOrderSaleLocalApi>();
              await mPlaceOrderSaleLocalApi
                  .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
            }
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
          }
        } else {
          ///offline save
          var mOfflinePlaceOrderSaleLocalApi =
          locator.get<OfflinePlaceOrderSaleLocalApi>();
          ProcessMultipleOrdersRequest mProcessMultipleOrders =
              await mOfflinePlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
                  ProcessMultipleOrdersRequest();
          if ((mProcessMultipleOrders.orderDetailList ?? []).isEmpty) {
            await mOfflinePlaceOrderSaleLocalApi
                .save(mProcessMultipleOrdersRequest);
          } else {
            if ((mProcessMultipleOrdersRequest.orderDetailList ?? [])
                .isNotEmpty) {
              await mOfflinePlaceOrderSaleLocalApi.getPlaceOrderAdd(
                  (mProcessMultipleOrdersRequest.orderDetailList ?? [])
                      .first);
            }
          }
          if (isPayment) {
            ///remove
            var mPlaceOrderSaleLocalApi =
            locator.get<PlaceOrderSaleLocalApi>();
            await mPlaceOrderSaleLocalApi
                .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');
          }
          AppAlert.showSnackBar(
              Get.context!, MessageConstants.noInternetConnection);
        }
      });
    } catch (e) {
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }

  printOrderPayment(OrderDetailList mOrderDetailList, OrderPlace mOrderPlace,
      {bool placeOrder = false, bool isPayment = false}) async {
    final myPrinterService = locator.get<MyPrinterService>();
    if (placeOrder) {
      await myPrinterService.salePlaceOrder(mOrderDetailList, mOrderPlace);
    }
    if (isPayment) {
      await myPrinterService.saleOrderPayment(mOrderDetailList, mOrderPlace);
    }
  }
}
