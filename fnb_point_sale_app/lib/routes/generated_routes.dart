import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/view_document/view_doument.dart';
import 'package:fnb_point_sale_base/common/view_document/view_document_model.dart';
import '../model/dashboard_screen/view/dashboard_screen.dart';
import '../model/login_screen/view/login_screen.dart';
import 'route_constants.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String routeName = routeSettings.name.toString();

    switch (routeName) {
      ///Login-Screen
      case RouteConstants.rLoginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      ///Dashboard-Screen
      case RouteConstants.rDashboardScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());

      ///ViewDocument-Screen
      case RouteConstants.rViewDocument:
        return MaterialPageRoute(
            builder: (context) =>
                ViewDocument(mViewDocumentModel: args as ViewDocumentModel));

      default:
        return _routeNotFound(sRouteName: " - $routeName");
    }
  }

  static Route<dynamic> _routeNotFound({String sRouteName = ""}) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: Text("Page not found!$sRouteName"),
        ),
      );
    });
  }
}
