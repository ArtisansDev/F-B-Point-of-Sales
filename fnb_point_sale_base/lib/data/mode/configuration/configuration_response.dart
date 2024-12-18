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

class ConfigurationData {
  ConfigurationData({
    List<RestaurantData>? restaurantData,
    List<BranchData>? branchData,
    List<CurrencyData>? currencyData,
    List<TaxData>? taxData,
    List<CounterData>? counterData,}) {
    _restaurantData = restaurantData;
    _branchData = branchData;
    _currencyData = currencyData;
    _taxData = taxData;
    _counterData = counterData;
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

  List<RestaurantData>? get restaurantData => _restaurantData;

  List<BranchData>? get branchData => _branchData;

  List<CurrencyData>? get currencyData => _currencyData;

  List<TaxData>? get taxData => _taxData;

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

class BranchData {
  BranchData({
    String? branchIDP,
    String? branchName,}) {
    _branchIDP = branchIDP;
    _branchName = branchName;
  }

  BranchData.fromJson(dynamic json) {
    _branchIDP = json['BranchIDP'];
    _branchName = json['BranchName'];
  }

  String? _branchIDP;
  String? _branchName;

  String? get branchIDP => _branchIDP;

  String? get branchName => _branchName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchIDP'] = _branchIDP;
    map['BranchName'] = _branchName;
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
    String? termsAndConditions,}) {
    _restaurantIDP = restaurantIDP;
    _restaurantName = restaurantName;
    _restaurantLogoPath = restaurantLogoPath;
    _pincode = pincode;
    _address = address;
    _contactEmail = contactEmail;
    _contactNumber = contactNumber;
    _termsAndConditions = termsAndConditions;
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
  }

  String? _restaurantIDP;
  String? _restaurantName;
  String? _restaurantLogoPath;
  String? _pincode;
  String? _address;
  String? _contactEmail;
  String? _contactNumber;
  String? _termsAndConditions;

  String? get restaurantIDP => _restaurantIDP;

  String? get restaurantName => _restaurantName;

  String? get restaurantLogoPath => _restaurantLogoPath;

  String? get pincode => _pincode;

  String? get address => _address;

  String? get contactEmail => _contactEmail;

  String? get contactNumber => _contactNumber;

  String? get termsAndConditions => _termsAndConditions;

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
    return map;
  }

}