import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/web_constants.dart';
import '../web_response.dart';
import '../web_response_failed.dart';
import 'api_provider.dart';

class AllApiImpl {
  WebProvider mWebProvider = WebProvider();
  late WebResponseSuccess mWebResponseSuccess;
  late WebResponseFailed mWebResponseFailed;

  Map processResponseToJson(Response response) {
    var responseBody = response.body;
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
      case 409:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 409 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
      case 401:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 401 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;

      case 404:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
      case 400:
        Map responseJson = json.decode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 400 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 403:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 403 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 500:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 500 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 502:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 502 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 503:
        Map responseJson = json.decode(WebConstants.statusCode503Message);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 503 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      default:
        var responseJson = jsonEncode(responseBody);
        if (BaseAppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
    }
  }
}
