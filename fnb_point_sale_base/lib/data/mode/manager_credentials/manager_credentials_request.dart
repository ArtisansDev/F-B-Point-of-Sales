/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// Email : "Prashant12345@gmail.com"
/// Password : "Admin@123"

class ManagerCredentialsRequest {
  ManagerCredentialsRequest({
      String? branchIDF, 
      String? email, 
      String? password,}){
    _branchIDF = branchIDF;
    _email = email;
    _password = password;
}

  ManagerCredentialsRequest.fromJson(dynamic json) {
    _branchIDF = json['BranchIDF'];
    _email = json['Email'];
    _password = json['Password'];
  }
  String? _branchIDF;
  String? _email;
  String? _password;

  String? get branchIDF => _branchIDF;
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchIDF'] = _branchIDF;
    map['Email'] = _email;
    map['Password'] = _password;
    return map;
  }

}