class GetAllCategoryResponse {
  GetAllCategoryResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      List<GetAllCategoryData>? mGetAllCategoryData,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _mGetAllCategoryData = mGetAllCategoryData;
}

  GetAllCategoryResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _mGetAllCategoryData = [];
      json['data'].forEach((v) {
        _mGetAllCategoryData?.add(GetAllCategoryData.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<GetAllCategoryData>? _mGetAllCategoryData;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<GetAllCategoryData>? get mGetAllCategoryData => _mGetAllCategoryData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_mGetAllCategoryData != null) {
      map['data'] = _mGetAllCategoryData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class GetAllCategoryData {
  GetAllCategoryData({
      String? categoryIDP, 
      String? categoryName, 
      String? parentCategoryID, 
      bool? isActive, 
      bool? isDeleted, 
      bool? isUpdated, 
      String? categoryImagePath, 
      List<GetAllCategoryData>? subCategories,}){
    _categoryIDP = categoryIDP;
    _categoryName = categoryName;
    _parentCategoryID = parentCategoryID;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _isUpdated = isUpdated;
    _categoryImagePath = categoryImagePath;
    _subCategories = subCategories;
}

  GetAllCategoryData.fromJson(dynamic json) {
    _categoryIDP = json['CategoryIDP'];
    _categoryName = json['CategoryName'];
    _parentCategoryID = json['ParentCategoryID'];
    _isActive = json['IsActive'];
    _isDeleted = json['IsDeleted'];
    _isUpdated = json['IsUpdated'];
    _categoryImagePath = json['CategoryImagePath'];
    if (json['SubCategories'] != null) {
      _subCategories = [];
      json['SubCategories'].forEach((v) {
        _subCategories?.add(GetAllCategoryData.fromJson(v));
      });
    }
  }
  String? _categoryIDP;
  String? _categoryName;
  String? _parentCategoryID;
  bool? _isActive;
  bool? _isDeleted;
  bool? _isUpdated;
  String? _categoryImagePath;
  List<GetAllCategoryData>? _subCategories;

  String? get categoryIDP => _categoryIDP;
  String? get categoryName => _categoryName;
  String? get parentCategoryID => _parentCategoryID;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  bool? get isUpdated => _isUpdated;
  String? get categoryImagePath => _categoryImagePath;
  List<GetAllCategoryData>? get subCategories => _subCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CategoryIDP'] = _categoryIDP;
    map['CategoryName'] = _categoryName;
    map['ParentCategoryID'] = _parentCategoryID;
    map['IsActive'] = _isActive;
    map['IsDeleted'] = _isDeleted;
    map['IsUpdated'] = _isUpdated;
    map['CategoryImagePath'] = _categoryImagePath;
    if (_subCategories != null) {
      map['SubCategories'] = _subCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}