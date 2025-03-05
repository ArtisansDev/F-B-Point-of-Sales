/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// IsStockOut : true
/// UpdateStokeData : [{"CategoryIDF":"5062dbb1-190d-4a9e-8597-2450678951f1","MenuItemIDF":"73c212d4-0d16-4c07-9bb9-03b8ae5acec8"}]

class MenuRequest {
  MenuRequest({
      String? restaurantIDF, 
      String? branchIDF, 
      bool? isStockOut, 
      List<UpdateStokeData>? updateStokeData,}){
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _isStockOut = isStockOut;
    _updateStokeData = updateStokeData;
}

  MenuRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _isStockOut = json['IsStockOut'];
    if (json['UpdateStokeData'] != null) {
      _updateStokeData = [];
      json['UpdateStokeData'].forEach((v) {
        _updateStokeData?.add(UpdateStokeData.fromJson(v));
      });
    }
  }
  String? _restaurantIDF;
  String? _branchIDF;
  bool? _isStockOut;
  List<UpdateStokeData>? _updateStokeData;

  String? get restaurantIDF => _restaurantIDF;
  String? get branchIDF => _branchIDF;
  bool? get isStockOut => _isStockOut;
  List<UpdateStokeData>? get updateStokeData => _updateStokeData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['IsStockOut'] = _isStockOut;
    if (_updateStokeData != null) {
      map['UpdateStokeData'] = _updateStokeData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// CategoryIDF : "5062dbb1-190d-4a9e-8597-2450678951f1"
/// MenuItemIDF : "73c212d4-0d16-4c07-9bb9-03b8ae5acec8"

class UpdateStokeData {
  UpdateStokeData({
      String? categoryIDF, 
      String? menuItemIDF,}){
    _categoryIDF = categoryIDF;
    _menuItemIDF = menuItemIDF;
}

  UpdateStokeData.fromJson(dynamic json) {
    _categoryIDF = json['CategoryIDF'];
    _menuItemIDF = json['MenuItemIDF'];
  }
  String? _categoryIDF;
  String? _menuItemIDF;

  String? get categoryIDF => _categoryIDF;
  String? get menuItemIDF => _menuItemIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CategoryIDF'] = _categoryIDF;
    map['MenuItemIDF'] = _menuItemIDF;
    return map;
  }

}