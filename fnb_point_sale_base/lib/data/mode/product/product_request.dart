class ProductRequest {
  ProductRequest({
      String? restaurantIDF, 
      String? branchIDF, 
      String? lastSyncTime,}){
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _lastSyncTime = lastSyncTime;
}

  ProductRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _lastSyncTime = json['LastSyncTime'];
  }
  String? _restaurantIDF;
  String? _branchIDF;
  String? _lastSyncTime;

  String? get restaurantIDF => _restaurantIDF;
  String? get branchIDF => _branchIDF;
  String? get lastSyncTime => _lastSyncTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['LastSyncTime'] = _lastSyncTime;
    return map;
  }

}