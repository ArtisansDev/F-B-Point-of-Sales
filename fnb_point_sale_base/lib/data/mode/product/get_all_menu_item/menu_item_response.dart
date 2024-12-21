/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"MenuItemIDP":"73c212d4-0d16-4c07-9bb9-03b8ae5acec8","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","ItemName":"Double Cheese Margherita Pizza","Description":"<p>The ever-popular Margherita - loaded with extra cheese... oodies of it!</p>","IsActive":true,"CreationDate":"2024-10-12T15:51:54.12","CreatedBy":"A35CA135-4C38-42A2-8AEC-DA4D4746AAD9","UpdationDate":"2024-11-12T11:22:37.363","UpdatedBy":"FC59C2CE-A3E1-4F0B-952F-603CF2CAE3B4","IsVeg":false,"ItemTaxPercent":1.0,"NutritionalInfo":"<ul><li>dtmsdfsdjgrt</li><li>dggreggfgfgfg</li><li>dgdfgfdhgfjhhfg dge &nbsp;e r g</li></ul>","ModifierIDs":[],"Ingredients":[],"TaxData":[{"TaxIDP":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":"10.00"},{"TaxIDP":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":"5.00"}],"CategoryIDs":[{"CategoryIDP":"5062dbb1-190d-4a9e-8597-2450678951f1"}],"BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsDeleted":false,"ArchiveDate":""},{"MenuItemIDP":"269d7a1a-05b0-40b4-bd86-137f46243755","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","ItemName":"Hamburger - The Classic Burger","Description":"<p>The Classic Hamburger starts with a 100% pure beef patty seasoned with just a pinch of salt and pepper. Then, the burger is topped with a tangy pickle, chopped onions, ketchup, and mustard. What's the difference between a Hamburger and a Cheeseburger, you ask? A slice of cheese in the latter! There are 250 calories in Hamburger.</p>","IsActive":true,"CreationDate":"2024-05-17T15:21:53.02","CreatedBy":"FC59C2CE-A3E1-4F0B-952F-603CF2CAE3B4","UpdationDate":"2024-11-09T10:59:16.36","UpdatedBy":"FC59C2CE-A3E1-4F0B-952F-603CF2CAE3B4","IsVeg":true,"ItemTaxPercent":0.0,"NutritionalInfo":"","ModifierIDs":[],"Ingredients":[],"TaxData":[{"TaxIDP":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":"10.00"},{"TaxIDP":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":"5.00"}],"CategoryIDs":[{"CategoryIDP":"cc109190-0f7e-4d42-be06-a1c989afee0a"},{"CategoryIDP":"57550cfd-e38a-4665-996f-dded47bb15ef"}],"BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsDeleted":false,"ArchiveDate":""}]

