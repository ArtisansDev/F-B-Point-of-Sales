import '../../web_response.dart';

///partha paul
///customer_api.dart
///25/12/24
mixin CustomerApi {
  Future<WebResponseSuccess> postGetAllCustomer(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postCustomerSave(dynamic exhibitorsListRequest);
}
