import 'package:fnb_point_sale_base/serialportdevices/service/affin_bank_terminal/affin_bank_terminal_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/affin_bank_terminal/affin_bank_terminal_service_impl.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/display_device_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/display_device_service_impl.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/may_bank_terminal/may_bank_terminal_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/may_bank_terminal/may_bank_terminal_service_impl.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/process_runner_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/process_runner_service_impl.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/rakyat_bank_terminal/rakyet_bank_terminal_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/rakyat_bank_terminal/rakyet_bank_terminal_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'data/local/database/configuration/configuration_local_api.dart';
import 'data/local/database/configuration/configuration_local_api_impl.dart';
import 'data/local/database/customer/customer_local_api.dart';
import 'data/local/database/customer/customer_local_api_impl.dart';
import 'data/local/database/hold_sale/hold_sale_local_api.dart';
import 'data/local/database/hold_sale/hold_sale_local_api_impl.dart';
import 'data/local/database/menu_item/menu_item_local_api.dart';
import 'data/local/database/menu_item/menu_item_local_api_impl.dart';
import 'data/local/database/modifier/modifier_local_api.dart';
import 'data/local/database/modifier/modifier_local_api_impl.dart';
import 'data/local/database/payment_type/payment_type_local_api.dart';
import 'data/local/database/payment_type/payment_type_local_api_impl.dart';
import 'data/local/database/place_order/place_order_sale_local_api.dart';
import 'data/local/database/place_order/place_order_sale_local_api_impl.dart';
import 'data/local/database/printer/printer_local_api.dart';
import 'data/local/database/printer/printer_local_api_impl.dart';
import 'data/local/database/product/all_category/all_category_local_api.dart';
import 'data/local/database/product/all_category/all_category_local_api_impl.dart';
import 'data/local/database/serialport/serial_port_devices_api.dart';
import 'data/local/database/serialport/serial_port_devices_api_impl.dart';
import 'data/local/database/table_list/table_list_local_api.dart';
import 'data/local/database/table_list/table_list_local_api_impl.dart';
import 'data/local/database/variant/variant_local_api.dart';
import 'data/local/database/variant/variant_local_api_impl.dart';
import 'data/remote/api_call/customer/customer_api.dart';
import 'data/remote/api_call/customer/customer_api_impl.dart';
import 'data/remote/api_call/login/login_api.dart';
import 'data/remote/api_call/login/login_api_impl.dart';
import 'data/remote/api_call/product/product_api.dart';
import 'data/remote/api_call/product/product_api_impl.dart';
import 'printer/service/my_printer_service.dart';
import 'printer/service/my_printer_service_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Local Database API
  /// HoldSale
  locator.registerLazySingleton<HoldSaleLocalApi>(
      () => HoldSaleLocalApiImpl());

  /// Customer
  locator.registerLazySingleton<CustomerLocalApi>(
      () => CustomerLocalApiImpl());

  /// PlaceOrder
  locator.registerLazySingleton<PlaceOrderSaleLocalApi>(
      () => PlaceOrderSaleLocalApiImpl());

  /// Configuration
  locator.registerLazySingleton<ConfigurationLocalApi>(
      () => ConfigurationLocalApiImpl());

  /// Product
  /// CategoryList
  locator.registerLazySingleton<AllCategoryLocalApi>(
      () => AllCategoryLocalApiImpl());

  /// ModifierList
  locator.registerLazySingleton<ModifierLocalApi>(
          () => ModifierLocalApiImpl());

  /// ModifierList
  locator.registerLazySingleton<MenuItemLocalApi>(
          () => MenuItemLocalApiImpl());

  /// VariantLocalList
  locator.registerLazySingleton<VariantLocalApi>(
          () => VariantLocalApiImpl());

  /// PaymentTypeList
  locator.registerLazySingleton<PaymentTypeLocalApi>(
          () => PaymentTypeLocalApiImpl());

  /// TableListLocal
  locator.registerLazySingleton<TableListLocalApi>(
          () => TableListLocalApiImpl());

  ///Printer
  locator.registerLazySingleton<PrinterLocalApi>(() => PrinterLocalApiImpl());

  ///SerialPort payment
  locator.registerLazySingleton<SerialPortDevicesApi>(
      () => SerialPortDevicesApiImpl());

  /// All Api Call
  locator.registerLazySingleton<LoginApi>(() => LoginApiImpl());
  locator.registerLazySingleton<ProductApi>(() => ProductApiImpl());
  locator.registerLazySingleton<CustomerApi>(() => CustomerApiImpl());

  /// Services
  locator.registerLazySingleton<MyPrinterService>(() => MyPrinterServiceImpl());
  locator.registerLazySingleton<ProcessRunnerService>(
      () => ProcessRunnerServiceImpl());
  locator.registerLazySingleton<DisplayDeviceService>(
      () => DisplayDeviceServiceImpl());

  ///terminal
  locator.registerLazySingleton<MayBankTerminalService>(
      () => MayBankTerminalServiceImpl());
  locator.registerLazySingleton<AffinBankTerminalService>(
      () => AffinBankTerminalServiceImpl());
  locator.registerLazySingleton<RakyetBankTerminalService>(
      () => RakyetBankTerminalServiceImpl());
}
