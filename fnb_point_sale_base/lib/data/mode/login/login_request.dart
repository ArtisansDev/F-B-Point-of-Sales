class LoginRequest {
  LoginRequest({
    String? counterID,
    String? branchID,
    String? email,
    String? password,
  }) {
    _counterID = counterID;
    _branchID = branchID;
    _email = email;
    _password = password;
  }

  LoginRequest.fromJson(dynamic json) {
    _counterID = json['CounterID'];
    _branchID = json['BranchID'];
    _email = json['Email'];
    _password = json['Password'];
  }

  String? _counterID;
  String? _branchID;
  String? _email;
  String? _password;

  String? get counterID => _counterID;

  String? get branchID => _branchID;

  String? get email => _email;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CounterID'] = _counterID;
    map['BranchID'] = _branchID;
    map['Email'] = _email;
    map['Password'] = _password;
    return map;
  }
}
