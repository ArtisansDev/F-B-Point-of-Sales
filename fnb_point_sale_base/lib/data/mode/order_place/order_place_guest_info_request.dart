/// browserName : "Chrome"
/// appCodeName : "Mozilla"
/// appName : "Netscape"
/// appVersion : "91.0.4472.124"
/// deviceMemory : 8
/// language : "en-US"
/// languages : ["en-US","en"]
/// platform : "Win32"
/// product : "Gecko"
/// productSub : "20100101"
/// userAgent : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
/// vendor : "Google Inc."
/// vendorSub : ""
/// hardwareConcurrency : 4
/// maxTouchPoints : 10

class OrderPlaceGuestInfoRequest {
  OrderPlaceGuestInfoRequest({
      String? browserName, 
      String? appCodeName, 
      String? appName, 
      String? appVersion, 
      int? deviceMemory, 
      String? language, 
      List<String>? languages, 
      String? platform, 
      String? product, 
      String? productSub, 
      String? userAgent, 
      String? vendor, 
      String? vendorSub, 
      int? hardwareConcurrency, 
      int? maxTouchPoints,}){
    _browserName = browserName;
    _appCodeName = appCodeName;
    _appName = appName;
    _appVersion = appVersion;
    _deviceMemory = deviceMemory;
    _language = language;
    _languages = languages;
    _platform = platform;
    _product = product;
    _productSub = productSub;
    _userAgent = userAgent;
    _vendor = vendor;
    _vendorSub = vendorSub;
    _hardwareConcurrency = hardwareConcurrency;
    _maxTouchPoints = maxTouchPoints;
}

  OrderPlaceGuestInfoRequest.fromJson(dynamic json) {
    _browserName = json['browserName'];
    _appCodeName = json['appCodeName'];
    _appName = json['appName'];
    _appVersion = json['appVersion'];
    _deviceMemory = json['deviceMemory'];
    _language = json['language'];
    _languages = json['languages'] != null ? json['languages'].cast<String>() : [];
    _platform = json['platform'];
    _product = json['product'];
    _productSub = json['productSub'];
    _userAgent = json['userAgent'];
    _vendor = json['vendor'];
    _vendorSub = json['vendorSub'];
    _hardwareConcurrency = json['hardwareConcurrency'];
    _maxTouchPoints = json['maxTouchPoints'];
  }
  String? _browserName;
  String? _appCodeName;
  String? _appName;
  String? _appVersion;
  int? _deviceMemory;
  String? _language;
  List<String>? _languages;
  String? _platform;
  String? _product;
  String? _productSub;
  String? _userAgent;
  String? _vendor;
  String? _vendorSub;
  int? _hardwareConcurrency;
  int? _maxTouchPoints;

  String? get browserName => _browserName;
  String? get appCodeName => _appCodeName;
  String? get appName => _appName;
  String? get appVersion => _appVersion;
  int? get deviceMemory => _deviceMemory;
  String? get language => _language;
  List<String>? get languages => _languages;
  String? get platform => _platform;
  String? get product => _product;
  String? get productSub => _productSub;
  String? get userAgent => _userAgent;
  String? get vendor => _vendor;
  String? get vendorSub => _vendorSub;
  int? get hardwareConcurrency => _hardwareConcurrency;
  int? get maxTouchPoints => _maxTouchPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['browserName'] = _browserName;
    map['appCodeName'] = _appCodeName;
    map['appName'] = _appName;
    map['appVersion'] = _appVersion;
    map['deviceMemory'] = _deviceMemory;
    map['language'] = _language;
    map['languages'] = _languages;
    map['platform'] = _platform;
    map['product'] = _product;
    map['productSub'] = _productSub;
    map['userAgent'] = _userAgent;
    map['vendor'] = _vendor;
    map['vendorSub'] = _vendorSub;
    map['hardwareConcurrency'] = _hardwareConcurrency;
    map['maxTouchPoints'] = _maxTouchPoints;
    return map;
  }

}