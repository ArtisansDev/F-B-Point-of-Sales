/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"ModifierIDP":"8ca3e358-e519-4191-a9eb-705290a38658","ModifierName":"Cheese (20g)","Price":20.0,"IsActive":true,"IsDeleted":false,"IsUpdated":false},{"ModifierIDP":"2453688d-2b3e-4f8c-b5f8-6b5c7ed9cece","ModifierName":"Cheese slice (25g)","Price":30.0,"IsActive":true,"IsDeleted":false,"IsUpdated":false},{"ModifierIDP":"d856163d-bdb7-4bb9-8f7c-1e1655cf3f95","ModifierName":"Cheese slice(10g)","Price":20.0,"IsActive":true,"IsDeleted":false,"IsUpdated":false},{"ModifierIDP":"25043742-7d93-4106-a565-5936366e0943","ModifierName":"Extra Chillyy","Price":20.0,"IsActive":true,"IsDeleted":false,"IsUpdated":false}]

class GetAllModifierResponse {
  GetAllModifierResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      List<ModifierList>? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  GetAllModifierResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ModifierList.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<ModifierList>? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<ModifierList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ModifierIDP : "8ca3e358-e519-4191-a9eb-705290a38658"
/// ModifierName : "Cheese (20g)"
/// Price : 20.0
/// IsActive : true
/// IsDeleted : false
/// IsUpdated : false

class ModifierList {
  ModifierList({
      String? modifierIDP, 
      String? modifierName, 
      double? price, 
      bool? isActive, 
      bool? isDeleted, 
      bool? isUpdated,}){
    _modifierIDP = modifierIDP;
    _modifierName = modifierName;
    _price = price;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _isUpdated = isUpdated;
}

  ModifierList.fromJson(dynamic json) {
    _modifierIDP = json['ModifierIDP'];
    _modifierName = json['ModifierName'];
    _price = json['Price'];
    _isActive = json['IsActive'];
    _isDeleted = json['IsDeleted'];
    _isUpdated = json['IsUpdated'];
  }
  String? _modifierIDP;
  String? _modifierName;
  double? _price;
  int _count = 1;
  bool? _isActive;
  bool? _isDeleted;
  bool? _isUpdated;

  setCount(int count){
    _count = count;
  }
  String? get modifierIDP => _modifierIDP;
  String? get modifierName => _modifierName;
  double? get price => _price;
  int? get count => _count;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  bool? get isUpdated => _isUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ModifierIDP'] = _modifierIDP;
    map['ModifierName'] = _modifierName;
    map['Price'] = _price;
    map['count'] = _count;
    map['IsActive'] = _isActive;
    map['IsDeleted'] = _isDeleted;
    map['IsUpdated'] = _isUpdated;
    return map;
  }

}