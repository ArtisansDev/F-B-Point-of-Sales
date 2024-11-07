

import '../../web_response.dart';

mixin LoginApi {
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest);
}
