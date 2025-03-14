import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/local/database/configuration/configuration_local_api.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/order_history/order_history_response.dart';
import '../../lang/translation_service_key.dart';
import '../../locator.dart';
import '../../utils/date_time_utils.dart';

Future<bool> printSalePayment(OrderHistoryData mOrderHistoryData,
    PrinterSettingsData? mPrinterSettingsData) async {
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

  if(mPrinterSettingsData==null) {
    if ((mOrderHistoryData.paymentStatus ?? '').toUpperCase() == 'C') {
      widgets.add(pw.Center(
          child: pw.Text('Cancel Order', style: getBoldTextStyleMedium())));
    } else {
      widgets.add(pw.Center(
          child: pw.Text('Payment Receipt', style: getBoldTextStyleMedium())));
    }

    widgets.add(pw.Container(height: 4));
    widgets.add(
        pw.Center(child: pw.Text(branchName, style: getBoldTextStyleMedium())));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));
    widgets.add(
        pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
    widgets.add(pw.Center(
        child: pw.Text('${mRestaurantData.orderIDPrefixCode}${mOrderHistoryData
            .trackingOrderID}',
            style: getNormalTextStyle())));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///table
    widgets.add(getTableRow(mOrderHistoryData));

    ///user details
    if ((mOrderHistoryData.phoneNumber ?? '').isNotEmpty) {
      widgets.add(getUserDetailsRow(mOrderHistoryData));
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///menu order
    for (OrderHistoryMenu element in (mOrderHistoryData.orderMenu ?? [])) {
      widgets.add(getItemRow(element, mCurrencyData.currencySymbol ?? ''));
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///SubTotal
    widgets.add(
        getSubTotalRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 2));

    ///tax
    for (OrderHistoryTax element in (mOrderHistoryData.orderTax ?? [])) {
      if ((element.taxPercentage ?? 0) > 0) {
        widgets.add(getTax(element, mCurrencyData.currencySymbol ?? ''));
        widgets.add(pw.Container(height: 2));
      }
    }

    ///Total
    widgets
        .add(getTotalRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));

    ///Rounding
    widgets.add(
        getRoundingRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));

    ///Total Pay
    widgets.add(
        getTotalPayRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///payment
    widgets.add(pw.Container(
        padding: const pw.EdgeInsets.only(left: 2.0),
        child: pw.Text('Payment', style: getBoldTextStyle())));
    widgets.add(pw.Container(height: 3));
    widgets.add(
        getPaymentRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///remark
    if ((mOrderHistoryData.additionalNotes ?? "").isNotEmpty) {
      widgets.add(
          pw.Center(child: pw.Text('Order Remark', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text('${mOrderHistoryData.additionalNotes}',
              style: getNormalTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }

    widgets.add(pw.Center(
        child:
        pw.Text(mRestaurantData.tagLine ?? '', style: getBoldTextStyle())));
  }else{
    if ((mOrderHistoryData.paymentStatus ?? '').toUpperCase() == 'C') {
      widgets.add(pw.Center(
          child: pw.Text('Cancel Order', style: getBoldTextStyleMedium())));
    } else {
      if ((mPrinterSettingsData.enableTitleText ?? false) &&
          (mPrinterSettingsData.customTitleText ?? '').isNotEmpty) {
        widgets.add(pw.Center(
            child: pw.Text((mPrinterSettingsData.customTitleText ?? ''),
                style: getBoldTextStyleMedium())));
      } else {
        widgets.add(pw.Center(
            child: pw.Text(
                'Payment Receipt', style: getBoldTextStyleMedium())));
      }
    }

    widgets.add(pw.Container(height: 4));


    ///branch
    if ((mPrinterSettingsData.enableBranchName ?? false)) {
      widgets.add(pw.Center(
          child: pw.Text(branchName, style: getBoldTextStyleMedium())));
      widgets.add(pw.Container(height: 4));
     
    }
    if ((mPrinterSettingsData.enableBranchAddress ?? false)){
      widgets.add(
          pw.Center(child: pw.Text(branchAddress,textAlign: pw.TextAlign.center, style: getBoldTextStyle())));
      widgets.add(pw.Container(height: 4));
    }
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));
    ///enableOrderTrackingID
    if ((mPrinterSettingsData.enableOrderTrackingID ?? false)) {
      widgets.add(
          pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text('${mRestaurantData.orderIDPrefixCode}${mOrderHistoryData
              .trackingOrderID}',
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
          child: pw.Text('${getUTCToLocalDateOrderHistory(mOrderHistoryData.orderDate.toString())}',
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
              textAlign: pw.TextAlign.center,
              style: getBoldTextStyle())));
      widgets.add(pw.Container(height: 4));
      widgets.add(mySeparator());
      widgets.add(pw.Container(height: 4));
    }

    ///table
    widgets.add(getTableRow(mOrderHistoryData));

    ///user details
    if ((mOrderHistoryData.phoneNumber ?? '').isNotEmpty) {
      widgets.add(getUserDetailsRow(mOrderHistoryData));
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///menu order
    for (OrderHistoryMenu element in (mOrderHistoryData.orderMenu ?? [])) {
      widgets.add(getItemRow(element, mCurrencyData.currencySymbol ?? ''));
    }
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///SubTotal
    widgets.add(
        getSubTotalRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 2));

    ///tax
    for (OrderHistoryTax element in (mOrderHistoryData.orderTax ?? [])) {
      if ((element.taxPercentage ?? 0) > 0) {
        widgets.add(getTax(element, mCurrencyData.currencySymbol ?? ''));
        widgets.add(pw.Container(height: 2));
      }
    }

    ///Total
    widgets
        .add(getTotalRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));

    ///Rounding
    widgets.add(
        getRoundingRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));

    ///Total Pay
    widgets.add(
        getTotalPayRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///payment
    widgets.add(pw.Container(
        padding: const pw.EdgeInsets.only(left: 2.0),
        child: pw.Text('Payment', style: getBoldTextStyle())));
    widgets.add(pw.Container(height: 3));
    widgets.add(
        getPaymentRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 4));
    widgets.add(mySeparator());
    widgets.add(pw.Container(height: 4));

    ///remark
    if ((mOrderHistoryData.additionalNotes ?? "").isNotEmpty) {
      widgets.add(
          pw.Center(child: pw.Text('Order Remark', style: getBoldTextStyle())));
      widgets.add(pw.Center(
          child: pw.Text('${mOrderHistoryData.additionalNotes}',
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
              textAlign: pw.TextAlign.center,
              style: getBoldTextStyle())));
    }

    ///enableCustomText
    if ((mPrinterSettingsData.enableCustomText ?? false) &&
        (mPrinterSettingsData.customMessageText ?? '').isNotEmpty) {
      widgets.add(pw.Container(height: 2));
      widgets.add(pw.Center(
          child: pw.Text((mPrinterSettingsData.customMessageText ?? ''),
              textAlign: pw.TextAlign.center,
              style: getNormalTextStyle())));
    }

  }

  return printWidgets(widgets, true, false);
}

