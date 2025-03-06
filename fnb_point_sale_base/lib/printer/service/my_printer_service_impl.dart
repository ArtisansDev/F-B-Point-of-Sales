import 'dart:collection';

import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/printer/types/open_cash_drawer_via_print_esc.dart';
import 'package:printing/printing.dart';
import 'package:printing/src/printer.dart';

import '../../data/local/database/printer/model/my_printer.dart';
import '../../data/local/database/printer/printer_local_api.dart';
import '../../data/mode/cart_item/cart_item.dart';
import '../../data/mode/cart_item/order_place.dart';
import '../../data/mode/cash_model/cash_model.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/order_history/order_history_response.dart';
import '../../data/mode/order_place/process_multiple_orders_request.dart';
import '../../data/mode/update_balance/closing_balance/closing_balance_request.dart';
import '../../data/mode/update_balance/shift_details/shift_details_response.dart';
import '../../locator.dart';
import '../../utils/my_log_utils.dart';
import '../types/order_payment_print.dart';
import '../types/place_order_print.dart';
import '../types/sale_aftre_payment_print.dart';
import '../types/sale_payment_kot_print.dart';
import '../types/sale_payment_print.dart';
import '../types/shift_details_print.dart';
import '../types/shift_details_print_opening_balance.dart';
import '../types/test_printing.dart';

class MyPrinterServiceImpl with MyPrinterService {
  @override
  Future<bool> salePlaceOrder(
      OrderDetailList mOrderDetailList,
      OrderPlace mOrderPlace,
      List<CartItem> cartItemKot,
      PrinterSettingsData? mPrinterSettingsData) async {
    return await printPlaceOrder(
        mOrderDetailList, mOrderPlace, cartItemKot, mPrinterSettingsData);
  }

  ///payment
  @override
  Future<bool> saleOrderPayment(OrderDetailList mOrderDetailList,
      OrderPlace mOrderPlace, PrinterSettingsData? mPrinterSettingsData) async {
    return await printOrderPayment(
        mOrderDetailList, mOrderPlace, mPrinterSettingsData);
  }

  ///payment
  @override
  Future<bool> saleAfterPayment(
      OrderDetailList mOrderDetailList,
      OrderHistoryData mOrderPlace,
      PrinterSettingsData? mPrinterSettingsData) async {
    return await printAftrePayment(mOrderDetailList, mOrderPlace,mPrinterSettingsData);
  }

  @override
  Future<bool> salePayment(OrderHistoryData mOrderDetailList,PrinterSettingsData? mPrinterSettingsData) async {
    return await printSalePayment(mOrderDetailList,mPrinterSettingsData);
  }

  @override
  Future<bool> salePaymentKot(OrderHistoryData mOrderDetailList,
      PrinterSettingsData? mPrinterSettingsDataKitchen,
      {bool duplicate = false}) async {
    return await printSalePaymentKot(
        mOrderDetailList, duplicate, mPrinterSettingsDataKitchen);
  }

  @override
  Future<bool> shiftDetails(
      String amount,
      ClosingBalanceRequest mClosingBalanceRequest,
      List<CashModel> mCashModelList,
      ConfigurationResponse mConfigurationResponse,
      ShiftDetailsResponse mShiftDetailsResponse) async {
    return await printShiftClose(amount, mClosingBalanceRequest, mCashModelList,
        mConfigurationResponse, mShiftDetailsResponse);
  }

  @override
  Future<bool> shiftDetailsOpeningBalance(
      String amount,
      ClosingBalanceRequest mClosingBalanceRequest,
      List<CashModel> mCashModelList,
      ConfigurationResponse mConfigurationResponse,
      ShiftDetailsResponse mShiftDetailsResponse) async {
    return await printShiftCloseOpeningBalance(amount, mClosingBalanceRequest,
        mCashModelList, mConfigurationResponse, mShiftDetailsResponse);
  }

  // @override
  // Future<bool> salePrint(
  //     String? title, Sale sale, bool duplicateCopy, bool voidSale,
  //     {SaleTye saleTye = SaleTye.REGULAR,
  //     bool returnOrExchange = false}) async {
  //   if (saleTye == SaleTye.CREDITSALES) {
  //     return printCreditSaleData(title, sale, duplicateCopy, voidSale, saleTye);
  //   }
  //   return printSaleData(title, sale, duplicateCopy, voidSale,
  //       returnOrExchange: returnOrExchange);
  // }

  @override
  void testAutoMaticPrint(Printer printer) {
    printPdfDirect(printer);
  }

  @override
  void testManualPrint() async {
    printPdf();
  }

  @override
  Future<bool> openCashDrawer() async {
    var localPrinter = locator.get<PrinterLocalApi>();
    MyPrinter? printer = await localPrinter.getMyPrinter();

    MyLogUtils.logDebug("openCashDrawer printer : ${printer?.toJson()}");

    if (printer != null) {
      return openCashDrawerViaPrinter(printer.name);
    }

    return false;
  }
}
