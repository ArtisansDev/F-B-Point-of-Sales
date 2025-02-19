import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../mode/login/login_response.dart';
import 'pref_constants.dart';

class SharedPrefs {
  // Singleton approach
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  SharedPreferences? sharedPreferences;

  sharedPreferencesInstance() async {
    if (sharedPreferences == null) {
      return sharedPreferences = await SharedPreferences.getInstance();
    } else {
      return sharedPreferences;
    }
  }

  /// AppUserToke
  Future<void> setUserToken(String? bearerToken) async {
    /// debugPrint("setToken $bearerToken");
    sharedPreferences!.setString(PrefConstants.token, bearerToken ?? "");
  }

  Future<String> getUserToken() async {
    String value = sharedPreferences!.getString(PrefConstants.token) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return  "";
  }

  /// HistoryID
  Future<void> setHistoryID(String? sHistoryID) async {
    /// debugPrint("setToken $bearerToken");
    sharedPreferences!.setString(PrefConstants.sHistoryID, sHistoryID ?? "");
  }

  Future<String> getHistoryID() async {
    String value = sharedPreferences!.getString(PrefConstants.sHistoryID) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return  "";
  }


  /// userId
  Future<void> setUserId(String? userId) async {
    /// debugPrint("setToken $bearerToken");
    sharedPreferences!.setString(PrefConstants.userId, userId ?? "");
  }

  Future<String> getUserId() async {
    String value = sharedPreferences!.getString(PrefConstants.userId) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return  "";
  }

  /// configurationAccessToken
  Future<void> setConfigurationAccessToken(String? configurationAccessToken) async {
    /// debugPrint("setToken configurationAccessToken");
    sharedPreferences!.setString(PrefConstants.configurationAccessToken, configurationAccessToken ?? "");
  }

  Future<String> getConfigurationAccessToken() async {
    String value = sharedPreferences!.getString(PrefConstants.configurationAccessToken) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return  "";
  }


}
