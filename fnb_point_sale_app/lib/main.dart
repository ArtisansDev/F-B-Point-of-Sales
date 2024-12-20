// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/remote/web_http_overrides.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'model/app_theme/my_app_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

const hiveDbPath = 'fnb-pos-data';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = WebHttpOverrides();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter(hiveDbPath);
  if (Platform.isAndroid) {
    // Android-specific code
  } else if (Platform.isIOS) {
    // iOS-specific code
  } else {
    await windowManager.ensureInitialized();
    // Use it only after calling `hiddenWindowAtLaunch`
    unawaited(windowManager.waitUntilReadyToShow().then((_) async {
      // Hide window title bar
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
      await windowManager.setFullScreen(true);
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
      await windowManager.setClosable(true);
    }));
  }
  setupLocator();
  await SharedPrefs().sharedPreferencesInstance();
  await dotenv.load(fileName: ".env");
  _disableDebugLogs();

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const
    // Enable debug paint
      const MyAppTheme(), // Wrap your app
    // ),
  );
}

void _disableDebugLogs() {
  // Check if the app is running in debug mode
  bool isDebug = kDebugMode;
  if (!isDebug) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
}