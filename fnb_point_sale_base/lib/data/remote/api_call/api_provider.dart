import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../constants/web_constants.dart';
import '../../local/shared_prefs/shared_prefs.dart';

class WebProvider extends GetConnect {
  Map<String, String> headers = {
    "apikey":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxkY2xkbHlnY2x3eGVkeWdqdGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMjIxNTcsImV4cCI6MjA0NDc5ODE1N30.MoH5tp5ChaBFf5OAibhcvqpyZkVNZwcbJlo8v4IMn7Q",
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Prefer": "return=minimal",
  };

  Future<Response> getWithRequest(String action, params) async {
    debugPrint("queryRequest ==  $params");
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }

    var mResponse = await get(action, query: params);
    return mResponse;
  }

  Future<Response> getWithWithoutRequest(String action) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue=== $tokenValue");
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }
    debugPrint("getWithWithoutRequest ${WebConstants.baseUrlCommon}$action");
    Response mResponse =
        await get(WebConstants.baseUrlCommon + action, headers: headers);
    debugPrint("mResponse statusCode ==  ${mResponse.statusCode}");
    debugPrint("mResponse ==  ${jsonEncode(mResponse.body)}");
    return mResponse;
  }

  @override
  Future<Response> postWithRequest(String action, params) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }

    debugPrint("url ==  ${WebConstants.baseUrlCommon + action}");

    debugPrint("plainJsonRequest ==  ${jsonEncode(params)}");
    debugPrint("headers ==  ${jsonEncode(headers)}");

    allowAutoSignedCert = true;
    var mResponse = await post(
        WebConstants.baseUrlCommon + action, jsonEncode(params),
        headers: headers);
    debugPrint("mResponse statusCode ==  ${mResponse.statusCode}");
    debugPrint("mResponse ==  ${jsonEncode(mResponse.body)}");
    return mResponse;
  }

  @override
  Future<Response> postWithoutRequest(String action) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }
    debugPrint("url ==  ${WebConstants.baseUrlCommon + action}");
    debugPrint("headers ==  ${jsonEncode(headers)}");
    allowAutoSignedCert = true;
    var mResponse =
        await post(WebConstants.baseUrlCommon + action, "", headers: headers);
    debugPrint("mResponse statusCode ==  ${mResponse.statusCode}");
    debugPrint("mResponse ==  ${jsonEncode(mResponse.body)}");
    return mResponse;
  }

  @override
  Future<Response> postWithRequestAndAttachment(
      String action, Map<String, dynamic> productMap,
      {String filePath = ""}) async {
    try {
      if (WebConstants.auth) {
        String tokenValue = await SharedPrefs().getUserToken();
        debugPrint("tokenValue$tokenValue");
        headers.addAll({'Authorization': "Bearer ${tokenValue}"});
      }
      String picName = filePath.split("/").last;
      print("pic name: - $picName");
      print("url name: - ${WebConstants.baseUrlCommon + action}");
      MultipartFile mMultipartFile = MultipartFile(File(filePath),
          filename: picName, contentType: "multipart/form-data");
      final form = FormData({
        'attachment': mMultipartFile,
        // 'id': '593'
      });

      allowAutoSignedCert = true;
      Response mResponse = await post(WebConstants.baseUrlCommon + action, form,
          headers: headers);
      return mResponse;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