///table
pw.Widget getTableRow(OrderHistoryData mOrderHistoryData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text("${sSeatingNo.tr}:-", style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(mOrderHistoryData.tableNo ?? '--',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

///UserDetails
pw.Widget getUserDetailsRow(OrderHistoryData mOrderDetailList) {
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
pw.Widget getItemRow(OrderHistoryMenu mCartItem, String currencyData) {
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
                          '${mCartItem.itemVariantName ?? ''} ${(mCartItem
                              .discountPercentage ?? 0.0) > 0 ? '(${(mCartItem
                              .discountPercentage ?? 0.0)})%' : ""}',
                          style: getNormalTextStyle()),
                      (mCartItem.discountPercentage ?? 0.0) > 0
                          ? pw.Row(children: [
                        pw.Text(
                            '$currencyData ${(mCartItem.variantPrice ?? 0.0)
                                .toString()}',
                            style: getNormalTextStyleLineThrough()),
                        pw.SizedBox(width: 3),
                        pw.Text(
                            '$currencyData  ${(mCartItem.itemDiscountPrice ??
                                0.0).toString()}',
                            style: getBoldTextStyle()),
                      ])
                          : pw.SizedBox(
                        child: pw.Text(
                            '$currencyData ${(mCartItem.variantPrice ?? 0.0)
                                .toString()}',
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
                  '$currencyData ${getDoubleValue(mCartItem.totalItemAmount)
                      .toStringAsFixed(2)}',
                  style: getNormalTextStyle()),
            ),
          )),
    ]),
    (mCartItem.modifierData ?? []).isNotEmpty
        ? pw.Row(children: [
      pw.Expanded(
          flex: 2,
          child:
          getModifier((mCartItem.modifierData ?? []), currencyData)),
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

pw.Widget getModifier(List<ModifierData> mModifierList, String currencyData) {
  List<pw.Widget> widgets = List.empty(growable: true);
  widgets.add(pw.SizedBox(height: 2));
  for (ModifierData mModifierList in mModifierList) {
    widgets.add(addModifierRow(mModifierList, currencyData));
  }
  widgets.add(pw.SizedBox(height: 2));
  return pw.Column(children: widgets);
}

pw.Widget addModifierRow(ModifierData mModifierList, String currencyData) {
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
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '$currencyData ${getDoubleValue(mModifierList.price)
                    .toStringAsFixed(2)}',
                style: getNormalTextStyle()),
          ),
        ))
  ]);
}