class MenuItemResponse {
  MenuItemResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      List<MenuItemData>? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  MenuItemResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MenuItemData.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<MenuItemData>? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<MenuItemData>? get data => _data;

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
/// ItemName : "Double Cheese Margherita Pizza"
/// Description : "<p>The ever-popular Margherita - loaded with extra cheese... oodies of it!</p>"
/// IsActive : true
/// CreationDate : "2024-10-12T15:51:54.12"
/// CreatedBy : "A35CA135-4C38-42A2-8AEC-DA4D4746AAD9"
/// UpdationDate : "2024-11-12T11:22:37.363"
/// UpdatedBy : "FC59C2CE-A3E1-4F0B-952F-603CF2CAE3B4"
/// IsVeg : false
/// ItemTaxPercent : 1.0
/// NutritionalInfo : "<ul><li>dtmsdfsdjgrt</li><li>dggreggfgfgfg</li><li>dgdfgfdhgfjhhfg dge &nbsp;e r g</li></ul>"
/// ModifierIDs : []
/// Ingredients : []
/// TaxData : [{"TaxIDP":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":"10.00"},{"TaxIDP":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":"5.00"}]
/// CategoryIDs : [{"CategoryIDP":"5062dbb1-190d-4a9e-8597-2450678951f1"}]
/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// ApproxCookingHour : 0
/// ApproxCookingMinute : 0
/// IsDeleted : false
/// ArchiveDate : ""

class MenuItemData {
  MenuItemData({
      String? menuItemIDP, 
      String? restaurantIDF, 
      String? itemName, 
      String? description, 
      bool? isActive, 
      String? creationDate, 
      String? createdBy, 
      String? updationDate, 
      String? updatedBy, 
      bool? isVeg, 
      double? itemTaxPercent, 
      String? nutritionalInfo, 
      List<ModifierIDs>? modifierIDs,
      List<dynamic>? ingredients, 
      List<MenuItemTaxData>? taxData, 
      List<CategoryIDs>? categoryIDs, 
      String? branchIDF, 
      int? approxCookingHour, 
      int? approxCookingMinute, 
      bool? isDeleted, 
      String? archiveDate,}){
    _menuItemIDP = menuItemIDP;
    _restaurantIDF = restaurantIDF;
    _itemName = itemName;
    _description = description;
    _isActive = isActive;
    _creationDate = creationDate;
    _createdBy = createdBy;
    _updationDate = updationDate;
    _updatedBy = updatedBy;
    _isVeg = isVeg;
    _itemTaxPercent = itemTaxPercent;
    _nutritionalInfo = nutritionalInfo;
    _modifierIDs = modifierIDs;
    _ingredients = ingredients;
    _taxData = taxData;
    _categoryIDs = categoryIDs;
    _branchIDF = branchIDF;
    _approxCookingHour = approxCookingHour;
    _approxCookingMinute = approxCookingMinute;
    _isDeleted = isDeleted;
    _archiveDate = archiveDate;
}

  MenuItemData.fromJson(dynamic json) {
    _menuItemIDP = json['MenuItemIDP'];
    _restaurantIDF = json['RestaurantIDF'];
    _itemName = json['ItemName'];
    _description = json['Description'];
    _isActive = json['IsActive'];
    _creationDate = json['CreationDate'];
    _createdBy = json['CreatedBy'];
    _updationDate = json['UpdationDate'];
    _updatedBy = json['UpdatedBy'];
    _isVeg = json['IsVeg'];
    _itemTaxPercent = json['ItemTaxPercent'];
    _nutritionalInfo = json['NutritionalInfo'];
    if (json['ModifierIDs'] != null) {
      _modifierIDs = [];
      json['ModifierIDs'].forEach((v) {
        _modifierIDs?.add(ModifierIDs.fromJson(v));
      });
    }
    // if (json['Ingredients'] != null) {
    //   _ingredients = [];
    //   json['Ingredients'].forEach((v) {
    //     _ingredients?.add(Dynamic.fromJson(v));
    //   });
    // }
    if (json['TaxData'] != null) {
      _taxData = [];
      json['TaxData'].forEach((v) {
        _taxData?.add(MenuItemTaxData.fromJson(v));
      });
    }
    if (json['CategoryIDs'] != null) {
      _categoryIDs = [];
      json['CategoryIDs'].forEach((v) {
        _categoryIDs?.add(CategoryIDs.fromJson(v));
      });
    }
    _branchIDF = json['BranchIDF'];
    _approxCookingHour = json['ApproxCookingHour'];
    _approxCookingMinute = json['ApproxCookingMinute'];
    _isDeleted = json['IsDeleted'];
    _archiveDate = json['ArchiveDate'];
  }
  String? _menuItemIDP;
  String? _restaurantIDF;
  String? _itemName;
  String? _description;
  bool? _isActive;
  String? _creationDate;
  String? _createdBy;
  String? _updationDate;
  String? _updatedBy;
  bool? _isVeg;
  double? _itemTaxPercent;
  String? _nutritionalInfo;
  List<ModifierIDs>? _modifierIDs;
  List<dynamic>? _ingredients;
  List<MenuItemTaxData>? _taxData;
  List<CategoryIDs>? _categoryIDs;
  String? _branchIDF;
  int? _approxCookingHour;
  int? _approxCookingMinute;
  bool? _isDeleted;
  String? _archiveDate;

