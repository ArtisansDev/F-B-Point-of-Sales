import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/mode/cart_item/cart_item.dart';
import '../../data/mode/cart_item/order_place.dart';
import '../../data/mode/order_place/process_multiple_orders_request.dart';

Future<bool> printPlaceOrder(OrderDetailList mOrderDetailList,
    OrderPlace mOrderPlace) async {
  List<pw.Widget> widgets = List.empty(growable: true);
  widgets.add(
      pw.Center(
          child: pw.Text('Place Order', style: getBoldTextStyleMedium())));
  widgets.add(pw.Container(height: 4));
  widgets.add(
      pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
  widgets.add(pw.Center(
      child: pw.Text('${mOrderDetailList.trackingOrderID}',
          style: getNormalTextStyle())));
  widgets.add(pw.Container(height: 4));
  widgets.add(getTableRow(mOrderDetailList));
  widgets.add(pw.Container(height: 4));
  for (CartItem element in (mOrderPlace.cartItem ?? [])) {
    if (!element.placeOrder) {
      widgets.add(getItemRow(element));
    }
  }
  return printWidgets(widgets, true, false);
}

pw.Widget getTableRow(OrderDetailList mOrderDetailList) {
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
            alignment: pw.Alignment.center,
            child: pw.Text(mOrderDetailList.tableNo ?? '--',
                style: getBoldTextStyle()),
          ),
        )),
  ]);
}

pw.Widget getItemRow(CartItem mCartItem) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 1,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(mCartItem.mMenuItemData?.itemName ?? '',
                style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text('x${mCartItem.count}',
                style: getNormalTextStyle()),
          ),
        )),
  ]);
}


