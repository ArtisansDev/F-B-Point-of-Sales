// ignore_for_file: depend_on_referenced_packages

/*
 * Project      : my_coffee
 * File         : traking_order_id.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-11
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../data/local/database/configuration/configuration_local_api.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/cart_item/cart_item.dart';
import '../data/mode/cart_item/order_place.dart';
import '../data/mode/configuration/configuration_response.dart';
import '../data/mode/customer/get_all_customer/get_all_customer_response.dart';
import '../data/mode/order_history/order_history_response.dart';
import '../data/mode/order_place/process_multiple_orders_request.dart';
import '../data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import '../locator.dart';
import 'date_time_utils.dart';
import 'num_utils.dart';

createOrderPlaceRequest(
    {String? remarksController,
    // String? orderDate,
    OrderPlace? mOrderPlace,
    OrderHistoryData? mOrderHistoryData,
    GetAllPaymentTypeData? printOrderPayment}) async {
  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  ConfigurationResponse mConfigurationResponse =
      await configurationLocalApi.getConfigurationResponse() ??
          ConfigurationResponse();
  String sUserId = await SharedPrefs().getUserId();

  ///trackingOrderID create
  double totalAmount = 0.0;
  double modifierTotal = 0.0;
  double itemTaxTotal = 0.0;
  double discountTotal = 0.0;
  int quantityTotal = 0;
  List<OrderMenu> orderMenu = [];

  ///Item calculation
  for (CartItem mCartItem in mOrderPlace?.cartItem ?? []) {
    ///original total
    var subTotalAmount = 0.0;
    subTotalAmount = (mCartItem.mSelectVariantListData?.price ?? 0);
    totalAmount = totalAmount + (subTotalAmount * (mCartItem.count ?? 0));

    ///discount
    var subDiscountTotal = 0.0;
    if ((mCartItem.mSelectVariantListData?.discountPercentage ?? 0) > 0) {
      subDiscountTotal =
          (mCartItem.mSelectVariantListData?.discountedPrice ?? 0);
      subDiscountTotal = (subTotalAmount - subDiscountTotal);
      discountTotal =
          discountTotal + (subDiscountTotal * (mCartItem.count ?? 0));

      ///new total /item
      subTotalAmount = subTotalAmount - subDiscountTotal;
    }

    ///modifier
    var subModifierTotal = 0.0;
    String allModifierIDF = '';
    String allModifierPrices = '';
    for (ModifierList mModifierData in mCartItem.mSelectModifierList ?? []) {
      subModifierTotal = subModifierTotal + (mModifierData.price ?? 0);
      allModifierIDF = '$allModifierIDF${mModifierData.modifierIDP ?? ''},';
      allModifierPrices = '$allModifierPrices${mModifierData.price ?? ''},';
    }

    if (subModifierTotal > 0) {
      subModifierTotal = subModifierTotal * (mCartItem.count ?? 0);
      allModifierIDF = allModifierIDF.substring(0, allModifierIDF.length - 1);
      allModifierPrices =
          allModifierPrices.substring(0, allModifierPrices.length - 1);
      modifierTotal = modifierTotal + subModifierTotal;
    }

    ///Item tax
    double subTotalTax = 0.0;
    if ((mCartItem.taxAmount ?? 0.0) > 0) {
      subTotalTax = mCartItem.taxAmount;
      itemTaxTotal = itemTaxTotal + (subTotalTax * (mCartItem.count ?? 0));
    }

    ///quantity
    quantityTotal = quantityTotal + (mCartItem.count ?? 0);

    ///Item add
    OrderMenu mOrderMenu = OrderMenu(
        menuItemIDF: mCartItem.mMenuItemData?.menuItemIDP ?? '',
        variantIDF: mCartItem.mSelectVariantListData?.variantIDP ?? '',
        itemName: mCartItem.mMenuItemData?.itemName ?? '',
        quantity: (mCartItem.count ?? 0),

        ///variant
        variantPrice: mCartItem.mSelectVariantListData?.price,
        itemVariantName:
            mCartItem.mSelectVariantListData?.quantitySpecification ?? '',
        itemTotal: (mCartItem.mSelectVariantListData?.price ?? 0) *
            (mCartItem.count ?? 0),
        itemDiscountPrice: mCartItem.mSelectVariantListData?.discountedPrice,
        discountedItemAmount: (mCartItem.mSelectVariantListData?.price ?? 0) -
            (mCartItem.mSelectVariantListData?.discountedPrice ?? 0),
        itemDiscountPriceTotal:
            (mCartItem.mSelectVariantListData?.discountedPrice ?? 0) *
                (mCartItem.count ?? 0),
        discountPercentage:
            mCartItem.mSelectVariantListData?.discountPercentage,
        discountedItemTotalAmount: subDiscountTotal * (mCartItem.count ?? 0),

        ///Modifier
        allModifierPrices: allModifierPrices,
        allModifierIDFs: allModifierIDF,
        itemModifierTotal: subModifierTotal,

        ///tax
        itemTaxPercent: mCartItem.mMenuItemData?.itemTaxPercent,
        itemTaxPrice: subTotalTax,
        itemTotalTaxPrice: subTotalTax * (mCartItem.count ?? 0),

        ///Total
        totalItemAmount:
            ((subTotalAmount + subTotalTax) * (mCartItem.count ?? 0)) +
                subModifierTotal,

        ///ItemAdditionalNotes
        itemAdditionalNotes: mCartItem.textRemarks);
    debugPrint("\nmOrderMenu:   ${jsonEncode(mOrderMenu)}\n");
    orderMenu.add(mOrderMenu);
  }

  ///subTotal calculation
  double subTotal = totalAmount + modifierTotal + itemTaxTotal - discountTotal;

  ///tax calculation
  double taxTotal = 0.0;
  List<OrderTax> orderTaxList = [];
  for (TaxData mTaxData
      in mConfigurationResponse.configurationData?.taxData ?? []) {
    double subTaxTotal =
        calculatePercentageOf(subTotal, mTaxData.taxPercentage ?? 0.0);
    taxTotal = taxTotal + subTaxTotal;
    OrderTax mOrderTax = OrderTax(
        taxIDF: mTaxData.taxIDP ?? '',
        taxName: mTaxData.taxName ?? '',
        taxPercentage: mTaxData.taxPercentage ?? 0.0,
        taxAmount: subTaxTotal);

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
        paidAmount: getDoubleValue(subTotal + taxTotal),
        paymentGatewayNo: printOrderPayment.paymentGatewayNo,
        paymentStatus: "S",
        responseCode: "200",
        responseData: "",
        responseMessage: "",
        requestData: "",
      );
    } else if (printOrderPayment.paymentGatewayNo.toString() == "5") {
      mPaymentResponse = PaymentResponse(
        transactionID: "",
        paidAmount: getDoubleValue(subTotal + taxTotal),
        paymentGatewayNo: printOrderPayment.paymentGatewayNo,
        paymentStatus: "S",
        responseCode: "200",
        responseData: "",
        responseMessage: "",
        requestData: "",
      );
    } else if (printOrderPayment.paymentGatewayNo.toString() == "6") {
      mPaymentResponse = PaymentResponse(
        transactionID: "",
        paidAmount: getDoubleValue(subTotal + taxTotal),
        paymentGatewayNo: printOrderPayment.paymentGatewayNo,
        paymentStatus: "S",
        responseCode: "200",
        responseData: "",
        responseMessage: "",
        requestData: "",
      );
    } else if (printOrderPayment.paymentGatewayNo.toString() == "7") {
      mPaymentResponse = PaymentResponse(
        transactionID: "",
        paidAmount: getDoubleValue(subTotal + taxTotal),
        paymentGatewayNo: printOrderPayment.paymentGatewayNo,
        paymentStatus: "S",
        responseCode: "200",
        responseData: "",
        responseMessage: "",
        requestData: "",
      );
    }
  }

  String sCounterBalanceHistoryIDF = await SharedPrefs().getHistoryID();

  double grandTotal = getDoubleValue(subTotal + taxTotal);
  double adjustedAmount = getDoubleValue(roundToNearestPossible(grandTotal));

  ///OrderPlaceRequest
  OrderDetailList mOrderDetailList = OrderDetailList(
      trackingOrderID: mOrderPlace?.sOrderNo ?? '',
      counterBalanceHistoryIDF: sCounterBalanceHistoryIDF,
      counterIDF:
          (mConfigurationResponse.configurationData?.counterData ?? []).isEmpty
              ? ""
              : (mConfigurationResponse.configurationData?.counterData ?? [])
                  .first
                  .counterIDP,
      orderSource: (mOrderHistoryData?.orderSource ?? 2).toString(),
      orderType: (mOrderHistoryData?.orderType ?? 1).toString(),
      branchIDF:
          (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
              ? ""
              : (mConfigurationResponse.configurationData?.branchData ?? [])
                  .first
                  .branchIDP,
      userIDF: (mOrderHistoryData?.userIDF ?? sUserId.toString()),
      restaurantIDF:
          (mConfigurationResponse.configurationData?.restaurantData ?? []).isEmpty
              ? ""
              : (mConfigurationResponse.configurationData?.restaurantData ?? [])
                  .first
                  .restaurantIDP,
      additionalNotes: remarksController ?? '',
      orderDate: getUTCValue(mOrderPlace!.dateTime.isEmpty
          ? DateTime.now()
          : DateFormat("dd-MM-yyyy hh:mm a").parse(mOrderPlace.dateTime)),

      ///quantityTotal
      quantityTotal: quantityTotal,

      ///subTotal
      itemTotal: totalAmount,
      modifierTotal: modifierTotal,
      itemTaxTotal: itemTaxTotal,
      discountTotal: discountTotal,
      subTotal: subTotal,

      ///grandTotal
      taxAmountTotal: getDoubleValue(taxTotal),
      totalAmount: grandTotal,
      grandTotal: grandTotal,
      adjustedAmount: grandTotal == adjustedAmount ? null : adjustedAmount,

      ///table no
      tableNo: (mOrderPlace.tableNo == '--') ? '' : mOrderPlace.tableNo,
      seatIDF: (mOrderPlace.seatIDP ?? ""),

      ///orderTax
      orderTax: orderTaxList,

      ///orderMenu
      orderMenu: orderMenu,

      ///payment_service
      paymentGatewayNo: (printOrderPayment?.paymentGatewayNo ?? '').isEmpty
          ? (mOrderHistoryData?.paymentGatewayNo ??
                  printOrderPayment?.paymentGatewayNo ??
                  '')
              .toString()
          : (printOrderPayment?.paymentGatewayNo ?? ''),
      paymentGatewayIDF: (printOrderPayment?.paymentGatewayIDP ?? '').isEmpty
          ? (mOrderHistoryData?.paymentGatewayIDF ??
              printOrderPayment?.paymentGatewayIDP ??
              '')
          : (printOrderPayment?.paymentGatewayIDP ?? ''),
      paymentGatewaySettingIDF:
          (printOrderPayment?.paymentGatewaySettingIDP ?? '').isEmpty
              ? (mOrderHistoryData?.paymentGatewaySettingIDF ??
                  printOrderPayment?.paymentGatewaySettingIDP ??
                  '')
              : (printOrderPayment?.paymentGatewaySettingIDP ?? ''),
      paymentStatus: printOrderPayment == null ? "P" : "S",
      orderStatus: printOrderPayment == null ? "A" : "P",

      ///orderPlaceGuestInfoRequest
      paymentResponse: printOrderPayment == null ? null : [mPaymentResponse],

      ///customer
      name: (mOrderHistoryData?.name ?? mOrderPlace.mSelectCustomer?.name),
      email: (mOrderHistoryData?.email ?? mOrderPlace.mSelectCustomer?.email),
      phoneCountryCode: (mOrderHistoryData?.phoneCountryCode ??
          mOrderPlace.mSelectCustomer?.phoneCountryCode),
      phoneNumber: (mOrderHistoryData?.phoneNumber ?? mOrderPlace.mSelectCustomer?.phoneNumber),
      customerIDF: (mOrderHistoryData?.userIDF ?? "").isEmpty ? mOrderPlace.mSelectCustomer?.customerIDP : "");

  return mOrderDetailList;
}
