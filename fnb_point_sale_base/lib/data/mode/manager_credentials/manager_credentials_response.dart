/// error : true
/// statusCode : 200
/// statusMessage : "General Manager access granted"
/// data : {"GeneralManagerUserID":"915d6494-48b2-424a-afe4-fbf9899d6378"}

class ManagerCredentialsResponse {
  ManagerCredentialsResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage,
    ManagerCredentialsData? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  ManagerCredentialsResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'] != null ? ManagerCredentialsData.fromJson(json['data']) : null;
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  ManagerCredentialsData? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  ManagerCredentialsData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// GeneralManagerUserID : "915d6494-48b2-424a-afe4-fbf9899d6378"

class ManagerCredentialsData {
  ManagerCredentialsData({
      String? generalManagerUserID,}){
    _generalManagerUserID = generalManagerUserID;
}

  ManagerCredentialsData.fromJson(dynamic json) {
    _generalManagerUserID = json['GeneralManagerUserID'];
  }
  String? _generalManagerUserID;

  String? get generalManagerUserID => _generalManagerUserID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GeneralManagerUserID'] = _generalManagerUserID;
    return map;
  }

}