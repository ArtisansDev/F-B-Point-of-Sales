///partha paul
///create_order_place_request
///31/12/24

import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../data/local/database/configuration/configuration_local_api.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/configuration/configuration_response.dart';
import '../data/mode/customer/get_all_customer/get_all_customer_response.dart';
import '../data/mode/order_history/order_history_response.dart';
import '../data/mode/order_place/process_multiple_orders_request.dart';
import '../data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import '../locator.dart';
import 'num_utils.dart';

createOrderPlaceRequestFromOrderHistory(
    {String? remarksController,
    // String? orderDate,
    OrderHistoryData? mOrderPlace,
    GetAllPaymentTypeData? printOrderPayment,
    GetAllCustomerList? mGetAllCustomerList}) async {
  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  ConfigurationResponse mConfigurationResponse =
      await configurationLocalApi.getConfigurationResponse() ??
          ConfigurationResponse();
  // String sUserId = await SharedPrefs().getUserId();

  ///trackingOrderID create
  // double totalAmount = 0.0;
  // double modifierTotal = 0.0;
  // double itemTaxTotal = 0.0;
  // double discountTotal = 0.0;
  // int quantityTotal = 0;
  List<OrderMenu> orderMenu = [];

  ///Item calculation
  for (OrderHistoryMenu mCartItem in mOrderPlace?.orderMenu ?? []) {
    ///Item add
    OrderMenu mOrderMenu = OrderMenu(
        menuItemIDF: mCartItem.menuItemIDF,
        variantIDF: mCartItem.variantIDF,
        itemName: mCartItem.itemName,
        quantity: (mCartItem.quantity ?? 0),

        ///variant
        variantPrice: mCartItem.variantPrice,
        itemVariantName: mCartItem.itemVariantName,
        itemTotal: mCartItem.itemTotal,
        itemDiscountPrice: mCartItem.itemDiscountPrice,
        discountedItemAmount: mCartItem.discountedItemAmount,
        itemDiscountPriceTotal: mCartItem.itemDiscountPriceTotal,
        discountPercentage: mCartItem.discountPercentage,
        discountedItemTotalAmount: mCartItem.discountedItemTotalAmount,

        ///Modifier
        allModifierPrices: mCartItem.allModifierPrices,
        allModifierIDFs: mCartItem.allModifierIDFs,
        itemModifierTotal: mCartItem.itemModifierTotal,

        ///tax
        itemTaxPercent: mCartItem.itemTaxPercent,
        itemTaxPrice: mCartItem.itemTaxPrice,
        itemTotalTaxPrice: mCartItem.itemTotalTaxPrice,

        ///Total
        totalItemAmount: mCartItem.totalItemAmount,
        itemAdditionalNotes: mCartItem.itemAdditionalNotes
    );
    debugPrint("\nmOrderMenu:   ${jsonEncode(mOrderMenu)}\n");
    orderMenu.add(mOrderMenu);
  }

  ///subTotal calculation
  // double subTotal = totalAmount + modifierTotal + itemTaxTotal - discountTotal;

  ///tax calculation
  double taxTotal = 0.0;
  List<OrderTax> orderTaxList = [];
  for (OrderHistoryTax mTaxData in mOrderPlace?.orderTax ?? []) {
    OrderTax mOrderTax = OrderTax(
        taxIDF: mTaxData.taxIDF,
        taxName: mTaxData.taxName ?? '',
        taxPercentage: mTaxData.taxPercentage ?? 0.0,
        taxAmount: mTaxData.taxAmount);

    ///OrderPlaceRequest
    debugPrint("\ntax calculation:   ${jsonEncode(mOrderTax)}\n");
    orderTaxList.add(mOrderTax);
  }

  ///payment
  PaymentResponse mPaymentResponse = PaymentResponse();
  if (printOrderPayment != null) {
    if (printOrderPayment.paymentGatewayNo.toString() == "0") {
      mPaymentResponse = PaymentResponse(
        transactionID: "",
        paidAmount: getDoubleValue(mOrderPlace?.totalAmount),
        paymentGatewayNo: printOrderPayment.paymentGatewayNo,
        paymentStatus: "S",
        responseCode: "200",
        responseData: "",
        responseMessage: "",
      );
    }
  }

  ///customer
  if (mGetAllCustomerList == null) {
    mGetAllCustomerList = GetAllCustomerList(
      name: mOrderPlace?.name,
      phoneNumber: mOrderPlace?.phoneNumber,
      address: mOrderPlace?.address,
      email: mOrderPlace?.email,
      phoneCountryCode: mOrderPlace?.phoneCountryCode,
      customerIDP: null,
    );
  }

  /// sUserId
  String sCounterBalanceHistoryIDF = await SharedPrefs().getHistoryID();
  ///OrderPlaceRequest
  OrderDetailList mOrderDetailList = OrderDetailList(
      trackingOrderID: mOrderPlace?.trackingOrderID ?? '',
      counterIDF:
          (mConfigurationResponse.configurationData?.counterData ?? []).isEmpty
              ? ""
              : (mConfigurationResponse.configurationData?.counterData ?? [])
                  .first
                  .counterIDP,
      orderSource: (mOrderPlace?.orderSource??2).toString(),
      orderType: (mOrderPlace?.orderType??2).toString(),
      branchIDF: mOrderPlace?.branchIDF,
      userIDF: mOrderPlace?.userIDF,///mOrderPlace?.userIDF,
      restaurantIDF: mOrderPlace?.restaurantIDF,
      additionalNotes: mOrderPlace?.additionalNotes,
      orderDate: mOrderPlace?.orderDate,
      counterBalanceHistoryIDF:sCounterBalanceHistoryIDF,

      ///quantityTotal
      quantityTotal: mOrderPlace?.quantityTotal,

      ///subTotal
      itemTotal: mOrderPlace?.itemTotal,
      modifierTotal: mOrderPlace?.modifierTotal,
      itemTaxTotal: mOrderPlace?.itemTaxTotal,
      discountTotal: mOrderPlace?.discountTotal,
      subTotal: mOrderPlace?.subTotal,

      ///grandTotal
      taxAmountTotal: mOrderPlace?.taxAmountTotal,
      totalAmount: mOrderPlace?.totalAmount,
      grandTotal: mOrderPlace?.grandTotal,

      ///table no
      tableNo: mOrderPlace?.tableNo ?? '',
      seatIDF: mOrderPlace?.seatIDF,

      ///orderTax
      orderTax: orderTaxList,

      ///orderMenu
      orderMenu: orderMenu,

      ///payment_service
      paymentGatewayIDF: printOrderPayment?.paymentGatewayIDP ?? '',
      paymentGatewaySettingIDF:
          printOrderPayment?.paymentGatewaySettingIDP ?? '',
      paymentStatus: printOrderPayment == null ? "P" : "S",

      ///orderPlaceGuestInfoRequest
      paymentResponse: printOrderPayment == null ? null : [mPaymentResponse],

      ///customer
      name: mGetAllCustomerList.name,
      email: mGetAllCustomerList.email,
      phoneCountryCode: mGetAllCustomerList.phoneCountryCode,
      phoneNumber: mGetAllCustomerList.phoneNumber,
      customerIDF: mGetAllCustomerList.customerIDP);

  return mOrderDetailList;
}
