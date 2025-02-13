// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/database/menu_item/menu_item_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/modifier/modifier_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/offline_place_order/offline_place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/local/database/variant/variant_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_place/process_multiple_orders_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/table_status_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:fnb_point_sale_base/utils/tracking_order_id.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import '../../../../../common_view/table_drop_down.dart';
import '../../../../cancel_order/view/cancel_order_screen.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/payment_type/credit_card_view/controller/credit_card_view_controller.dart';
import '../../../../payment_screen/payment_type/credit_card_view/view/credit_card_view.dart';
import '../../../../payment_screen/payment_type/debit_card_view/controller/debit_card_view_controller.dart';
import '../../../../payment_screen/payment_type/debit_card_view/view/debit_card_view.dart';
import '../../../../payment_screen/payment_type/qr_code_view/controller/qr_view_controller.dart';
import '../../../../payment_screen/payment_type/qr_code_view/view/qr_view.dart';
import '../../../../payment_screen/view/payment_screen.dart';
import '../../../home_base_controller/home_base_controller.dart';

class SelectedOrderController extends HomeBaseController {
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();
  Rxn<OrderPlace> mOrderPlaceHistory = Rxn<OrderPlace>();
  Rxn<OrderPlace> mOrderPlacePrint = Rxn<OrderPlace>();
  RxBool placeOrder = false.obs;
  RxBool isOrderHistory = false.obs;

  SelectedOrderController() {
    mSelectedOrderController.value = this;

    mOrderPlace.value = null;
    mOrderPlaceHistory.value = null;
    mOrderPlacePrint.value = null;

    placeOrder.value = false;
    isOrderHistory.value = false;
  }

  ///Order Place from Another page
  onOrderPlaceAnotherPage() async {
    if (mDashboardScreenController.mOrderPlace.value != null) {
      mOrderPlace.value = mDashboardScreenController.mOrderPlace.value;
      remarkController.value.text = mOrderPlace.value?.remarkController ?? '';
      mOrderPlace.refresh();
      getCalculateSubTotal();
      isOrderHistory.value = true;
      mDashboardScreenController.mOrderPlace.value = null;
    } else if (mDashboardScreenController.mOrderHistoryPlace.value != null) {
      isOrderHistory.value = true;
      mOrderPlace.value = OrderPlace();
      mOrderPlace.value?.tableNo =
          mDashboardScreenController.mOrderHistoryPlace.value?.tableNo ?? '';
      remarkController.value.text = mDashboardScreenController
              .mOrderHistoryPlace.value?.additionalNotes ??
          '';
      mOrderPlace.value?.seatIDP =
          mDashboardScreenController.mOrderHistoryPlace.value?.seatIDF ?? '';
      mOrderPlace.value?.sOrderNo = mDashboardScreenController
              .mOrderHistoryPlace.value?.trackingOrderID ??
          '';
      mOrderPlace.value?.dateTime = getUTCToLocalDateTimeCart(
          mDashboardScreenController.mOrderHistoryPlace.value?.orderDate ?? '');

      debugPrint(
          "mOrderHistoryMenu ${(mDashboardScreenController.mOrderHistoryPlace.value?.orderMenu ?? []).length}");

      ///cartItem
      mOrderPlace.value?.cartItem = [];
      for (OrderHistoryMenu mOrderHistoryMenu
          in mDashboardScreenController.mOrderHistoryPlace.value?.orderMenu ??
              []) {
        debugPrint("mOrderHistoryMenu ${jsonEncode(mOrderHistoryMenu)}");
        try {
          var localMenuItemApi = locator.get<MenuItemLocalApi>();
          MenuItemData? mMenuItemData =
              await localMenuItemApi.getMenuItemSearch(
                  mOrderHistoryMenu.menuItemIDF.toString().toLowerCase());
          debugPrint("mMenuItemData ${jsonEncode(mMenuItemData)}");
          if (mMenuItemData != null) {
            ///Variant list
            var localVariantApi = locator.get<VariantLocalApi>();
            List<VariantListData> mVariantListData = [];
            mVariantListData.addAll(await localVariantApi
                    .getVariantList(mMenuItemData.menuItemIDP ?? '') ??
                []);

            ///selectVariantListData
            VariantListData selectVariantListData = mVariantListData.firstWhere(
                (user) =>
                    user.variantIDP.toString().toLowerCase() ==
                    (mOrderHistoryMenu.variantIDF ?? '').toLowerCase());

            debugPrint(
                "selectVariantListData ${jsonEncode(selectVariantListData)}");

            ///ModifierList list
            var localModifierApi = locator.get<ModifierLocalApi>();
            List<ModifierList> mModifierListData = [];
            mModifierListData.addAll(await localModifierApi
                    .getModifierList(mMenuItemData.modifierIDs ?? []) ??
                []);

            ///select ModifierList list
            List<ModifierList> mSelectModifierListData = [];

            if ((mOrderHistoryMenu.allModifierIDFs ?? '').isNotEmpty) {
              List<String>? mSelectModifierIDFs =
                  (mOrderHistoryMenu.allModifierIDFs ?? '').split(',');
              if ((mSelectModifierIDFs ?? []).isNotEmpty &&
                  mModifierListData.isNotEmpty) {
                for (String sModifierIDF in mSelectModifierIDFs) {
                  ModifierList getModifier = mModifierListData.firstWhere(
                      (user) =>
                          user.modifierIDP.toString().toLowerCase() ==
                          sModifierIDF.toLowerCase());
                  if (getModifier.modifierIDP != null) {
                    mSelectModifierListData.add(getModifier);
                  }
                }
              }
            }

            ///create mCartItem
            CartItem mCartItem = CartItem(
                mMenuItemData: mMenuItemData,
                mVariantListData: mVariantListData,
                mSelectVariantListData: selectVariantListData,
                mModifierList: mModifierListData,
                mSelectModifierList: mSelectModifierListData);
            mCartItem.count = mOrderHistoryMenu.quantity ?? 1;
            mCartItem = onCalculateTotal(mCartItem);
            mCartItem.textRemarks = mOrderHistoryMenu.itemAdditionalNotes ?? '';
            mCartItem.placeOrder = true;
            debugPrint("mCartItem ${jsonEncode(mCartItem)}");
            mOrderPlace.value?.cartItem?.add(mCartItem);
          }
          getCalculateSubTotal();
          debugPrint("mOrderPlace ${jsonEncode(mOrderPlace.value)}");
          mOrderPlaceHistory.value =
              OrderPlace.fromJson(mOrderPlace.value!.toJson());
          debugPrint(
              "mOrderPlaceHistory ${jsonEncode(mOrderPlaceHistory.value)}");
          placeOrder.value = false;
        } catch (e) {
          debugPrint("exception ${e.toString()}");
        }
      }
    }
  }

