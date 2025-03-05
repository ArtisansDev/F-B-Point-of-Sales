/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
///"StockStatus": null, // nullable, null for all, 1 for stoke in data, 2 for stoke out data
///"MenuItemIDP": null, // nullable
///"SearchValue": null // nullable

class GetMenuStockRequest {
  GetMenuStockRequest({
      String? restaurantIDF, 
      String? branchIDF, 
      String? stockStatus, 
      String? menuItemIDP, 
      String? searchValue,}){
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _stockStatus = stockStatus;
    _menuItemIDP = menuItemIDP;
    _searchValue = searchValue;
}

  GetMenuStockRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _stockStatus = json['StockStatus'];
    _menuItemIDP = json['MenuItemIDP'];
    _searchValue = json['SearchValue'];
  }
  String? _restaurantIDF;
  String? _branchIDF;
  String? _stockStatus;
  String? _menuItemIDP;
  String? _searchValue;

  String? get restaurantIDF => _restaurantIDF;
  String? get branchIDF => _branchIDF;
  String? get stockStatus => _stockStatus;
  String? get menuItemIDP => _menuItemIDP;
  String? get searchValue => _searchValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['StockStatus'] = _stockStatus;
    map['MenuItemIDP'] = _menuItemIDP;
    map['SearchValue'] = _searchValue;
    return map;
  }

}