/// subTotal
pw.Widget getSubTotalRow(OrderHistoryData mOrderHistoryData,
    String currencyData) {
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
                '$currencyData ${getDoubleValue(mOrderHistoryData.subTotal)
                    .toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

///tax
pw.Widget getTax(OrderHistoryTax tax, String currencyData) {
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
                '$currencyData ${getDoubleValue(tax.taxAmount).toStringAsFixed(
                    2)}',
                style: getNormalTextStyle()),
          ),
        )),
  ]);
}

/// Total
pw.Widget getTotalRow(OrderHistoryData mOrderHistoryData, String currencyData) {
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
                '$currencyData ${getDoubleValue(mOrderHistoryData.totalAmount)
                    .toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

/// Rounding
pw.Widget getRoundingRow(OrderHistoryData mOrderHistoryData,
    String currencyData) {
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
                '$currencyData ${(getDoubleValue(
                    (mOrderHistoryData.adjustedAmount ?? 0) > 0
                        ? mOrderHistoryData.adjustedAmount
                        : mOrderHistoryData.totalAmount) -
                    getDoubleValue(mOrderHistoryData.totalAmount))
                    .toStringAsFixed(2)}',
                style: getNormalTextStyle()),
          ),
        )),
  ]);
}

/// Total pay
pw.Widget getTotalPayRow(OrderHistoryData mOrderHistoryData,
    String currencyData) {
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
                '$currencyData ${getDoubleValue(
                    (mOrderHistoryData.adjustedAmount ?? 0) > 0
                        ? mOrderHistoryData.adjustedAmount
                        : mOrderHistoryData.totalAmount).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

/// payment
pw.Widget getPaymentRow(OrderHistoryData mOrderHistoryData,
    String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                mOrderHistoryData.paymentGatewayNo.toString() == "0"
                    ? 'Cash'
                    : mOrderHistoryData.paymentGatewayNo.toString() == "5"
                    ? 'Debit card'
                    : mOrderHistoryData.paymentGatewayNo.toString() == "6"
                    ? 'Credit Card'
                    : mOrderHistoryData.paymentGatewayNo.toString() ==
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
                '$currencyData ${getDoubleValue(
                    (mOrderHistoryData.adjustedAmount ?? 0) > 0
                        ? mOrderHistoryData.adjustedAmount
                        : mOrderHistoryData.totalAmount).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}
