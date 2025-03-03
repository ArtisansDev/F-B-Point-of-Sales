import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/mode/cash_model/cash_model.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/update_balance/closing_balance/closing_balance_request.dart';
import '../../data/mode/update_balance/shift_details/shift_details_response.dart';
import '../../utils/date_time_utils.dart';

Future<bool> printShiftCloseOpeningBalance(
    String amount,
    ClosingBalanceRequest mClosingBalanceRequest,
    List<CashModel> mCashModelList,
    ConfigurationResponse mConfigurationResponse,
    ShiftDetailsResponse mShiftDetailsResponse) async {
  CurrencyData mCurrencyData = CurrencyData();
  mCurrencyData =
      (mConfigurationResponse.configurationData?.currencyData ?? []).first;

  String branchName =
      (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
          ? ""
          : (mConfigurationResponse.configurationData?.branchData ?? [])
                  .first
                  .branchName ??
              '';

  String mobileNumber =
      (mConfigurationResponse.configurationData?.branchData ?? []).isEmpty
          ? ""
          : (mConfigurationResponse.configurationData?.branchData ?? [])
                  .first
                  .mobileNumber ??
              '';

  List<pw.Widget> widgets = List.empty(growable: true);
  // widgets.add(pw.Center(
  //     child: pw.Text('Shift Close details', style: getBoldTextStyleMedium())));
  // widgets.add(pw.Container(height: 4));
  widgets
      .add(pw.Center(child: pw.Text(branchName, style: getNormalTextStyle())));
  widgets.add(pw.Center(child: pw.Text("--", style: getBoldTextStyleMedium())));
  widgets.add(pw.Center(
      child: pw.Text("TEL: $mobileNumber", style: getNormalTextStyle())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  widgets.add(pw.Center(
      child:
          pw.Text('Date: ${getTodayDateTime()}', style: getNormalTextStyle())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  widgets.add(pw.Center(
      child: pw.Text('Opening Balance'.toUpperCase(),
          style: getNormalTextStyle())));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  widgets.add(pw.Row(children: [
    pw.Expanded(child: pw.Text('Counter', style: getNormalTextStyle())),
    pw.Expanded(
        child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                mConfigurationResponse
                        .configurationData?.counterData?.first.counterName ??
                    '',
                style: getNormalTextStyle())))
  ]));
  widgets.add(pw.Container(height: 4));
  widgets.add(pw.Row(children: [
    pw.Expanded(child: pw.Text('Cashier', style: getNormalTextStyle())),
    pw.Expanded(
        child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                (mConfigurationResponse
                                .configurationData?.loggedInUserDetails ??
                            [])
                        .isEmpty
                    ? ""
                    : mConfigurationResponse.configurationData
                            ?.loggedInUserDetails?.first.name ??
                        '',
                style: getNormalTextStyle())))
  ]));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  widgets.add(pw.Row(children: [
    pw.Expanded(child: pw.Text('Opening amount', style: getNormalTextStyle())),
    pw.Expanded(
        child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                '${mCurrencyData.currencySymbol ?? ''} ${ getNumberFormat(getDoubleValue(amount))}',
                style: getNormalTextStyle())))
  ]));
  widgets.add(pw.Container(height: 4));
  widgets.add(mySeparator());
  widgets.add(mySeparator());
  widgets.add(pw.Container(height: 4));
  // widgets.add(pw.Center(
  //     child: pw.Text('THANK YOU & PLEASE COME AGAIN',
  //         style: getNormalTextStyle())));
  return printWidgets(widgets, true, false);
}
