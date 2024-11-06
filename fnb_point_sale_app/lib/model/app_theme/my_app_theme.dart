// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fnb_point_sale_base/lang/translation_service.dart';
import '../../routes/generated_routes.dart';
import '../loginScreen/view/loginScreen.dart';
import 'theme/my_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyAppTheme extends StatelessWidget {
  const MyAppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'fnb',
          theme: myLightTheme(context),
          darkTheme: myDarkTheme(context),
          onGenerateRoute: GeneratedRoutes.generateRoute,
          defaultTransition: Transition.leftToRightWithFade,
          builder: (context, child) {
            return protectFromSettingsFontSize(context, child!);
          },
          home: const LoginPage(),
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

MediaQuery protectFromSettingsFontSize(BuildContext context, Widget child) {
  final mediaQueryData = MediaQuery.of(context);
  // Font size change(either reduce or increase) from phone setting should not impact app font size
  final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.0);
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
    child: child,
  );
}