  ///onCalculateTotal
  onCalculateTotal(CartItem mCartItem) {
    ///Variant
    mCartItem.price =
        (mCartItem.mSelectVariantListData?.discountPercentage ?? 0.0) > 0
            ? mCartItem.mSelectVariantListData?.discountedPrice ?? 0.0
            : mCartItem.mSelectVariantListData?.price ?? 0.0;

    ///tax
    mCartItem.taxAmount = 0.0;
    if ((mCartItem.mMenuItemData?.itemTaxPercent ?? 0) > 0) {
      mCartItem.taxAmount = calculatePercentageOf(mCartItem.price ?? 0,
          getDoubleValue((mCartItem.mMenuItemData?.itemTaxPercent ?? 0)));
    }

    ///Modifier
    mCartItem.priceModifier = 0.0;
    for (ModifierList mModifierList in mCartItem.mSelectModifierList ?? []) {
      mCartItem.priceModifier = (mCartItem.priceModifier ?? 0) +
          ((mModifierList.price ?? 0) * (mModifierList.count ?? 1));
    }

    ///price
    mCartItem.price = (mCartItem.price ?? 0) + (mCartItem.priceModifier ?? 0.0);

    mCartItem.taxPriceAmount =
        (mCartItem.price ?? 0) + (mCartItem.taxAmount ?? 0);

    ///total price
    mCartItem.totalPrice = getDoubleValue(
        (mCartItem.count ?? 1) * getDoubleValue(mCartItem.taxPriceAmount));

    return mCartItem;
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
      // if (mCartItem.placeOrder == false) {
      placeOrder.value = true;
      // }
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
    mOrderPlace.value?.rounOffPrice = getDoubleValue(
        roundToNearestPossible(getDoubleValue(mOrderPlace.value?.totalPrice)));
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

      ///History.value
      mOrderPlaceHistory.value = null;
      isOrderHistory.value = false;
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
    isOrderHistory.value = false;
    placeOrder.value = false;
    mOrderPlace.value = null;
    mOrderPlace.refresh();
    await mDashboardScreenController.onUpdateHoldSale();
  }

  ///place order
  void onPlaceOrder() async {
    // if (isOrderHistory.value) {
    //   debugPrint("## mOrderPlace ## ${jsonEncode(mOrderPlace.value)}");
    //   debugPrint(
    //       "## mOrderPlaceHistory ## ${jsonEncode(mOrderPlaceHistory.value)}");
    // }

    ///local data base save
    var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
    PlaceOrderSaleModel mPlaceOrderSaleModel =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
    mOrderPlacePrint.value =
        OrderPlace.fromJson((mOrderPlace.value ?? OrderPlace()).toJson());
    List<CartItem> mCartItemList = mOrderPlace.value?.cartItem ?? [];

    ///select table
    // if (!isOrderHistory.value) {
    await callUpdateTableStatus(mOrderPlacePrint.value ?? OrderPlace());
    // }

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
          mOrderPlace: mOrderPlace.value,
          mOrderHistoryData:
              mDashboardScreenController.mOrderHistoryPlace.value);

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

