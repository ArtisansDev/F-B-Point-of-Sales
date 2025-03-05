/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"MenuItemIDP":"73c212d4-0d16-4c07-9bb9-03b8ae5acec8","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","ItemName":"Double Cheese Margherita Pizza","Description":"<p>The ever-popular Margherita - loaded with extra cheese... oodies of it!</p>","IsStockOut":true,"CategoryData":[{"CategoryIDF":"5062dbb1-190d-4a9e-8597-2450678951f1","CategoryName":"South Indian"}]},{"MenuItemIDP":"9365218f-afca-4fa8-9c47-e44c5da4111f","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","ItemName":"Paneer Loaded Pizza","Description":"Generously topped with succulent paneer cubes and veggies.","IsStockOut":true,"CategoryData":[{"CategoryIDF":"fc07cd5d-b84b-461e-94ef-04524347aab9","CategoryName":"Pizza"}]}]

class GetMenuStockResponse {
  GetMenuStockResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    List<GetMenuStockData>? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
  }

  GetMenuStockResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetMenuStockData.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<GetMenuStockData>? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<GetMenuStockData>? get data => _data;

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

/// MenuItemIDP : "73c212d4-0d16-4c07-9bb9-03b8ae5acec8"
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// ItemName : "Double Cheese Margherita Pizza"
/// Description : "<p>The ever-popular Margherita - loaded with extra cheese... oodies of it!</p>"
/// IsStockOut : true
/// CategoryData : [{"CategoryIDF":"5062dbb1-190d-4a9e-8597-2450678951f1","CategoryName":"South Indian"}]

class GetMenuStockData {
  GetMenuStockData({
    String? menuItemIDP,
    String? restaurantIDF,
    String? branchIDF,
    String? itemName,
    String? description,
    bool? isStockOut,
    List<CategoryData>? categoryData,}){
    _menuItemIDP = menuItemIDP;
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _itemName = itemName;
    _description = description;
    _isStockOut = isStockOut;
    _categoryData = categoryData;
  }

  GetMenuStockData.fromJson(dynamic json) {
    _menuItemIDP = json['MenuItemIDP'];
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _itemName = json['ItemName'];
    _description = json['Description'];
    _isStockOut = json['IsStockOut'];
    if (json['CategoryData'] != null) {
      _categoryData = [];
      json['CategoryData'].forEach((v) {
        _categoryData?.add(CategoryData.fromJson(v));
      });
    }
  }
  String? _menuItemIDP;
  String? _restaurantIDF;
  String? _branchIDF;
  String? _itemName;
  String? _description;
  bool? _isStockOut;
  List<CategoryData>? _categoryData;

  String? get menuItemIDP => _menuItemIDP;
  String? get restaurantIDF => _restaurantIDF;
  String? get branchIDF => _branchIDF;
  String? get itemName => _itemName;
  String? get description => _description;
  bool? get isStockOut => _isStockOut;
  List<CategoryData>? get categoryData => _categoryData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MenuItemIDP'] = _menuItemIDP;
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['ItemName'] = _itemName;
    map['Description'] = _description;
    map['IsStockOut'] = _isStockOut;
    if (_categoryData != null) {
      map['CategoryData'] = _categoryData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// CategoryIDF : "5062dbb1-190d-4a9e-8597-2450678951f1"
/// CategoryName : "South Indian"

class CategoryData {
  CategoryData({
    String? categoryIDF,
    String? categoryName,}){
    _categoryIDF = categoryIDF;
    _categoryName = categoryName;
  }

  CategoryData.fromJson(dynamic json) {
    _categoryIDF = json['CategoryIDF'];
    _categoryName = json['CategoryName'];
  }
  String? _categoryIDF;
  String? _categoryName;

  String? get categoryIDF => _categoryIDF;
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CategoryIDF'] = _categoryIDF;
    map['CategoryName'] = _categoryName;
    return map;
  }

}