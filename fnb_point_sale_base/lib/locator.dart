import 'package:get_it/get_it.dart';
import 'data/local/database/printer/printer_local_api.dart';
import 'data/local/database/printer/printer_local_api_impl.dart';
import 'data/remote/api_call/login/login_api.dart';
import 'data/remote/api_call/login/login_api_impl.dart';
import 'printer/service/my_printer_service.dart';
import 'printer/service/my_printer_service_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Local Database API
  locator.registerLazySingleton<PrinterLocalApi>(() => PrinterLocalApiImpl());

  /// All Api Call
  locator.registerLazySingleton<LoginApi>(() => LoginApiImpl());

  /// Services
  locator.registerLazySingleton<MyPrinterService>(() => MyPrinterServiceImpl());
}
