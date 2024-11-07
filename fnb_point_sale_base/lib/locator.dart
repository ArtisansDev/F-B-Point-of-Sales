import 'package:get_it/get_it.dart';
import 'data/remote/api_call/login/login_api.dart';
import 'data/remote/api_call/login/login_api_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Local Database API
  // locator.registerLazySingleton<CounterLocalApi>(() => CounterLocalApiImpl());

  /// All Api Call
  locator.registerLazySingleton<LoginApi>(() => LoginApiImpl());
}
