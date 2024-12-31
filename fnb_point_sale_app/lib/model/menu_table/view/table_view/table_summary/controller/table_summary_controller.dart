// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/offline_place_order/offline_place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/order_place/process_multiple_orders_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/order_place/order_place_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/tracking_order_id.dart';
import 'package:get/get.dart';
import '../../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../../dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../../payment_screen/view/payment_screen.dart';
import '../../../../controller/table_controller.dart';

class TableSummaryController extends GetxController {
  DashboardScreenController mDashboardScreenController = Get.find<DashboardScreenController>();
  TopBarController mTopBarController = Get.find<TopBarController>();
  TableController mTableController = Get.find<TableController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rx<OrderPlace> mOrderPlace = OrderPlace().obs;

  TableSummaryController(OrderPlace mOrder) {
    mOrderPlace.value = mOrder;
    remarkController.value.text = mOrderPlace.value.remarkController??'' ;
  }

  void addMore() {
    mDashboardScreenController.mOrderPlace.value =
        mOrderPlace.value;
    Get.back();
    mDashboardScreenController.selectMenu.value = 0;
    mDashboardScreenController.selectMenu.refresh();
  }

  ///Payment
  void onPayment() async {
    await AppAlert.showView(
        Get.context!,
        PaymentScreen(
          mOrderPlace.value ?? OrderPlace(),
          onPayment: (GetAllPaymentTypeData mSelectPaymentType) async {
            ///PaymentScreenController close
            Get.back();
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
            // await printOrderPayment(mOrderDetailList);
            //
            // var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
            // await mPlaceOrderSaleLocalApi
            //     .getPlaceOrderDelete(mOrderDetailList.trackingOrderID ?? '');

            await callSaveOrder(mOrderDetailList,isPayment: true);


            mDashboardScreenController.onUpdateHoldSale();
            mTopBarController.allOrderPlace();
            mTableController.onUpdateViewTable();

            ///TableSummaryController close
            Get.back();
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
        if (isInternetAvailable) {
          ProcessMultipleOrdersRequest mProcessMultipleOrdersRequest =
          ProcessMultipleOrdersRequest(orderDetailList: [mOrderDetailList]);
          WebResponseSuccess mWebResponseSuccess =
          await orderPlaceApi.postOrderPlace(mProcessMultipleOrdersRequest);
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            ///print....
            printOrderPayment(mOrderDetailList);

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
            ///off line save
            if (isPayment) {
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
          AppAlert.showSnackBar(
              Get.context!, MessageConstants.noInternetConnection);
        }
      });
    } catch (e) {
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }

  printOrderPayment(OrderDetailList mOrderDetailList) async {
    final myPrinterService = locator.get<MyPrinterService>();
      await myPrinterService.saleOrderPayment(mOrderDetailList);
  }
}
