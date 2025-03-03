/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"RestaurantData":[{"RestaurantIDP":"0d74bfa1-af7d-4182-835b-b815c2972591","RestaurantName":"Apple Cinemas","RestaurantLogoPath":"638678016950230894-images.jpg","Pincode":"360001","Address":"test,gujrat","ContactEmail":"test@gmail.com","ContactNumber":"9988776655","TermsAndConditions":"<ul><li><i>test1</i></li><li><i>test2</i><ul><li><i>test3</i></li><li><i>test4</i></li><li><i>test5</i></li><li><i>test6</i></li><li><i>test7</i></li><li><i>test9</i></li><li><i>test10</i></li></ul></li></ul>"}],"BranchData":[{"BranchIDP":"8281f828-2f99-457e-ac27-06914abbe720","BranchName":"Apple Cinema - Sarkhej, Ahmedabad"}],"CurrencyData":[{"CurrencyIDP":"28ae5e45-12c6-42e0-933c-68bb9fce97ff","CurrencyCode":"MYR","CurrencySymbol":"RM"}],"TaxData":[{"TaxPercentage":5.00,"TaxName":"SST","TaxIDP":"7aad68ca-7edb-4e36-a893-a191f6702ac2"},{"TaxPercentage":10.00,"TaxName":"Service Tax","TaxIDP":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7"}],"CounterData":[{"CounterIDP":"0ac73a88-8f99-4a4e-931b-9351f29df177","CounterName":"Sarkhej Counter -2"}]}

class ConfigurationResponse {
  ConfigurationResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    ConfigurationData? configurationData,}) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _configurationData = configurationData;
  }

  ConfigurationResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _configurationData =
    json['data'] != null ? ConfigurationData.fromJson(json['data']) : null;
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  ConfigurationData? _configurationData;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  ConfigurationData? get configurationData => _configurationData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_configurationData != null) {
      map['data'] = _configurationData?.toJson();
    }
    return map;
  }

}

/// RestaurantData : [{"RestaurantIDP":"0d74bfa1-af7d-4182-835b-b815c2972591","RestaurantName":"Apple Cinemas","RestaurantLogoPath":"638678016950230894-images.jpg","Pincode":"360001","Address":"test,gujrat","ContactEmail":"test@gmail.com","ContactNumber":"9988776655","TermsAndConditions":"<ul><li><i>test1</i></li><li><i>test2</i><ul><li><i>test3</i></li><li><i>test4</i></li><li><i>test5</i></li><li><i>test6</i></li><li><i>test7</i></li><li><i>test9</i></li><li><i>test10</i></li></ul></li></ul>"}]
/// BranchData : [{"BranchIDP":"8281f828-2f99-457e-ac27-06914abbe720","BranchName":"Apple Cinema - Sarkhej, Ahmedabad"}]
/// CurrencyData : [{"CurrencyIDP":"28ae5e45-12c6-42e0-933c-68bb9fce97ff","CurrencyCode":"MYR","CurrencySymbol":"RM"}]
/// TaxData : [{"TaxPercentage":5.00,"TaxName":"SST","TaxIDP":"7aad68ca-7edb-4e36-a893-a191f6702ac2"},{"TaxPercentage":10.00,"TaxName":"Service Tax","TaxIDP":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7"}]
/// CounterData : [{"CounterIDP":"0ac73a88-8f99-4a4e-931b-9351f29df177","CounterName":"Sarkhej Counter -2"}]
/// LoggedInUserDetails : [ { "Id": "bdbb6d98-068a-4b96-8c55-63ecf3c554d9", "Email": "prashanttestingoperator@gmail.com", "Name": "Prashant Chauhan" } ]

class ConfigurationData {
  ConfigurationData({
    List<RestaurantData>? restaurantData,
    List<BranchData>? branchData,
    List<CurrencyData>? currencyData,
    List<TaxData>? taxData,
    List<LoggedInUserDetails>? loggedInUserDetails,
    List<PrinterSettingsData>? printerSettingsData,
    List<CounterData>? counterData,}) {
    _restaurantData = restaurantData;
    _branchData = branchData;
    _currencyData = currencyData;
    _taxData = taxData;
    _counterData = counterData;
    _loggedInUserDetails = loggedInUserDetails;
    _printerSettingsData = printerSettingsData;
  }

