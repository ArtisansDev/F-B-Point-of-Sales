

import '../../web_response.dart';

mixin ProductApi {
  Future<WebResponseSuccess> postGetAllCategory(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetAllMenuItem(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetAllModifier(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetAllVariant(dynamic exhibitorsListRequest);
}
