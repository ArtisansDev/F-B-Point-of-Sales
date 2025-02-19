/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"TotalRecords":6,"FirstRecord":1,"LastRecord":6,"TotalPage":1,"Data":[{"SrNo":1,"CustomerIDP":"a08f954f-4ac1-427e-9172-7d6d69ea7b13","Name":"John Doe","PhoneCountryCode":"+60","PhoneNumber":"176172385","Email":"john.doe@example.com","Address":"123 Main St, City, Country"},{"SrNo":2,"CustomerIDP":"0fca3557-1ffc-4dfc-9580-8e84fde07957","Name":"ee Smithhh","PhoneCountryCode":"+1","PhoneNumber":"9886543210","Email":"janesmith@example.com","Address":"456 Elm St, City, Country"},{"SrNo":3,"CustomerIDP":"01fde304-bd69-4165-825b-98e2791afb9d","Name":"Johny Doeeeeeeeee","PhoneCountryCode":"+1","PhoneNumber":"1238568090","Email":"johndoe@example.com","Address":"123 Main St, City, Country"},{"SrNo":4,"CustomerIDP":"40bd02ec-9253-44b7-8518-df0a14483aeb","Name":"Jane Smith","PhoneCountryCode":"+1","PhoneNumber":"9876543210","Email":"janesmith@example.com","Address":"456 Elm St, City, Country"},{"SrNo":5,"CustomerIDP":"91a1c63f-54cc-4bb9-8703-4220f766f4c5","Name":"John Doeeee","PhoneCountryCode":"+1","PhoneNumber":"1234567090","Email":"johndoe@example.com","Address":"123 Main St, City, Country"},{"SrNo":6,"CustomerIDP":"e996ce62-5f70-4f97-8f53-1a11c220e975","Name":"John Doe","PhoneCountryCode":"+1","PhoneNumber":"1234567890","Email":"john.doe@example.com","Address":"123 Main St, City, Country"}]}

class GetAllCustomerResponse {
  GetAllCustomerResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    GetAllCustomerData? getAllCustomerData,
  }) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _getAllCustomerData = getAllCustomerData;
  }

  GetAllCustomerResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _getAllCustomerData =
        json['data'] != null ? GetAllCustomerData.fromJson(json['data']) : null;
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  GetAllCustomerData? _getAllCustomerData;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  GetAllCustomerData? get getAllCustomerData => _getAllCustomerData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_getAllCustomerData != null) {
      map['data'] = _getAllCustomerData?.toJson();
    }
    return map;
  }
}

/// TotalRecords : 6
/// FirstRecord : 1
/// LastRecord : 6
/// TotalPage : 1
/// Data : [{"SrNo":1,"CustomerIDP":"a08f954f-4ac1-427e-9172-7d6d69ea7b13","Name":"John Doe","PhoneCountryCode":"+60","PhoneNumber":"176172385","Email":"john.doe@example.com","Address":"123 Main St, City, Country"},{"SrNo":2,"CustomerIDP":"0fca3557-1ffc-4dfc-9580-8e84fde07957","Name":"ee Smithhh","PhoneCountryCode":"+1","PhoneNumber":"9886543210","Email":"janesmith@example.com","Address":"456 Elm St, City, Country"},{"SrNo":3,"CustomerIDP":"01fde304-bd69-4165-825b-98e2791afb9d","Name":"Johny Doeeeeeeeee","PhoneCountryCode":"+1","PhoneNumber":"1238568090","Email":"johndoe@example.com","Address":"123 Main St, City, Country"},{"SrNo":4,"CustomerIDP":"40bd02ec-9253-44b7-8518-df0a14483aeb","Name":"Jane Smith","PhoneCountryCode":"+1","PhoneNumber":"9876543210","Email":"janesmith@example.com","Address":"456 Elm St, City, Country"},{"SrNo":5,"CustomerIDP":"91a1c63f-54cc-4bb9-8703-4220f766f4c5","Name":"John Doeeee","PhoneCountryCode":"+1","PhoneNumber":"1234567090","Email":"johndoe@example.com","Address":"123 Main St, City, Country"},{"SrNo":6,"CustomerIDP":"e996ce62-5f70-4f97-8f53-1a11c220e975","Name":"John Doe","PhoneCountryCode":"+1","PhoneNumber":"1234567890","Email":"john.doe@example.com","Address":"123 Main St, City, Country"}]

