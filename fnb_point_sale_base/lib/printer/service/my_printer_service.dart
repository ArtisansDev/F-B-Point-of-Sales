import 'dart:collection';

import 'package:printing/printing.dart';


mixin MyPrinterService {
  void testManualPrint();

  void testAutoMaticPrint(Printer printer);

  // Future<bool> salePrint(
  //     String? title, Sale sale, bool duplicateCopy, bool voidSale,
  //     {SaleTye saleTye = SaleTye.REGULAR, bool returnOrExchange = false});
  //
  // Future<bool> bookingPaymentPrint(
  //     String? title, BookingPayments sale, bool duplicateCopy);
  //
  // Future<bool> resetBookingPaymentPrint(
  //     String? title, BookingPaymentProducts sale, bool duplicateCopy);
  //
  // Future<bool> cashMovementPrint(
  //     String? title, CashMovements sale, bool duplicateCopy);

  Future<bool> openCashDrawer();

  // Future<bool> cashDeclarationReceipt(
  //     String? title,
  //     CounterClosingDetails counterClosingDetails,
  //     List<Denominations> denominations,
  //     HashMap<int, double>? paymentDeclaration);
  //
  // Future<bool> openCounterReceipt(String? title, Stores? store,
  //     Counters? counters, double openingBalance, bool duplicateCopy);
  //
  // Future<bool> printBirthdayVoucher(
  //     String? title, Customers customers, Vouchers vouchers);
}