  ConfigurationData.fromJson(dynamic json) {
    if (json['RestaurantData'] != null) {
      _restaurantData = [];
      json['RestaurantData'].forEach((v) {
        _restaurantData?.add(RestaurantData.fromJson(v));
      });
    }
    if (json['BranchData'] != null) {
      _branchData = [];
      json['BranchData'].forEach((v) {
        _branchData?.add(BranchData.fromJson(v));
      });
    }
    if (json['CurrencyData'] != null) {
      _currencyData = [];
      json['CurrencyData'].forEach((v) {
        _currencyData?.add(CurrencyData.fromJson(v));
      });
    }
    if (json['TaxData'] != null) {
      _taxData = [];
      json['TaxData'].forEach((v) {
        _taxData?.add(TaxData.fromJson(v));
      });
    }
    if (json['LoggedInUserDetails'] != null) {
      _loggedInUserDetails = [];
      json['LoggedInUserDetails'].forEach((v) {
        _loggedInUserDetails?.add(LoggedInUserDetails.fromJson(v));
      });
    }
    if (json['PrinterSettingsData'] != null) {
      _printerSettingsData = [];
      json['PrinterSettingsData'].forEach((v) {
        _printerSettingsData?.add(PrinterSettingsData.fromJson(v));
      });
    }
    if (json['CounterData'] != null) {
      _counterData = [];
      json['CounterData'].forEach((v) {
        _counterData?.add(CounterData.fromJson(v));
      });
    }
  }

  List<RestaurantData>? _restaurantData;
  List<BranchData>? _branchData;
  List<CurrencyData>? _currencyData;
  List<TaxData>? _taxData;
  List<CounterData>? _counterData;
  List<LoggedInUserDetails>? _loggedInUserDetails;
  List<PrinterSettingsData>? _printerSettingsData;

  List<RestaurantData>? get restaurantData => _restaurantData;

  List<BranchData>? get branchData => _branchData;

  List<CurrencyData>? get currencyData => _currencyData;

  List<TaxData>? get taxData => _taxData;

  List<LoggedInUserDetails>? get loggedInUserDetails => _loggedInUserDetails;

  List<PrinterSettingsData>? get printerSettingsData => _printerSettingsData;

  List<CounterData>? get counterData => _counterData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_restaurantData != null) {
      map['RestaurantData'] = _restaurantData?.map((v) => v.toJson()).toList();
    }
    if (_branchData != null) {
      map['BranchData'] = _branchData?.map((v) => v.toJson()).toList();
    }
    if (_currencyData != null) {
      map['CurrencyData'] = _currencyData?.map((v) => v.toJson()).toList();
    }
    if (_taxData != null) {
      map['TaxData'] = _taxData?.map((v) => v.toJson()).toList();
    }
    if (_loggedInUserDetails != null) {
      map['LoggedInUserDetails'] = _loggedInUserDetails?.map((v) => v.toJson()).toList();
    }
    if (_printerSettingsData != null) {
      map['PrinterSettingsData'] = _printerSettingsData?.map((v) => v.toJson()).toList();
    }
    if (_counterData != null) {
      map['CounterData'] = _counterData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// CounterIDP : "0ac73a88-8f99-4a4e-931b-9351f29df177"
/// CounterName : "Sarkhej Counter -2"

class CounterData {
  CounterData({
    String? counterIDP,
    String? counterName,}) {
    _counterIDP = counterIDP;
    _counterName = counterName;
  }

  CounterData.fromJson(dynamic json) {
    _counterIDP = json['CounterIDP'];
    _counterName = json['CounterName'];
  }

  String? _counterIDP;
  String? _counterName;

  String? get counterIDP => _counterIDP;

  String? get counterName => _counterName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CounterIDP'] = _counterIDP;
    map['CounterName'] = _counterName;
    return map;
  }

}

/// TaxPercentage : 5.00
/// TaxName : "SST"
/// TaxIDP : "7aad68ca-7edb-4e36-a893-a191f6702ac2"

class TaxData {
  TaxData({
    double? taxPercentage,
    String? taxName,
    String? taxIDP,}) {
    _taxPercentage = taxPercentage;
    _taxName = taxName;
    _taxIDP = taxIDP;
  }

  TaxData.fromJson(dynamic json) {
    _taxPercentage = json['TaxPercentage'];
    _taxName = json['TaxName'];
    _taxIDP = json['TaxIDP'];
  }

  double? _taxPercentage;
  String? _taxName;
  String? _taxIDP;

  double? get taxPercentage => _taxPercentage;

  String? get taxName => _taxName;

  String? get taxIDP => _taxIDP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TaxPercentage'] = _taxPercentage;
    map['TaxName'] = _taxName;
    map['TaxIDP'] = _taxIDP;
    return map;
  }

}

