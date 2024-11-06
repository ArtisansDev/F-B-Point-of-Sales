
class LoginRequest {
  LoginRequest({
    String? password,
    String? email,
  }) {
    _password = password;
    _email = email;
  }

  LoginRequest.fromJson(dynamic json) {
    _password = json['password'];
    _email = json['email'];
  }

  String? _password;
  String? _email;

  String? get password => _password;

  String? get email => _email;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(_password!=null) {
      map['password'] = _password;
    }
    map['email'] = _email;
    return map;
  }
}
