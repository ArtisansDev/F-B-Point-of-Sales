import 'dart:collection';

import 'package:fnb_point_sale_base/printer/service/my_printer_service.dart';
import 'package:fnb_point_sale_base/printer/types/open_cash_drawer_via_print_esc.dart';
import 'package:printing/printing.dart';
import 'package:printing/src/printer.dart';

import '../../data/local/database/printer/model/my_printer.dart';
import '../../data/local/database/printer/printer_local_api.dart';
import '../../locator.dart';
import '../../utils/my_log_utils.dart';
import '../types/test_printing.dart';

class MyPrinterServiceImpl with MyPrinterService {
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
