/// error : false
/// statusCode : 200
/// statusMessage : "Login successfully."
/// data : {"userId":"2aaa120b-035f-4444-b099-ea66d6df2bc8","email":"testignore@jbjs.com","accessToken":"VByytORJL_YGEkazDuawZXT_h3eFBfOXoszRWS5AxsTfadjx4S6AmoEWVtzSJjcxVQVlJbbqL_aOLJ2r1BVW6Jkg7bekJu9G931UzRNn9xKmIuNDWTWwVSgMSqq2tTjyWbCrwk16r5fdcdD7t_R6oQfiFkhQluvJqel0RqbCYY9TlVql0ulwgw0ij93QKUfeTVoAlPTgmBkWqIc5PP3wsl2uZQ96bP1uVAkbtss0qtb4fx0AeepW0jRcBVsnLxgH21E69jg9GU9_JYrF4SPxZa-CHKnjL98-NrJfW0fhxBNLI4_ZqgZovjKiFm2mGk6t8GN39LNbi2zPEwCdkCNKen9VdQot6qRsSGWY9GPfsSwEp_9wPIXogt9IejeFS30wf6z9nofvltIFXlAeoiah-GtXaeoEGft2-kKAFofj-FKB9iTJinNf2G2BtalfQKgacLTsGOZcpIJwDTZP5oXjxhVrquhzEKLB_tRjgdl1PdwnJvA-6SgJKvSkZQzTjwPPph9pnFqlVFc_--RFlcuXzg"}

class LoginResponse {
  LoginResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    LoginResponseData? data,}) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
  }

  LoginResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data =
    json['data'] != null ? LoginResponseData.fromJson(json['data']) : null;
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  LoginResponseData? _data;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  LoginResponseData? get data => _data;

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

/// userId : "2aaa120b-035f-4444-b099-ea66d6df2bc8"
/// email : "testignore@jbjs.com"
/// accessToken : "VByytORJL_YGEkazDuawZXT_h3eFBfOXoszRWS5AxsTfadjx4S6AmoEWVtzSJjcxVQVlJbbqL_aOLJ2r1BVW6Jkg7bekJu9G931UzRNn9xKmIuNDWTWwVSgMSqq2tTjyWbCrwk16r5fdcdD7t_R6oQfiFkhQluvJqel0RqbCYY9TlVql0ulwgw0ij93QKUfeTVoAlPTgmBkWqIc5PP3wsl2uZQ96bP1uVAkbtss0qtb4fx0AeepW0jRcBVsnLxgH21E69jg9GU9_JYrF4SPxZa-CHKnjL98-NrJfW0fhxBNLI4_ZqgZovjKiFm2mGk6t8GN39LNbi2zPEwCdkCNKen9VdQot6qRsSGWY9GPfsSwEp_9wPIXogt9IejeFS30wf6z9nofvltIFXlAeoiah-GtXaeoEGft2-kKAFofj-FKB9iTJinNf2G2BtalfQKgacLTsGOZcpIJwDTZP5oXjxhVrquhzEKLB_tRjgdl1PdwnJvA-6SgJKvSkZQzTjwPPph9pnFqlVFc_--RFlcuXzg"

class LoginResponseData {
  LoginResponseData({
    String? userId,
    String? email,
    String? accessToken,}) {
    _userId = userId;
    _email = email;
    _accessToken = accessToken;
  }

  LoginResponseData.fromJson(dynamic json) {
    _userId = json['userId'];
    _email = json['email'];
    _accessToken = json['accessToken'];
  }

  String? _userId;
  String? _email;
  String? _accessToken;

  String? get userId => _userId;

  String? get email => _email;

  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['email'] = _email;
    map['accessToken'] = _accessToken;
    return map;
  }

}