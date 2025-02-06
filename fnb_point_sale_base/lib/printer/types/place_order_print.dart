import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/local/database/configuration/configuration_local_api.dart';
import '../../data/mode/cart_item/cart_item.dart';
import '../../data/mode/cart_item/order_place.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/order_place/process_multiple_orders_request.dart';
import '../../data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import '../../locator.dart';

Future<bool> printPlaceOrder(
    OrderDetailList mOrderDetailList, OrderPlace mOrderPlace) async {
  var configurationLocalApi = locator.get<ConfigurationLocalApi>();
  ConfigurationResponse mConfigurationResponse =
      await configurationLocalApi.getConfigurationResponse() ??
          ConfigurationResponse();
  String branchName =
      (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
          ? ""
          : (mConfigurationResponse.configurationData?.branchData ?? [])
                  .first
                  .branchName ??
              '';
  List<pw.Widget> widgets = List.empty(growable: true);
  widgets.add(pw.Center(
      child: pw.Text('Place Order', style: getBoldTextStyleMedium())));
  widgets.add(pw.Container(height: 4));
  widgets.add(
      pw.Center(child: pw.Text(branchName, style: getBoldTextStyleMedium())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  widgets.add(
      pw.Center(child: pw.Text('Order Number', style: getBoldTextStyle())));
  widgets.add(pw.Center(
      child: pw.Text('${mOrderDetailList.trackingOrderID}',
          style: getNormalTextStyle())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));

  ///table
  widgets.add(getTableRow(mOrderDetailList));
  ///user details
  if((mOrderDetailList.phoneNumber??'').isNotEmpty) {
    widgets.add(getUserDetailsRow(mOrderDetailList));
  }

  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  for (CartItem element in (mOrderPlace.cartItem ?? [])) {
    // if (!element.placeOrder) {
      widgets.add(getItemRow(element));
    // }
  }
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  return printWidgets(widgets, true, false);
}

pw.Widget getTableRow(OrderDetailList mOrderDetailList) {
  return pw.Row(
    children: [
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
              child: pw.Text(mOrderDetailList.tableNo ?? '--',
                  style: getBoldTextStyle()),
            ),
          )),
    ],
  );
}

pw.Widget getUserDetailsRow(OrderDetailList mOrderDetailList) {
  return
    pw.Column(
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${sCustomerName.tr}:-", style: getNormalTextStyle()),
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
                      child: pw.Text("${sPhoneNumber.tr}:-", style: getNormalTextStyle()),
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
        ]
    );
}

pw.Widget getItemRow(CartItem mCartItem) {
  return pw.Column(children: [
    pw.Row(children: [
      pw.Expanded(
          flex: 2,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(2.0),
            child: pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(mCartItem.mMenuItemData?.itemName ?? '',
                          style: getBoldTextStyle()),
                      pw.Text(
                          mCartItem.mSelectVariantListData
                                  ?.quantitySpecification ??
                              '',
                          style: getNormalTextStyle()),
                    ])),
          )),
      pw.Expanded(
          flex: 1,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(2.0),
            child: pw.Align(
              alignment: pw.Alignment.centerRight,
              child:
                  pw.Text('x${mCartItem.count}', style: getNormalTextStyle()),
            ),
          )),
    ]),
    (mCartItem.mSelectModifierList ?? []).isNotEmpty
        ? pw.Row(children: [
            pw.Expanded(
                flex: 2,
                child: getModifier((mCartItem.mSelectModifierList ?? []))),
            pw.Expanded(flex: 1, child: pw.SizedBox()),
          ])
        : pw.SizedBox(),
    (mCartItem.textRemarks ?? "").isNotEmpty
        ? pw.Row(children: [
            pw.Expanded(
                flex: 2,
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(2.0),
                  child: pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text("Note:- ${mCartItem.textRemarks}",
                        style: getBoldTextStyle()),
                  ),
                )),
            pw.Expanded(flex: 1, child: pw.SizedBox()),
          ])
        : pw.SizedBox()
  ]);
}

pw.Widget getModifier(List<ModifierList> mModifierList) {
  List<pw.Widget> widgets = List.empty(growable: true);
  widgets.add(pw.SizedBox(height: 2));
  for (ModifierList mModifierList in mModifierList) {
    widgets.add(addModifierRow(mModifierList));
  }
  widgets.add(pw.SizedBox(height: 2));
  return pw.Column(children: widgets);
}

pw.Widget addModifierRow(ModifierList mModifierList) {
  return pw.Row(children: [
    pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.only(left: 2.0),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(mModifierList.modifierName ?? '',
                style: getNormalTextStyle()),
          ),
        )),
    pw.Expanded(flex: 1, child: pw.Container()),
  ]);
}