/// CurrencyIDP : "28ae5e45-12c6-42e0-933c-68bb9fce97ff"
/// CurrencyCode : "MYR"
/// CurrencySymbol : "RM"

class CurrencyData {
  CurrencyData({
    String? currencyIDP,
    String? currencyCode,
    String? currencySymbol,}) {
    _currencyIDP = currencyIDP;
    _currencyCode = currencyCode;
    _currencySymbol = currencySymbol;
  }

  CurrencyData.fromJson(dynamic json) {
    _currencyIDP = json['CurrencyIDP'];
    _currencyCode = json['CurrencyCode'];
    _currencySymbol = json['CurrencySymbol'];
  }

  String? _currencyIDP;
  String? _currencyCode;
  String? _currencySymbol;

  String? get currencyIDP => _currencyIDP;

  String? get currencyCode => _currencyCode;

  String? get currencySymbol => _currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CurrencyIDP'] = _currencyIDP;
    map['CurrencyCode'] = _currencyCode;
    map['CurrencySymbol'] = _currencySymbol;
    return map;
  }

}

/// BranchIDP : "8281f828-2f99-457e-ac27-06914abbe720"
/// BranchName : "Apple Cinema - Sarkhej, Ahmedabad"
/// BranchAddress : "Apple Cinema - Sarkhej, Ahmedabad"
/// Email : "ashishgohel005@gmail.com"
/// CustomerSupportNumber : ""
/// MobileNumber : "+60 8668886888"
/// DineIn : true
/// Takeaway : true

class BranchData {
  BranchData({
    String? branchIDP,
    String? branchName,
    String? branchAddress,
    String? email,
    String? customerSupportNumber,
    String? mobileNumber,
    bool? dineIn,
    bool? takeaway,}){
    _branchIDP = branchIDP;
    _branchName = branchName;
    _branchAddress = branchAddress;
    _email = email;
    _customerSupportNumber = customerSupportNumber;
    _mobileNumber = mobileNumber;
    _dineIn = dineIn;
    _takeaway = takeaway;
  }

  BranchData.fromJson(dynamic json) {
    _branchIDP = json['BranchIDP'];
    _branchName = json['BranchName'];
    _branchAddress = json['BranchAddress'];
    _email = json['Email'];
    _customerSupportNumber = json['CustomerSupportNumber'];
    _mobileNumber = json['MobileNumber'];
    _dineIn = json['DineIn'];
    _takeaway = json['Takeaway'];
  }
  String? _branchIDP;
  String? _branchName;
  String? _branchAddress;
  String? _email;
  String? _customerSupportNumber;
  String? _mobileNumber;
  bool? _dineIn;
  bool? _takeaway;

  String? get branchIDP => _branchIDP;
  String? get branchName => _branchName;
  String? get branchAddress => _branchAddress;
  String? get email => _email;
  String? get customerSupportNumber => _customerSupportNumber;
  String? get mobileNumber => _mobileNumber;
  bool? get dineIn => _dineIn;
  bool? get takeaway => _takeaway;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchIDP'] = _branchIDP;
    map['BranchName'] = _branchName;
    map['BranchAddress'] = _branchAddress;
    map['Email'] = _email;
    map['CustomerSupportNumber'] = _customerSupportNumber;
    map['MobileNumber'] = _mobileNumber;
    map['DineIn'] = _dineIn;
    map['Takeaway'] = _takeaway;
    return map;
  }

}

///"Id": "bdbb6d98-068a-4b96-8c55-63ecf3c554d9",
///"Email": "prashanttestingoperator@gmail.com",
///"Name": "Prashant Chauhan"

class LoggedInUserDetails {
  LoggedInUserDetails({
    String? id,
    String? name,
    String? email,
  }) {
    _id = id;
    _email = email;
    _name = name;
  }

  LoggedInUserDetails.fromJson(dynamic json) {
    _id = json['Id'];
    _email = json['Email'];
    _name = json['Name'];
  }

  String? _id;
  String? _email;
  String? _name;

  String? get id => _id;

  String? get email => _email;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Email'] = _email;
    map['Name'] = _name;
    return map;
  }

}

/// RestaurantIDP : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// RestaurantName : "Apple Cinemas"
/// RestaurantLogoPath : "638678016950230894-images.jpg"
/// Pincode : "360001"
/// Address : "test,gujrat"
/// ContactEmail : "test@gmail.com"
/// ContactNumber : "9988776655"
/// OrderIDPrefixCode : "APP"
/// TagLine : "Demo"
/// TermsAndConditions : "<ul><li><i>test1</i></li><li><i>test2</i><ul><li><i>test3</i></li><li><i>test4</i></li><li><i>test5</i></li><li><i>test6</i></li><li><i>test7</i></li><li><i>test9</i></li><li><i>test10</i></li></ul></li></ul>"

