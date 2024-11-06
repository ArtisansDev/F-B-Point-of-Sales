
import '../web_response.dart';

abstract class IApiRepository {
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest);
}
