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
    if(_restaurantIDF!=null) {
      map['RestaurantIDF'] = _restaurantIDF;
    }
    if(_branchIDF!=null) {
      map['BranchIDF'] = _branchIDF;
    }
    if(_lastSyncTime!=null) {
      map['LastSyncTime'] = _lastSyncTime;
    }
    return map;
  }

}