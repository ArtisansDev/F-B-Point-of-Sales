import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/local/database/configuration/configuration_local_api.dart';
import '../../data/mode/cart_item/cart_item.dart';
import '../../data/mode/cart_item/order_place.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/order_place/process_multiple_orders_request.dart';
import '../../data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../../locator.dart';
import '../../utils/date_time_utils.dart';

Future<bool> printOrderPayment(OrderDetailList mOrderDetailList,
    OrderPlace mOrderPlace, PrinterSettingsData? mPrinterSettingsData) async {
  CurrencyData mCurrencyData = CurrencyData();

  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  ConfigurationResponse mConfigurationResponse =
      await configurationLocalApi.getConfigurationResponse() ??
          ConfigurationResponse();
  RestaurantData mRestaurantData =
      mConfigurationResponse.configurationData?.restaurantData?.first ??
          RestaurantData();
  mCurrencyData =
      (mConfigurationResponse.configurationData?.currencyData ?? []).first;

  String branchName =
      (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
          ? ""
          : (mConfigurationResponse.configurationData?.branchData ?? [])
                  .first
                  .branchName ??
              '';

  String branchAddress =
      (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
          ? ""
          : (mConfigurationResponse.configurationData?.branchData ?? [])
                  .first
                  .branchAddress ??
              '';
  List<pw.Widget> widgets = List.empty(growable: true);

  if (mPrinterSettingsData == null) {
    widgets.add(pw.Center(
        child: pw.Text('Payment Receipt', style: getBoldTextStyleMedium())));
    widgets.add(pw.Container(height: 4));
    widgets.add(
        pw.Center(child: pw.Text(branchName, style: getBoldTextStyleMedium())));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));
    widgets.add(
        pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
    widgets.add(pw.Center(
        child: pw.Text(
            '${mRestaurantData.orderIDPrefixCode}${mOrderDetailList.trackingOrderID}',
            style: getNormalTextStyle())));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///Order Date and Time
    widgets.add(pw.Center(
        child: pw.Text('Order Date and Time', style: getBoldTextStyle())));
    widgets.add(pw.Center(
        child: pw.Text(
            '${getUTCToLocalDateTime(mOrderDetailList.orderDate.toString())}',
            style: getNormalTextStyle())));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///table
    widgets.add(getTableRow(mOrderDetailList));

    ///user details
    if ((mOrderDetailList.phoneNumber ?? '').isNotEmpty) {
      widgets.add(getUserDetailsRow(mOrderDetailList));
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///menu order
    int value = 0;
    for (OrderMenu element in (mOrderDetailList.orderMenu ?? [])) {
      CartItem mCartItem = mOrderPlace.cartItem?[value] ?? CartItem();
      widgets.add(
          getItemRow(element, mCurrencyData.currencySymbol ?? '', mCartItem));
      value++;
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///SubTotal
    widgets.add(
        getSubTotalRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 2));

    ///tax
    for (OrderTax element in (mOrderDetailList.orderTax ?? [])) {
      if ((element.taxPercentage ?? 0) > 0) {
        widgets.add(getTax(element, mCurrencyData.currencySymbol ?? ''));
        widgets.add(pw.Container(height: 2));
      }
    }

    ///Total
    widgets
        .add(getTotalRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));

    ///Rounding
    widgets.add(
        getRoundingRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));

    ///Total Pay
    widgets.add(
        getTotalPayRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///payment
    widgets.add(pw.Container(
        padding: const pw.EdgeInsets.only(left: 2.0),
        child: pw.Text('Payment Type', style: getBoldTextStyle())));
    widgets.add(pw.Container(height: 3));
    widgets.add(
        getPaymentRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///remark
    if ((mOrderDetailList.additionalNotes ?? "").isNotEmpty) {
      widgets.add(
          pw.Center(child: pw.Text('Order Remark', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text('${mOrderDetailList.additionalNotes}',
              style: getNormalTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }
    widgets.add(pw.Center(
        child:
            pw.Text(mRestaurantData.tagLine ?? '', style: getBoldTextStyle())));
  } else {
    if ((mPrinterSettingsData.enableTitleText ?? false) &&
        (mPrinterSettingsData.customTitleText ?? '').isNotEmpty) {
      widgets.add(pw.Center(
          child: pw.Text((mPrinterSettingsData.customTitleText ?? ''),
              style: getBoldTextStyleMedium())));
    } else {
      widgets.add(pw.Center(
          child: pw.Text('Payment Receipt', style: getBoldTextStyleMedium())));
    }
    widgets.add(pw.Container(height: 4));
    if ((mPrinterSettingsData.enableBranchName ?? false)) {
      widgets.add(pw.Center(
          child: pw.Text(branchName, style: getBoldTextStyleMedium())));
      widgets.add(pw.Container(height: 4));
    }
    if ((mPrinterSettingsData.enableBranchAddress ?? false)) {
      widgets.add(pw.Center(
          child: pw.Text(branchAddress,
              textAlign: pw.TextAlign.center, style: getBoldTextStyle())));
      widgets.add(pw.Container(height: 4));
    }
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));
    if ((mPrinterSettingsData.enableOrderTrackingID ?? false)) {
      widgets.add(
          pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text(
              '${mRestaurantData.orderIDPrefixCode}${mOrderDetailList.trackingOrderID}',
              style: getNormalTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }

    ///Order Date and Time
    if ((mPrinterSettingsData.enableDateTime ?? false)) {
      widgets.add(pw.Center(
          child: pw.Text('Order Date and Time', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text(
              '${getUTCToLocalDateTime(mOrderDetailList.orderDate.toString())}',
              style: getNormalTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }

    ///enableHeader
    if ((mPrinterSettingsData.enableHeader ?? false) &&
        (mPrinterSettingsData.customHeaderText ?? '').isNotEmpty) {
      widgets.add(pw.Center(
          child: pw.Text((mPrinterSettingsData.customHeaderText ?? ''),
              textAlign: pw.TextAlign.center, style: getBoldTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }

    ///table
    widgets.add(getTableRow(mOrderDetailList));

    ///user details
    if ((mOrderDetailList.phoneNumber ?? '').isNotEmpty) {
      widgets.add(getUserDetailsRow(mOrderDetailList));
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///menu order
    int value = 0;
    for (OrderMenu element in (mOrderDetailList.orderMenu ?? [])) {
      CartItem mCartItem = mOrderPlace.cartItem?[value] ?? CartItem();
      widgets.add(
          getItemRow(element, mCurrencyData.currencySymbol ?? '', mCartItem));
      value++;
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///SubTotal
    widgets.add(
        getSubTotalRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 2));

    ///tax
    for (OrderTax element in (mOrderDetailList.orderTax ?? [])) {
      if ((element.taxPercentage ?? 0) > 0) {
        widgets.add(getTax(element, mCurrencyData.currencySymbol ?? ''));
        widgets.add(pw.Container(height: 2));
      }
    }

    ///Total
    widgets
        .add(getTotalRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));

    ///Rounding
    widgets.add(
        getRoundingRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));

    ///Total Pay
    widgets.add(
        getTotalPayRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///payment
    widgets.add(pw.Container(
        padding: const pw.EdgeInsets.only(left: 2.0),
        child: pw.Text('Payment Type', style: getBoldTextStyle())));
    widgets.add(pw.Container(height: 3));
    widgets.add(
        getPaymentRow(mOrderDetailList, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///remark
    if ((mOrderDetailList.additionalNotes ?? "").isNotEmpty) {
      widgets.add(
          pw.Center(child: pw.Text('Order Remark', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text('${mOrderDetailList.additionalNotes}',
              style: getNormalTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }

    ///enableFooter
    if ((mPrinterSettingsData.enableFooter ?? false) &&
        (mPrinterSettingsData.customFooterText ?? '').isNotEmpty) {
      widgets.add(pw.Center(
          child: pw.Text((mPrinterSettingsData.customFooterText ?? ''),
              textAlign: pw.TextAlign.center, style: getBoldTextStyle())));
    }

    ///enableCustomText
    if ((mPrinterSettingsData.enableCustomText ?? false) &&
        (mPrinterSettingsData.customMessageText ?? '').isNotEmpty) {
      widgets.add(pw.Container(height: 2));
      widgets.add(pw.Center(
          child: pw.Text((mPrinterSettingsData.customMessageText ?? ''),
              textAlign: pw.TextAlign.center, style: getNormalTextStyle())));
    }
    // widgets.add(pw.Center(
    //     child:
    //     pw.Text(mRestaurantData.tagLine ?? '', style: getBoldTextStyle())));
  }

  return printWidgets(widgets, true, false);
}

///table
pw.Widget getTableRow(OrderDetailList mOrderDetailList) {
  return pw.Column(children: [
    pw.Center(
        child: pw.Text(
            ((mOrderDetailList.orderType ?? '1').toString().trim() == '1')
                ? 'Dine-In '
                : 'Take Away',
            textAlign: pw.TextAlign.center,
            style: getBoldTextStyle())),
    ((mOrderDetailList.tableNo ?? '--') != '--' &&
            (mOrderDetailList.tableNo ?? '--').isNotEmpty)
        ? pw.Row(
            children: [
              pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${sSeatingNo.tr}:-",
                          style: getNormalTextStyle()),
                    ),
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(mOrderDetailList.tableNo ?? '--',
                          style: getBoldTextStyle()),
                    ),
                  )),
            ],
          )
        : pw.SizedBox()
  ]);
}

///UserDetails
pw.Widget getUserDetailsRow(OrderDetailList mOrderDetailList) {
  return pw.Column(children: [
    pw.Row(
      children: [
        pw.Expanded(
            flex: 2,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text("${sCustomerName.tr}:-",
                    style: getNormalTextStyle()),
              ),
            )),
        pw.Expanded(
            flex: 3,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(mOrderDetailList.name ?? '--',
                    style: getBoldTextStyle()),
              ),
            )),
      ],
    ),
    pw.Row(
      children: [
        pw.Expanded(
            flex: 2,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text("${sPhoneNumber.tr}:-",
                    style: getNormalTextStyle()),
              ),
            )),
        pw.Expanded(
            flex: 3,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(mOrderDetailList.phoneNumber ?? '--',
                    style: getBoldTextStyle()),
              ),
            )),
      ],
    )
  ]);
}

///item list
pw.Widget getItemRow(OrderMenu mCartItem, String currencyData, CartItem mItem) {
  return pw.Column(children: [
    pw.Row(children: [
      pw.Expanded(
          flex: 3,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(2.0),
            child: pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(mCartItem.itemName ?? '',
                          style: getBoldTextStyle()),
                      pw.Text(
                          '${mCartItem.itemVariantName ?? ''} ${(mCartItem.discountPercentage ?? 0.0) > 0 ? '(${(mCartItem.discountPercentage ?? 0.0)})%' : ""}',
                          style: getNormalTextStyle()),
                      (mCartItem.discountPercentage ?? 0.0) > 0
                          ? pw.Row(children: [
                              pw.Text(
                                  '$currencyData ${(mCartItem.variantPrice ?? 0.0).toString()}',
                                  style: getNormalTextStyleLineThrough()),
                              pw.SizedBox(width: 3),
                              pw.Text(
                                  '$currencyData  ${(mCartItem.itemDiscountPrice ?? 0.0).toString()}',
                                  style: getBoldTextStyle()),
                            ])
                          : pw.SizedBox(
                              child: pw.Text(
                                  '$currencyData ${(mCartItem.variantPrice ?? 0.0).toString()}',
                                  style: getBoldTextStyle()),
                            )
                    ])),
          )),
      pw.Expanded(
          flex: 1,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(2.0),
            child: pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text('x${mCartItem.quantity}',
                  style: getNormalTextStyle()),
            ),
          )),
      pw.Expanded(
          flex: 2,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(2.0),
            child: pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                  '$currencyData ${getDoubleValue(mCartItem.totalItemAmount).toStringAsFixed(2)}',
                  style: getNormalTextStyle()),
            ),
          )),
    ]),
    (mItem.mSelectModifierList ?? []).isNotEmpty
        ? pw.Row(children: [
            pw.Expanded(
                flex: 2,
                child: getModifier(
                    (mItem.mSelectModifierList ?? []), currencyData)),
            pw.Expanded(flex: 1, child: pw.SizedBox()),
          ])
        : pw.SizedBox(),
    (mCartItem.itemTaxPercent ?? 0) > 0
        ? pw.Row(children: [
            pw.Expanded(
                flex: 2,
                child: pw.Row(children: [
                  pw.Expanded(
                      child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Tax (${mCartItem.itemTaxPercent}%)',
                              style: getNormalTextStyle()))),
                  pw.Expanded(
                      child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                              '$currencyData ${mCartItem.itemTaxPrice}',
                              style: getNormalTextStyle())))
                ])),
            pw.Expanded(flex: 1, child: pw.SizedBox()),
          ])
        : pw.SizedBox()
  ]);
}

