/// code : 400
/// error_code : "invalid_credentials"
/// msg : "Invalid login credentials"

class LoginFailedResponse {
  LoginFailedResponse({
      this.code, 
      this.errorCode, 
      this.details,
      this.msg,});

  LoginFailedResponse.fromJson(dynamic json) {
    code = json['code'].toString();
    details = json['details'];
    errorCode = json['error_code'];
    msg = json['msg'];
    message = json['message'];
  }
  String? code;
  String? details;
  String? errorCode;
  String? msg;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['details'] = details;
    map['error_code'] = errorCode;
    map['msg'] = msg;
    map['message'] = message;
    return map;
  }

}