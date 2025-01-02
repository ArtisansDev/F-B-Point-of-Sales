import 'dart:collection';

import 'package:printing/printing.dart';

import '../../data/mode/cart_item/order_place.dart';
import '../../data/mode/order_history/order_history_response.dart';
import '../../data/mode/order_place/process_multiple_orders_request.dart';


mixin MyPrinterService {
  void testManualPrint();

  void testAutoMaticPrint(Printer printer);

  Future<bool> salePlaceOrder(OrderDetailList mOrderDetailList, OrderPlace mOrderPlace);

  Future<bool> saleOrderPayment(OrderDetailList mOrderDetailList, OrderPlace mOrderPlace);

  Future<bool> saleAfterPayment(OrderDetailList mOrderDetailList, OrderHistoryData mOrderPlace);

  Future<bool> salePayment(OrderHistoryData mOrderDetailList);

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