pw.Widget getModifier(List<ModifierList> mModifierList, String currencyData) {
  List<pw.Widget> widgets = List.empty(growable: true);
  widgets.add(pw.SizedBox(height: 2));
  for (ModifierList mModifierList in mModifierList) {
    widgets.add(addModifierRow(mModifierList, currencyData));
  }
  widgets.add(pw.SizedBox(height: 2));
  return pw.Column(children: widgets);
}

pw.Widget addModifierRow(ModifierList mModifierList, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(mModifierList.modifierName ?? '',
                style: getNormalTextStyle()),
          ),
        )),
    // pw.Expanded(
    //     flex: 1,
    //     child: pw.Container(
    //       child: pw.Align(
    //         alignment: pw.Alignment.centerRight,
    //         child:
    //             pw.Text('x${mModifierList.count}', style: getNormalTextStyle()),
    //       ),
    //     )),
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(mModifierList.price).toStringAsFixed(2)}',
                style: getNormalTextStyle()),
          ),
        ))
  ]);
}

/// subTotal
pw.Widget getSubTotalRow(
    OrderDetailList mOrderDetailList, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text("Sub Total", style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(mOrderDetailList.subTotal).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

///tax
pw.Widget getTax(OrderTax tax, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 3,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(tax.taxName ?? '', style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.center,
            child:
                pw.Text('${tax.taxPercentage}%', style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(tax.taxAmount).toStringAsFixed(2)}',
                style: getNormalTextStyle()),
          ),
        )),
  ]);
}

