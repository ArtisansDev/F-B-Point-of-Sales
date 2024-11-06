import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/view_document/view_doument.dart';
import 'package:fnb_point_sale_base/common/view_document/view_document_model.dart';
import '../model/loginScreen/view/loginScreen.dart';
import 'route_constants.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String routeName = routeSettings.name.toString();

    switch (routeName) {
      ///Login-Screen
      case RouteConstants.rLoginScreen:
        return MaterialPageRoute(builder: (context) => LoginPage());

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