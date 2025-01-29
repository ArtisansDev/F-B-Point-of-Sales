/// CounterIDF : "00000000-0000-0000-0000-000000000000"
/// UserIDF : "00000000-0000-0000-0000-000000000000"
/// IsLoggedIn : true
/// DeviceInfo : {"DeviceName":"POS Terminal 1","OS":"Windows 10","IPAddress":"192.168.1.100","MACAddress":"00:1A:2B:3C:4D:5E"}

class UpdateLoginStatusRequest {
  UpdateLoginStatusRequest({
      String? counterIDF, 
      String? userIDF, 
      bool? isLoggedIn, 
      DeviceInfo? deviceInfo,}){
    _counterIDF = counterIDF;
    _userIDF = userIDF;
    _isLoggedIn = isLoggedIn;
    _deviceInfo = deviceInfo;
}

  UpdateLoginStatusRequest.fromJson(dynamic json) {
    _counterIDF = json['CounterIDF'];
    _userIDF = json['UserIDF'];
    _isLoggedIn = json['IsLoggedIn'];
    _deviceInfo = json['DeviceInfo'] != null ? DeviceInfo.fromJson(json['DeviceInfo']) : null;
  }
  String? _counterIDF;
  String? _userIDF;
  bool? _isLoggedIn;
  DeviceInfo? _deviceInfo;

  String? get counterIDF => _counterIDF;
  String? get userIDF => _userIDF;
  bool? get isLoggedIn => _isLoggedIn;
  DeviceInfo? get deviceInfo => _deviceInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CounterIDF'] = _counterIDF;
    map['UserIDF'] = _userIDF;
    map['IsLoggedIn'] = _isLoggedIn;
    if (_deviceInfo != null) {
      map['DeviceInfo'] = _deviceInfo?.toJson();
    }
    return map;
  }

}

/// DeviceName : "POS Terminal 1"
/// OS : "Windows 10"
/// IPAddress : "192.168.1.100"
/// MACAddress : "00:1A:2B:3C:4D:5E"

class DeviceInfo {
  DeviceInfo({
      String? deviceName, 
      String? os, 
      String? iPAddress, 
      String? mACAddress,}){
    _deviceName = deviceName;
    _os = os;
    _iPAddress = iPAddress;
    _mACAddress = mACAddress;
}

  DeviceInfo.fromJson(dynamic json) {
    _deviceName = json['DeviceName'];
    _os = json['OS'];
    _iPAddress = json['IPAddress'];
    _mACAddress = json['MACAddress'];
  }
  String? _deviceName;
  String? _os;
  String? _iPAddress;
  String? _mACAddress;

  String? get deviceName => _deviceName;
  String? get os => _os;
  String? get iPAddress => _iPAddress;
  String? get mACAddress => _mACAddress;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DeviceName'] = _deviceName;
    map['OS'] = _os;
    map['IPAddress'] = _iPAddress;
    map['MACAddress'] = _mACAddress;
    return map;
  }

}