import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/web_constants.dart';
import '../../local/shared_prefs/shared_prefs.dart';

class WebHttpProvider {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  // Future<http.Response> postWithAuthAndRequestAndAttachment(String action,
  //     {String filePath = ""}) async {
  //   Map mapResponseJson;
  //   if (WebConstants.auth) {
  //     String tokenValue = await SharedPrefs().getUserToken();
  //     debugPrint("tokenValue === $tokenValue");
  //     headers.addAll({'Authorization': "Bearer $tokenValue"});
  //   }
  //
  //   var postUri = Uri.parse(WebConstants.baseUrlCommon + action);
  //
  //   http.MultipartRequest request = http.MultipartRequest("POST", postUri);
  //
  //   try {
  //     request.headers.addAll(headers);
  //     debugPrint("Damu webservice $filePath");
  //     if (filePath.isNotEmpty) {
  //       http.MultipartFile multipartFile =
  //           await http.MultipartFile.fromPath('attachment', filePath);
  //       request.files.add(multipartFile);
  //     }
  //
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     print("response ${response.body}");
  //     return response;
  //     //mapResponseJson = processResponseToJson(response);
  //   } on SocketException {
  //     return http.Response("", 400);
  //   }
  // }

  Future<http.Response> postWithAuthAndRequestAndAttachmentUploadCertification(
      String action, Map<String, String> value,
      {String filePath = ""}) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }

    var postUri = Uri.parse(WebConstants.baseUrlCommon + action);

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    try {
      request.headers.addAll(headers);
      debugPrint(" webservice $filePath");
      if (filePath.isNotEmpty) {
        http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('certificate', filePath);
        request.fields.addAll(value);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;

    } on SocketException {
      return http.Response("", 400);
    }
  }

  Future<http.Response> postWithAuthAndRequestAndAttachmentUploadResume(
      String action, Map<String, String> value,
      {String filePath = ""}) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }

    var postUri = Uri.parse(WebConstants.baseUrlCommon + action);

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    try {
      request.headers.addAll(headers);
      debugPrint(" webservice $filePath");
      if (filePath.isNotEmpty) {
        http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('resume', filePath);
        request.fields.addAll(value);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;

    } on SocketException {
      return http.Response("", 400);
    }
  }

  Future<http.Response> postWithAuthAndRequestAndAttachmentProfileImage(
      String action,
      {String filePath = ""}) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      debugPrint("tokenValue$tokenValue");
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }

    var postUri = Uri.parse(WebConstants.baseUrlCommon + action);

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    try {
      request.headers.addAll(headers);
      debugPrint(" webservice $filePath");
      if (filePath.isNotEmpty) {
        http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('profile_picture', filePath);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;

    } on SocketException {
      return http.Response("", 400);
    }
  }
}
