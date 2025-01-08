import '../../web_response.dart';

///partha paul
///customer_api.dart
///25/12/24
mixin BalanceApi {
  Future<WebResponseSuccess> postUpdateOpeningBalance(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUpdateClosingBalance(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postShiftDetails(dynamic exhibitorsListRequest);
}
