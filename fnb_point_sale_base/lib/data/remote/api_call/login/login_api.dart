

import '../../web_response.dart';

mixin LoginApi {
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postConfiguration(dynamic exhibitorsListRequest,{bool flag = true});
  Future<WebResponseSuccess> postUpdatePOSLoginStatus(dynamic exhibitorsListRequest);
}
