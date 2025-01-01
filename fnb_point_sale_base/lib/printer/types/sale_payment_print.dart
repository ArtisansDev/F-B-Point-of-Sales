import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/local/database/configuration/configuration_local_api.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/order_history/order_history_response.dart';
import '../../locator.dart';

Future<bool> printSalePayment(
    OrderHistoryData mOrderHistoryData) async {
  CurrencyData mCurrencyData = CurrencyData();
  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  mCurrencyData = ((await configurationLocalApi.getConfigurationResponse())
              ?.configurationData
              ?.currencyData ??
          [])
      .first;

  List<pw.Widget> widgets = List.empty(growable: true);
  widgets.add(
      pw.Center(child: pw.Text('Payment Receipt', style: getBoldTextStyleMedium())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  widgets.add(
      pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
  widgets.add(pw.Center(
      child: pw.Text('${mOrderHistoryData.trackingOrderID}',
          style: getNormalTextStyle())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));

  ///table
  widgets.add(getTableRow(mOrderHistoryData));
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
    widgets.add(getTax(element, mCurrencyData.currencySymbol ?? ''));
    widgets.add(pw.Container(height: 2));
  }

  ///Total
  widgets
      .add(getTotalRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));

  ///payment
  widgets.add(pw.Container(
      padding: const pw.EdgeInsets.only(left: 2.0),
      child: pw.Text('Payment', style: getBoldTextStyle())));
  widgets.add(pw.Container(height: 3));
  widgets
      .add(getPaymentRow(mOrderHistoryData, mCurrencyData.currencySymbol ?? ''));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
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
            child: pw.Text("Table No:-", style: getNormalTextStyle()),
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

///item list
pw.Widget getItemRow(OrderHistoryMenu mCartItem, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 3,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child:
                pw.Text(mCartItem.itemName ?? '', style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.center,
            child:
                pw.Text('x${mCartItem.quantity}', style: getNormalTextStyle()),
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
  ]);
}

/// subTotal
pw.Widget getSubTotalRow(
    OrderHistoryData mOrderHistoryData, String currencyData) {
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
                '$currencyData ${getDoubleValue(mOrderHistoryData.subTotal).toStringAsFixed(2)}',
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
                '$currencyData ${getDoubleValue(tax.taxAmount).toStringAsFixed(2)}',
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
                '$currencyData ${getDoubleValue(mOrderHistoryData.totalAmount).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

/// payment
pw.Widget getPaymentRow(OrderHistoryData mOrderHistoryData, String currencyData) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                mOrderHistoryData.paymentGatewayNo
                            .toString() ==
                        "0"
                    ? 'Cash'
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
                '$currencyData ${getDoubleValue(mOrderHistoryData.totalAmount).toStringAsFixed(2)}',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}
