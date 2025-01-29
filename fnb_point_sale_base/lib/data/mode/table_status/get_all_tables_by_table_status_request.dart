/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// OrderSource : ""
/// TableStatus : "A"

class GetAllTablesByTableStatusRequest {
  GetAllTablesByTableStatusRequest({
      String? restaurantIDF, 
      String? branchIDF, 
      String? orderSource, 
      String? tableStatus,}){
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _orderSource = orderSource;
    _tableStatus = tableStatus;
}

  GetAllTablesByTableStatusRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _orderSource = json['OrderSource'];
    _tableStatus = json['TableStatus'];
  }
  String? _restaurantIDF;
  String? _branchIDF;
  String? _orderSource;
  String? _tableStatus;

  String? get restaurantIDF => _restaurantIDF;
  String? get branchIDF => _branchIDF;
  String? get orderSource => _orderSource;
  String? get tableStatus => _tableStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['OrderSource'] = _orderSource;
    map['TableStatus'] = _tableStatus;
    return map;
  }

}