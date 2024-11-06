

import 'app_constants.dart';

class WebConstants {

  // Standard Comparison Values
  static int statusCode200 = 200;
  static int statusCode201 = 201;
  static int statusCode204 = 204;
  static int statusCode400 = 400;
  static int statusCode401 = 401;
  static int statusCode422 = 422;

  static String statusMessageOK = "OK";
  static String statusMessageBadRequest = "Bad Request";
  static String statusMessageEntityError = "Unprocessable Entity Error";
  static String statusMessageTokenIsExpired = "Token is Expired";

  // Web response cases
  static String statusCode403Message =
      "{  \"error\" : true,\n  \"status\" : 403,\n  \"message\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unauthorized error\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode404Message =
      "{  \"error\" : true,\n  \"status\" : 404,\n  \"message\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to find the action URL\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode502Message =
      "{\r\n  \"error\": true,\r\n  \"status\": 502,\r\n  \"message\": \"Bad Request\",\r\n  \"data\": {\r\n    \"message\": \"Server Error, Please try after sometime\"\r\n  },\r\n  \"responseTime\": 1639548038\r\n}";
  static String statusCode503Message =
      "{  \"error\" : true,\n  \"status\" : 503,\n  \"message\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to process your request right now, Please try again later\"},\n  \"responseTime\" : 1639548038\n  }";

  ///APP_NAME
  static String appName = "auth/";

  ///API_VERSION
  static String apiVersion = "";

  /// Base URL
  static String baseUrlLive = "https://ldcldlygclwxedygjted.supabase.co/";
  static String baseUrlDev = "https://ldcldlygclwxedygjted.supabase.co/";
  static String baseURL =
  BaseAppConstants.isLiveURLToUse ? baseUrlLive : baseUrlDev;

  /// Webservice
  /// Avoid kDebugMode(it can be profile mode) prefer using kReleaseMode only
  // static String baseUrlCommon = baseURL+appName+apiVersion;
  static String baseUrlCommon = baseURL+apiVersion;
  static bool auth = false;


  /// Master - all Url
  static String actionLogin =  "auth/v1/token?grant_type=password";  //post
  static String actionSignup =  "auth/v1/signup";  //post
  static String actionLogout =  "auth/v1/logout";  //post
  static String actionFotGottenPassword =  "auth/v1/recover";  //post
  static String actionConfigurationAll =  "rest/v1/configuration";  //get
  static String actionConfigurationAdd=  "rest/v1/configuration";  //post
  static String actionDeviceGroupAll =  "rest/v1/device_group?select=*";  //get
  static String actionDeviceGroupAdd=  "rest/v1/device_group";  //post
  static String actionDeviceAll =  "rest/v1/device?select=*"; //get
  static String actionDeviceAdd=  "rest/v1/device";  //post
  static String actionDeviceLogsAll =  "rest/v1/device_logs?select=*";  //get
  static String actionApplicationsAll =  "rest/v1/applications?select=*";//get
  static String actionApplicationAdd=  "rest/v1/applications";  //post
  static String actionPushMessageAll =  "rest/v1/push_message?select=*";//get
  static String actionPushMessageAdd=  "rest/v1/push_message";  //post
  static String actionLocationLogsId =  "rest/v1/location_logs?select=*&device_id=eq.";//get
  static String actionDataUsageId =  "rest/v1/data_usage?select=*&device_id=eq.";//get
  static String actionInstalledAppsId =  "rest/v1/installed_apps?select=*&device_id=eq.";//get
  static String actionDeviceInfoId =  "rest/v1/device_info?select=*&device_id=eq.";//get
  static String actionDashboard =  "rest/v1/rpc/get_dashboard_data";//post




  // static String actionVerifyOtp =  "verify-otp";  //post
  // static String actionProfile =  "profile";  //post
  // static String actionAssessmentList =  "assessment-list";//post
  // static String actionAssessmentResult =  "assessment-result";  //post
  // static String actionCourseList =  "course-list";  //post
  // static String actionCourseDetail =  "course-detail";  //post
  // static String actionManageTwoFactorAuthentication =  "manage-two-factor-authentication";  //post
  // static String actionChangePassword =  "change-password";  //post
  // static String actionForgotPassword =  "forgot-password";  //post
  // static String actionForgotPasswordUpdate =  "forgot-password-update";  //post
  // static String actionSubscriberDashboard =  "subscriber-dashboard";  //get
  // static String actionProfileUpdate =  "profile-update";  //post
  // static String actionProfilePictureUpdate =  "profile-picture-update";  //post
  // static String actionMasterList =  "master-list";  //get

}