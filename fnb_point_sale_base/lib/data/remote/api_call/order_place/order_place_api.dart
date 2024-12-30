import '../../web_response.dart';

///partha paul
///customer_api.dart
///25/12/24
mixin OrderPlaceApi {
  Future<WebResponseSuccess> postOrderPlace(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postOrderHistory(dynamic exhibitorsListRequest);
}
