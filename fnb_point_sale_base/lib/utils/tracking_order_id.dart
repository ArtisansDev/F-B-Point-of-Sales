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
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../data/local/database/configuration/configuration_local_api.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/cart_item/cart_item.dart';
import '../data/mode/cart_item/order_place.dart';
import '../data/mode/configuration/configuration_response.dart';
import '../data/mode/order_place/process_multiple_orders_request.dart';
import '../data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../locator.dart';
import 'date_time_utils.dart';
import 'num_utils.dart';

// String getTrackingOrderID(
//     String userIDF, String restaurentIDP, String branchIDF) {
//   final combinedString =
//       '$userIDF$restaurentIDP$branchIDF${DateTime.now().millisecondsSinceEpoch}';
//   final bytes = utf8.encode(combinedString);
//   final digest = sha1.convert(bytes);
//   return digest.toString();
// }

createOrderPlaceRequest({
  String? remarksController,
  // String? orderDate,
  OrderPlace? mOrderPlace,
  // PaymentTypeResponseData? mPaymentTypeResponseData
}) async {
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
                subModifierTotal);
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

  ///OrderPlaceRequest
  OrderDetailList mOrderDetailList = OrderDetailList(
    trackingOrderID: mOrderPlace?.sOrderNo ?? '',
    orderSource: "2",
    orderType: '1',
    branchIDF:
        (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
            ? ""
            : (mConfigurationResponse.configurationData?.branchData ?? [])
                .first
                .branchIDP,
    userIDF: sUserId.toString(),
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
    totalAmount: getDoubleValue(subTotal + taxTotal),
    grandTotal: getDoubleValue(subTotal + taxTotal),

    ///table no
    tableNo: (mOrderPlace?.tableNo == '--') ? '' : mOrderPlace?.tableNo,
    seatIDF: (mOrderPlace?.seatIDP ?? ""),

    ///payment_service
    // paymentGatewayID: mPaymentTypeResponseData?.paymentGatewayIDP ?? '',
    // paymentGatewaySettingID:
    //     mPaymentTypeResponseData?.paymentGatewaySettingIDP ?? '',

    ///orderTax
    orderTax: orderTaxList,

    ///orderMenu
    orderMenu: orderMenu,

    ///orderPlaceGuestInfoRequest
    // orderPlaceGuestInfoRequest: null
  );

  return mOrderDetailList;
}