      ///History value
      mOrderPlaceHistory.value = null;
      isOrderHistory.value = false;
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
    await AppAlert.showViewWithoutBlur(
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
            switch (mSelectPaymentType.paymentGatewayNo) {
              case "5":

                ///Debit Card
                await AppAlert.showViewWithoutBlur(Get.context!, DebitCardView(
                  onPayment: (String sValue) {
                    mSelectPaymentType.setRequestData(sValue);
                  },
                ));
                if (Get.isRegistered<DebitCardViewController>()) {
                  await Get.delete<DebitCardViewController>();
                }
                break;
              case "6":

                ///Credit Card
                await AppAlert.showViewWithoutBlur(Get.context!, CreditCardView(
                  onPayment: (String sValue) {
                    mSelectPaymentType.setRequestData(sValue);
                  },
                ));
                if (Get.isRegistered<CreditCardViewController>()) {
                  await Get.delete<CreditCardViewController>();
                }
                break;
              case "7":

                ///Qr code
                await AppAlert.showViewWithoutBlur(
                    Get.context!,
                    QrView(
                      mSelectPaymentType: mSelectPaymentType,
                      onPayment: (String sValue) {
                        mSelectPaymentType.setRequestData(sValue);
                      },
                    ));
                if (Get.isRegistered<QrViewController>()) {
                  await Get.delete<QrViewController>();
                }
                break;
            }
            debugPrint(
                "## mSelectPaymentType ----- ${jsonEncode(mSelectPaymentType)}");

            ////
            if ((mSelectPaymentType.paymentGatewayNo == "5" ||
                    mSelectPaymentType.paymentGatewayNo == "7" ||
                    mSelectPaymentType.paymentGatewayNo == "6") &&
                mSelectPaymentType.requestData == 'Cancel') {
              return;
            }

            ///remove hold sale
            var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
            await holdSaleLocalApi
                .getHoldSaleDelete(mOrderPlace.value?.sOrderNo ?? '');

            ///mOrderDetailList
            OrderDetailList mOrderDetailList = await createOrderPlaceRequest(
                remarksController: remarkController.value.text,
                mOrderPlace: mOrderPlace.value,
                printOrderPayment: mSelectPaymentType,
                mOrderHistoryData:
                    mDashboardScreenController.mOrderHistoryPlace.value);
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

            ///History value
            mOrderPlaceHistory.value = null;
            isOrderHistory.value = false;

            ///clear table
            if ((mOrderDetailList.seatIDF ?? '').isNotEmpty) {
              TablesByTableStatusData mTablesByTableStatusData =
                  TablesByTableStatusData(
                occupiedOrderID: mOrderDetailList.trackingOrderID ?? '',
                seatIDP: mOrderDetailList.seatIDF ?? '',
              );
              await callUpdateTableStatusAvailable(mTablesByTableStatusData);
            }
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
                  (mProcessMultipleOrdersRequest.orderDetailList ?? []).first);
            }
          }
          if (isPayment) {
            ///remove
            var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
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

  ///update table status
  callUpdateTableStatus(OrderPlace mOrderPlace) async {
    ///api product call
    final orderPlaceApi = locator.get<OrderPlaceApi>();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        TableStatusRequest mTableStatusRequest = TableStatusRequest(
            trackingOrderID: mOrderPlace.sOrderNo ?? '',
            tableStatus: 'O',
            seatIDP: mOrderPlace.seatIDP,
            userIDF: await SharedPrefs().getUserId());

        WebResponseSuccess mWebResponseSuccess =
            await orderPlaceApi.postTableStatus(mTableStatusRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          // onPlaceOrder();
        } else {
          // AppAlert.showSnackBar(
          //     Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        // AppAlert.showSnackBar(
        //     Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  ///update table status Available
  callUpdateTableStatusAvailable(
      TablesByTableStatusData mTablesByTableStatusData) async {
    ///api product call
    final orderPlaceApi = locator.get<OrderPlaceApi>();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        TableStatusRequest mTableStatusRequest = TableStatusRequest(
            trackingOrderID:
                mTablesByTableStatusData.occupiedTrackingOrderID ?? '',
            tableStatus: 'A',
            seatIDP: mTablesByTableStatusData.seatIDP,
            userIDF: await SharedPrefs().getUserId());

        WebResponseSuccess mWebResponseSuccess =
            await orderPlaceApi.postTableStatus(mTableStatusRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          await mTopBarController.callGetAllTableStatus();
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

  printOrderPayment(OrderDetailList mOrderDetailList, OrderPlace mOrderPlace,
      {bool placeOrder = false, bool isPayment = false}) async {
    final myPrinterService = locator.get<MyPrinterService>();
    if (placeOrder) {
      await myPrinterService.salePlaceOrder(mOrderDetailList, mOrderPlace);
      await myPrinterService.salePlaceOrder(mOrderDetailList, mOrderPlace);
    }
    if (isPayment) {
      await myPrinterService.saleOrderPayment(mOrderDetailList, mOrderPlace);
    }
  }

  ///select table
  void selectTable() async {
    await showTableBottomSheet(mTopBarController.mGetAllTablesList.toList(),
        (mTopBarController.mGetAllTablesStatus.value?.data ?? []).toList(),
        (GetAllTablesResponseData value) {
      mOrderPlace.value?.seatIDP = value.seatIDP ?? '--';
      mOrderPlace.value?.tableNo = value.seatNumber ?? '--';
      mOrderPlace.refresh();
    });
  }
}