/// Total
pw.Widget getTotalRow(OrderDetailList mOrderDetailList, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text("Total", style: getBoldTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(mOrderDetailList.totalAmount).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

/// Rounding
pw.Widget getRoundingRow(
    OrderDetailList mOrderDetailList, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text("Rounding", style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${(roundToNearestPossible(getDoubleValue(getDoubleValue(mOrderDetailList.totalAmount).toStringAsFixed(2))) - getDoubleValue(mOrderDetailList.totalAmount)).toStringAsFixed(2)}',
                style: getNormalTextStyle()),
          ),
        )),
  ]);
}

/// Total pay
pw.Widget getTotalPayRow(
    OrderDetailList mOrderDetailList, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text("Payable Amount", style: getBoldTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(roundToNearestPossible(getDoubleValue(getDoubleValue(mOrderDetailList.totalAmount).toStringAsFixed(2)))).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

/// payment
pw.Widget getPaymentRow(OrderDetailList mOrderDetailList, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                mOrderDetailList.paymentResponse?.first.paymentGatewayNo
                            .toString() ==
                        "0"
                    ? 'Cash'
                    : mOrderDetailList.paymentResponse?.first.paymentGatewayNo
                                .toString() ==
                            "5"
                        ? 'Debit card'
                        : mOrderDetailList
                                    .paymentResponse?.first.paymentGatewayNo
                                    .toString() ==
                                "6"
                            ? 'Credit Card'
                            : mOrderDetailList
                                        .paymentResponse?.first.paymentGatewayNo
                                        .toString() ==
                                    "7"
                                ? 'Qr code'
                                : '--',
                style: getBoldTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(roundToNearestPossible(getDoubleValue(getDoubleValue(mOrderDetailList.totalAmount).toStringAsFixed(2)))).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}
