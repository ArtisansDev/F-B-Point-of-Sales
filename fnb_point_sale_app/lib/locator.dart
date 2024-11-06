import 'package:get_it/get_it.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/api_adapter.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/api_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Local Database API
  // locator.registerLazySingleton<CounterLocalApi>(() => CounterLocalApiImpl());

  /// All Api Call
  locator.registerLazySingleton<IApiRepository>(() => AllApiImpl());
}
