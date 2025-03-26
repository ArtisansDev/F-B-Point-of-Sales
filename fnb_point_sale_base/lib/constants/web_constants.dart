

import 'app_constants.dart';

class WebConstants {
  static bool isFastTimeLogin = false;
  // Standard Comparison Values
  static int statusCode200 = 200;
  static int statusCode201 = 201;
  static int statusCode204 = 204;
  static int statusCode400 = 400;
  static int statusCode404 = 404;
  static int statusCode401 = 401;
  static int statusCode409 = 409;
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
  static String appName = "api/";

  ///API_VERSION
  static String apiVersion = "";

  /// Base URL https://aura.artisanscloud.com/
  static String baseUrlLive = "http://staging.artisanssolutions.com/";
  static String baseUrlDev = "http://staging.artisanssolutions.com/";
  static String baseURL =
  BaseAppConstants.isLiveURLToUse ? baseUrlLive : baseUrlDev;

  /// Webservice
  /// Avoid kDebugMode(it can be profile mode) prefer using kReleaseMode only
  // static String baseUrlCommon = baseURL+appName+apiVersion;
  static String baseUrlCommon = baseURL+appName+apiVersion;
  static bool auth = false;


  /// Master - all Url
  static String actionLogin =  "Account/operatorLogin";  //post
  static String actionConfiguration =  "Configuration/getConfiguration";  //post
  static String actionUpdatePOSLoginStatus =  "Account/updatePOSLoginStatus";  //post
  static String actionManagerCredentialsStatus =  "Account/validateBranchManagerCredentials";  //post

  ///product
  static String actionGetAllCategory =  "Category/GetAllCategory";  //post
  static String actionGetAllMenuItem =  "Menu/getAllMenuItem";  //post
  static String actionGetAllModifier =  "Menu/getAllModifier";  //post
  static String actionGetAllVariant =  "Menu/getAllVariant";  //post
  static String actionPostUpdateStockStatus =  "Menu/UpdateStockStatus";  //post
  static String actionPostGetStockData =  "Menu/GetStockData";  //post

  ///
  static String actionGetAllTables =  "Seat/getAllTables";  //post
  static String actionUpdateTableStatus =  "Seat/UpdateTableStatus";  //post
  static String actionGetAllTablesByTableStatus =  "Seat/getAllTablesByTableStatus";  //post
  static String actionGetAllPaymentType =  "POSPayment/getPaymentType";  //post

  /// CustomerApi
  static String actionCustomerSave =  "Customer/customerSave";  //post
  static String actionGetAllCustomer =  "Customer/GetCustomer";

  /// order place
  static String actionPOSOrder =  "POSOrder/ProcessMultipleOrders";
  static String actionPOSOrderHistory =  "POSOrder/GetOrderHistory";
  static String actionPOSUpdatePaymentType =  "POSOrder/UpdatePaymentType";

  /// Balance
  static String actionUpdateOpeningBalance =  "Counter/UpdateOpeningBalance";
  static String actionUpdateClosingBalance =  "Counter/updateClosingBalance";
  static String actionGetShiftDetails =  "Counter/GetShiftDetails";

}