class RestaurantData {
  RestaurantData({
    String? restaurantIDP,
    String? restaurantName,
    String? restaurantLogoPath,
    String? pincode,
    String? address,
    String? contactEmail,
    String? contactNumber,
    String? orderIDPrefixCode,
    String? tagLine,
    String? termsAndConditions,}) {
    _restaurantIDP = restaurantIDP;
    _restaurantName = restaurantName;
    _restaurantLogoPath = restaurantLogoPath;
    _pincode = pincode;
    _address = address;
    _contactEmail = contactEmail;
    _contactNumber = contactNumber;
    _termsAndConditions = termsAndConditions;
    _orderIDPrefixCode = orderIDPrefixCode;
    _tagLine = tagLine;
  }

  RestaurantData.fromJson(dynamic json) {
    _restaurantIDP = json['RestaurantIDP'];
    _restaurantName = json['RestaurantName'];
    _restaurantLogoPath = json['RestaurantLogoPath'];
    _pincode = json['Pincode'];
    _address = json['Address'];
    _contactEmail = json['ContactEmail'];
    _contactNumber = json['ContactNumber'];
    _termsAndConditions = json['TermsAndConditions'];
    _orderIDPrefixCode = json['OrderIDPrefixCode'];
    _tagLine = json['TagLine'];
  }

  String? _restaurantIDP;
  String? _restaurantName;
  String? _restaurantLogoPath;
  String? _pincode;
  String? _address;
  String? _contactEmail;
  String? _contactNumber;
  String? _termsAndConditions;
  String? _orderIDPrefixCode;
  String? _tagLine;

  String? get restaurantIDP => _restaurantIDP;

  String? get restaurantName => _restaurantName;

  String? get restaurantLogoPath => _restaurantLogoPath;

  String? get pincode => _pincode;

  String? get address => _address;

  String? get contactEmail => _contactEmail;

  String? get contactNumber => _contactNumber;

  String? get termsAndConditions => _termsAndConditions;

  String? get orderIDPrefixCode => _orderIDPrefixCode;

  String? get tagLine => _tagLine;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDP'] = _restaurantIDP;
    map['RestaurantName'] = _restaurantName;
    map['RestaurantLogoPath'] = _restaurantLogoPath;
    map['Pincode'] = _pincode;
    map['Address'] = _address;
    map['ContactEmail'] = _contactEmail;
    map['ContactNumber'] = _contactNumber;
    map['TermsAndConditions'] = _termsAndConditions;
    map['OrderIDPrefixCode'] = _orderIDPrefixCode;
    map['TagLine'] = _tagLine;
    return map;
  }

}

/// PrintType : "K"
/// PrintTypeText : "Kitchen"
/// PrintCopies : 2
/// EnableBranchName : false
/// EnableBranchAddress : false
/// EnableOrderTrackingID : true
/// EnableTaxInfo : false
/// EnableDateTime : true
/// EnableLogo : false
/// EnableHeader : false
/// EnableFooter : false
/// EnableTitleText : false
/// EnableCustomText : false
/// CustomTitleText : ""
/// CustomHeaderText : ""
/// CustomFooterText : ""
/// CustomMessageText : ""
/// EnableAdditionalNotes : true
/// EnableItemWiseNotes : true
/// EnablePackagingInfo : true

class PrinterSettingsData {
  PrinterSettingsData({
    String? printType,
    String? printTypeText,
    int? printCopies,
    bool? enableBranchName,
    bool? enableBranchAddress,
    bool? enableOrderTrackingID,
    bool? enableTaxInfo,
    bool? enableDateTime,
    bool? enableLogo,
    bool? enableHeader,
    bool? enableFooter,
    bool? enableTitleText,
    bool? enableCustomText,
    String? customTitleText,
    String? customHeaderText,
    String? customFooterText,
    String? customMessageText,
    bool? enableAdditionalNotes,
    bool? enableItemWiseNotes,
    bool? enablePackagingInfo,}){
    _printType = printType;
    _printTypeText = printTypeText;
    _printCopies = printCopies;
    _enableBranchName = enableBranchName;
    _enableBranchAddress = enableBranchAddress;
    _enableOrderTrackingID = enableOrderTrackingID;
    _enableTaxInfo = enableTaxInfo;
    _enableDateTime = enableDateTime;
    _enableLogo = enableLogo;
    _enableHeader = enableHeader;
    _enableFooter = enableFooter;
    _enableTitleText = enableTitleText;
    _enableCustomText = enableCustomText;
    _customTitleText = customTitleText;
    _customHeaderText = customHeaderText;
    _customFooterText = customFooterText;
    _customMessageText = customMessageText;
    _enableAdditionalNotes = enableAdditionalNotes;
    _enableItemWiseNotes = enableItemWiseNotes;
    _enablePackagingInfo = enablePackagingInfo;
  }