  String? get menuItemIDP => _menuItemIDP;
  String? get restaurantIDF => _restaurantIDF;
  String? get itemName => _itemName;
  String? get description => _description;
  bool? get isActive => _isActive;
  String? get creationDate => _creationDate;
  String? get createdBy => _createdBy;
  String? get updationDate => _updationDate;
  String? get updatedBy => _updatedBy;
  bool? get isVeg => _isVeg;
  double? get itemTaxPercent => _itemTaxPercent;
  String? get nutritionalInfo => _nutritionalInfo;
  List<ModifierIDs>? get modifierIDs => _modifierIDs;
  List<dynamic>? get ingredients => _ingredients;
  List<MenuItemTaxData>? get taxData => _taxData;
  List<CategoryIDs>? get categoryIDs => _categoryIDs;
  String? get branchIDF => _branchIDF;
  int? get approxCookingHour => _approxCookingHour;
  int? get approxCookingMinute => _approxCookingMinute;
  bool? get isDeleted => _isDeleted;
  String? get archiveDate => _archiveDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MenuItemIDP'] = _menuItemIDP;
    map['RestaurantIDF'] = _restaurantIDF;
    map['ItemName'] = _itemName;
    map['Description'] = _description;
    map['IsActive'] = _isActive;
    map['CreationDate'] = _creationDate;
    map['CreatedBy'] = _createdBy;
    map['UpdationDate'] = _updationDate;
    map['UpdatedBy'] = _updatedBy;
    map['IsVeg'] = _isVeg;
    map['ItemTaxPercent'] = _itemTaxPercent;
    map['NutritionalInfo'] = _nutritionalInfo;
    if (_modifierIDs != null) {
      map['ModifierIDs'] = _modifierIDs?.map((v) => v.toJson()).toList();
    }
    if (_ingredients != null) {
      map['Ingredients'] = _ingredients?.map((v) => v.toJson()).toList();
    }
    if (_taxData != null) {
      map['TaxData'] = _taxData?.map((v) => v.toJson()).toList();
    }
    if (_categoryIDs != null) {
      map['CategoryIDs'] = _categoryIDs?.map((v) => v.toJson()).toList();
    }
    map['BranchIDF'] = _branchIDF;
    map['ApproxCookingHour'] = _approxCookingHour;
    map['ApproxCookingMinute'] = _approxCookingMinute;
    map['IsDeleted'] = _isDeleted;
    map['ArchiveDate'] = _archiveDate;
    return map;
  }

}

/// CategoryIDP : "5062dbb1-190d-4a9e-8597-2450678951f1"

class CategoryIDs {
  CategoryIDs({
      String? categoryIDP,}){
    _categoryIDP = categoryIDP;
}

  CategoryIDs.fromJson(dynamic json) {
    _categoryIDP = json['CategoryIDP'];
  }
  String? _categoryIDP;

  String? get categoryIDP => _categoryIDP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CategoryIDP'] = _categoryIDP;
    return map;
  }

}

/// ModifierIDP : "5062dbb1-190d-4a9e-8597-2450678951f1"

class ModifierIDs {
  ModifierIDs({
    String? modifierIDP,}){
    _modifierIDP = modifierIDP;
  }

  ModifierIDs.fromJson(dynamic json) {
    _modifierIDP = json['ModifierIDP'];
  }
  String? _modifierIDP;

  String? get modifierIDP => _modifierIDP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ModifierIDP'] = _modifierIDP;
    return map;
  }

}

/// TaxIDP : "d327b6d4-85a9-4feb-b7a9-e23dd802e8e7"
/// TaxName : "Service Tax"
/// TaxPercentage : "10.00"

class MenuItemTaxData {
  MenuItemTaxData({
      String? taxIDP, 
      String? taxName, 
      String? taxPercentage,}){
    _taxIDP = taxIDP;
    _taxName = taxName;
    _taxPercentage = taxPercentage;
}

  MenuItemTaxData.fromJson(dynamic json) {
    _taxIDP = json['TaxIDP'];
    _taxName = json['TaxName'];
    _taxPercentage = json['TaxPercentage'];
  }
  String? _taxIDP;
  String? _taxName;
  String? _taxPercentage;

  String? get taxIDP => _taxIDP;
  String? get taxName => _taxName;
  String? get taxPercentage => _taxPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TaxIDP'] = _taxIDP;
    map['TaxName'] = _taxName;
    map['TaxPercentage'] = _taxPercentage;
    return map;
  }

}