class GetAllCustomerData {
  GetAllCustomerData({
    int? totalRecords,
    int? firstRecord,
    int? lastRecord,
    int? totalPage,
    List<GetAllCustomerList>? getAllCustomerList,
  }) {
    _totalRecords = totalRecords;
    _firstRecord = firstRecord;
    _lastRecord = lastRecord;
    _totalPage = totalPage;
    _getAllCustomerList = getAllCustomerList;
  }

  GetAllCustomerData.fromJson(dynamic json) {
    _totalRecords = json['TotalRecords']??0;
    _firstRecord = json['FirstRecord']??0;
    _lastRecord = json['LastRecord']??0;
    _totalPage = json['TotalPage']??0;
    if (json['Data'] != null) {
      _getAllCustomerList = [];
      json['Data'].forEach((v) {
        _getAllCustomerList?.add(GetAllCustomerList.fromJson(v));
      });
    }
  }

  int? _totalRecords;
  int? _firstRecord;
  int? _lastRecord;
  int? _totalPage;
  List<GetAllCustomerList>? _getAllCustomerList;

  int? get totalRecords => _totalRecords;

  int? get firstRecord => _firstRecord;

  int? get lastRecord => _lastRecord;

  int? get totalPage => _totalPage;

  List<GetAllCustomerList>? get getAllCustomerList => _getAllCustomerList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalRecords'] = _totalRecords;
    map['FirstRecord'] = _firstRecord;
    map['LastRecord'] = _lastRecord;
    map['TotalPage'] = _totalPage;
    if (_getAllCustomerList != null) {
      map['Data'] = _getAllCustomerList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// SrNo : 1
/// CustomerIDP : "a08f954f-4ac1-427e-9172-7d6d69ea7b13"
/// Name : "John Doe"
/// PhoneCountryCode : "+60"
/// PhoneNumber : "176172385"
/// Email : "john.doe@example.com"
/// Address : "123 Main St, City, Country"

class GetAllCustomerList {
  GetAllCustomerList({
    int? srNo,
    String? customerIDP,
    String? name,
    String? phoneCountryCode,
    String? phoneNumber,
    String? email,
    String? address,
  }) {
    _srNo = srNo;
    _customerIDP = customerIDP;
    _name = name;
    _phoneCountryCode = phoneCountryCode;
    _phoneNumber = phoneNumber;
    _email = email;
    _address = address;
  }

  GetAllCustomerList.fromJson(dynamic json) {
    _srNo = json['SrNo'];
    _customerIDP = json['CustomerIDP'];
    _name = json['Name'];
    _phoneCountryCode = json['PhoneCountryCode'];
    _phoneNumber = json['PhoneNumber'];
    _email = json['Email'];
    _address = json['Address'];
  }

  int? _srNo;
  String? _customerIDP;
  String? _name;
  String? _phoneCountryCode;
  String? _phoneNumber;
  String? _email;
  String? _address;

  int? get srNo => _srNo;

  String? get customerIDP => _customerIDP;

  String? get name => _name;

  String? get phoneCountryCode => _phoneCountryCode;

  String? get phoneNumber => _phoneNumber;

  String? get email => _email;

  String? get address => _address;

  setPhoneCountryCode(String phoneCountryCode){
    this._phoneCountryCode = phoneCountryCode;
  }
  setName(String name){
    this._name = name;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SrNo'] = _srNo;
    map['CustomerIDP'] = _customerIDP;
    map['Name'] = _name;
    map['PhoneCountryCode'] = _phoneCountryCode;
    map['PhoneNumber'] = _phoneNumber;
    map['Email'] = _email;
    map['Address'] = _address;
    return map;
  }
}