  PrinterSettingsData.fromJson(dynamic json) {
    _printType = json['PrintType'];
    _printTypeText = json['PrintTypeText'];
    _printCopies = json['PrintCopies'];
    _enableBranchName = json['EnableBranchName'];
    _enableBranchAddress = json['EnableBranchAddress'];
    _enableOrderTrackingID = json['EnableOrderTrackingID'];
    _enableTaxInfo = json['EnableTaxInfo'];
    _enableDateTime = json['EnableDateTime'];
    _enableLogo = json['EnableLogo'];
    _enableHeader = json['EnableHeader'];
    _enableFooter = json['EnableFooter'];
    _enableTitleText = json['EnableTitleText'];
    _enableCustomText = json['EnableCustomText'];
    _customTitleText = json['CustomTitleText'];
    _customHeaderText = json['CustomHeaderText'];
    _customFooterText = json['CustomFooterText'];
    _customMessageText = json['CustomMessageText'];
    _enableAdditionalNotes = json['EnableAdditionalNotes'];
    _enableItemWiseNotes = json['EnableItemWiseNotes'];
    _enablePackagingInfo = json['EnablePackagingInfo'];
  }
  String? _printType;
  String? _printTypeText;
  int? _printCopies;
  bool? _enableBranchName;
  bool? _enableBranchAddress;
  bool? _enableOrderTrackingID;
  bool? _enableTaxInfo;
  bool? _enableDateTime;
  bool? _enableLogo;
  bool? _enableHeader;
  bool? _enableFooter;
  bool? _enableTitleText;
  bool? _enableCustomText;
  String? _customTitleText;
  String? _customHeaderText;
  String? _customFooterText;
  String? _customMessageText;
  bool? _enableAdditionalNotes;
  bool? _enableItemWiseNotes;
  bool? _enablePackagingInfo;

  String? get printType => _printType;
  String? get printTypeText => _printTypeText;
  int? get printCopies => _printCopies;
  bool? get enableBranchName => _enableBranchName;
  bool? get enableBranchAddress => _enableBranchAddress;
  bool? get enableOrderTrackingID => _enableOrderTrackingID;
  bool? get enableTaxInfo => _enableTaxInfo;
  bool? get enableDateTime => _enableDateTime;
  bool? get enableLogo => _enableLogo;
  bool? get enableHeader => _enableHeader;
  bool? get enableFooter => _enableFooter;
  bool? get enableTitleText => _enableTitleText;
  bool? get enableCustomText => _enableCustomText;
  String? get customTitleText => _customTitleText;
  String? get customHeaderText => _customHeaderText;
  String? get customFooterText => _customFooterText;
  String? get customMessageText => _customMessageText;
  bool? get enableAdditionalNotes => _enableAdditionalNotes;
  bool? get enableItemWiseNotes => _enableItemWiseNotes;
  bool? get enablePackagingInfo => _enablePackagingInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PrintType'] = _printType;
    map['PrintTypeText'] = _printTypeText;
    map['PrintCopies'] = _printCopies;
    map['EnableBranchName'] = _enableBranchName;
    map['EnableBranchAddress'] = _enableBranchAddress;
    map['EnableOrderTrackingID'] = _enableOrderTrackingID;
    map['EnableTaxInfo'] = _enableTaxInfo;
    map['EnableDateTime'] = _enableDateTime;
    map['EnableLogo'] = _enableLogo;
    map['EnableHeader'] = _enableHeader;
    map['EnableFooter'] = _enableFooter;
    map['EnableTitleText'] = _enableTitleText;
    map['EnableCustomText'] = _enableCustomText;
    map['CustomTitleText'] = _customTitleText;
    map['CustomHeaderText'] = _customHeaderText;
    map['CustomFooterText'] = _customFooterText;
    map['CustomMessageText'] = _customMessageText;
    map['EnableAdditionalNotes'] = _enableAdditionalNotes;
    map['EnableItemWiseNotes'] = _enableItemWiseNotes;
    map['EnablePackagingInfo'] = _enablePackagingInfo;
    return map;
  }

}