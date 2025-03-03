import 'dart:collection';

import 'package:printing/printing.dart';

import '../../data/mode/cart_item/cart_item.dart';
import '../../data/mode/cart_item/order_place.dart';
import '../../data/mode/cash_model/cash_model.dart';
import '../../data/mode/configuration/configuration_response.dart';
import '../../data/mode/order_history/order_history_response.dart';
import '../../data/mode/order_place/process_multiple_orders_request.dart';
import '../../data/mode/update_balance/closing_balance/closing_balance_request.dart';
import '../../data/mode/update_balance/shift_details/shift_details_response.dart';

mixin MyPrinterService {
  void testManualPrint();

  void testAutoMaticPrint(Printer printer);

  Future<bool> salePlaceOrder(OrderDetailList mOrderDetailList,
      OrderPlace mOrderPlace, List<CartItem> cartItemKot,
      PrinterSettingsData? mPrinterSettingsData);

  ///payment
  Future<bool> saleOrderPayment(OrderDetailList mOrderDetailList,
      OrderPlace mOrderPlace,
      PrinterSettingsData? mPrinterSettingsData);

  ///payment
  Future<bool> saleAfterPayment(OrderDetailList mOrderDetailList,
      OrderHistoryData mOrderPlace, PrinterSettingsData? mPrinterSettingsData);

  Future<bool> salePayment(OrderHistoryData mOrderDetailList);

  Future<bool> salePaymentKot(OrderHistoryData mOrderDetailList,
      PrinterSettingsData? mPrinterSettingsDataKitchen,
      {bool duplicate = false});

  Future<bool> shiftDetails(String amount,
      ClosingBalanceRequest mClosingBalanceRequest,
      List<CashModel> mCashModelList,
      ConfigurationResponse mConfigurationResponse,
      ShiftDetailsResponse mShiftDetailsResponse);

  Future<bool> shiftDetailsOpeningBalance(String amount,
      ClosingBalanceRequest mClosingBalanceRequest,
      List<CashModel> mCashModelList,
      ConfigurationResponse mConfigurationResponse,
      ShiftDetailsResponse mShiftDetailsResponse);

  Future<bool> openCashDrawer();
}
