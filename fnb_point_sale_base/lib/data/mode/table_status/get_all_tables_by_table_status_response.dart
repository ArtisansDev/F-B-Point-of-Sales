/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"SeatIDP":"55ee032c-20d1-4689-b1d4-01aaee8e4594","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","SeatNumber":"TRE2","SeatingCapacity":5,"CreationDate":"2024-12-09T12:17:48.77","ModificationDate":"2024-12-09T12:17:48.77","SeatType":"Seat","IsActive":true,"IsDeleted":false,"UpdationDate":"2024-12-09T12:17:48.77","LocationIDF":"50d9b3c8-2b8e-47a1-9c67-89f2fa755798","SeatingType":"First Floor","LocationType":"First Floor","TableStatus":"O","OccupiedTrackingOrderID":"","OccupiedOrderID":"00000000-0000-0000-0000-000000000000","TotalPayableAmount":0.0,"OrderDate":"","FormatedOrderDate":""}]

class GetAllTablesByTableStatusResponse {
  GetAllTablesByTableStatusResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      List<TablesByTableStatusData>? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  GetAllTablesByTableStatusResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TablesByTableStatusData.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<TablesByTableStatusData>? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<TablesByTableStatusData>? get data => _data;

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

/// SeatIDP : "55ee032c-20d1-4689-b1d4-01aaee8e4594"
/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// SeatNumber : "TRE2"
/// SeatingCapacity : 5
/// CreationDate : "2024-12-09T12:17:48.77"
/// ModificationDate : "2024-12-09T12:17:48.77"
/// SeatType : "Seat"
/// IsActive : true
/// IsDeleted : false
/// UpdationDate : "2024-12-09T12:17:48.77"
/// LocationIDF : "50d9b3c8-2b8e-47a1-9c67-89f2fa755798"
/// SeatingType : "First Floor"
/// LocationType : "First Floor"
/// TableStatus : "O"
/// OccupiedTrackingOrderID : ""
/// OccupiedOrderID : "00000000-0000-0000-0000-000000000000"
/// TotalPayableAmount : 0.0
/// OrderDate : ""
/// FormatedOrderDate : ""
/// PaymentStatus : ""
/// OrderStatus : ""
/// OrderSource : ""

class TablesByTableStatusData {
  TablesByTableStatusData({
      String? seatIDP, 
      String? branchIDF, 
      String? restaurantIDF, 
      String? seatNumber, 
      int? seatingCapacity, 
      String? creationDate, 
      String? modificationDate, 
      String? seatType, 
      bool? isActive, 
      bool? isDeleted, 
      String? updationDate, 
      String? locationIDF, 
      String? seatingType, 
      String? locationType, 
      String? tableStatus, 
      String? occupiedTrackingOrderID, 
      String? occupiedOrderID, 
      double? totalPayableAmount, 
      String? orderDate, 
      String? formatedOrderDate,
      String? paymentStatus,
      String? orderStatus,
      String? orderSource,
  }){
    _seatIDP = seatIDP;
    _branchIDF = branchIDF;
    _restaurantIDF = restaurantIDF;
    _seatNumber = seatNumber;
    _seatingCapacity = seatingCapacity;
    _creationDate = creationDate;
    _modificationDate = modificationDate;
    _seatType = seatType;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _updationDate = updationDate;
    _locationIDF = locationIDF;
    _seatingType = seatingType;
    _locationType = locationType;
    _tableStatus = tableStatus;
    _occupiedTrackingOrderID = occupiedTrackingOrderID;
    _occupiedOrderID = occupiedOrderID;
    _totalPayableAmount = totalPayableAmount;
    _orderDate = orderDate;
    _formatedOrderDate = formatedOrderDate;
    _paymentStatus = paymentStatus;
    _orderStatus = orderStatus;
    _orderSource = orderSource;
}

  TablesByTableStatusData.fromJson(dynamic json) {
    _seatIDP = json['SeatIDP'];
    _branchIDF = json['BranchIDF'];
    _restaurantIDF = json['RestaurantIDF'];
    _seatNumber = json['SeatNumber'];
    _seatingCapacity = json['SeatingCapacity'];
    _creationDate = json['CreationDate'];
    _modificationDate = json['ModificationDate'];
    _seatType = json['SeatType'];
    _isActive = json['IsActive'];
    _isDeleted = json['IsDeleted'];
    _updationDate = json['UpdationDate'];
    _locationIDF = json['LocationIDF'];
    _seatingType = json['SeatingType'];
    _locationType = json['LocationType'];
    _tableStatus = json['TableStatus'];
    _occupiedTrackingOrderID = json['OccupiedTrackingOrderID'];
    _occupiedOrderID = json['OccupiedOrderID'];
    _totalPayableAmount = json['TotalPayableAmount'];
    _orderDate = json['OrderDate'];
    _formatedOrderDate = json['FormatedOrderDate'];
    _paymentStatus = json['PaymentStatus'];
    _orderStatus = json['OrderStatus'];
    _orderSource = json['OrderSource'];
  }
  String? _seatIDP;
  String? _branchIDF;
  String? _restaurantIDF;
  String? _seatNumber;
  int? _seatingCapacity;
  String? _creationDate;
  String? _modificationDate;
  String? _seatType;
  bool? _isActive;
  bool? _isDeleted;
  String? _updationDate;
  String? _locationIDF;
  String? _seatingType;
  String? _locationType;
  String? _tableStatus;
  String? _occupiedTrackingOrderID;
  String? _occupiedOrderID;
  double? _totalPayableAmount;
  String? _orderDate;
  String? _formatedOrderDate;
  String? _paymentStatus;
  String? _orderStatus;
  String? _orderSource;

  String? get seatIDP => _seatIDP;
  String? get branchIDF => _branchIDF;
  String? get restaurantIDF => _restaurantIDF;
  String? get seatNumber => _seatNumber;
  int? get seatingCapacity => _seatingCapacity;
  String? get creationDate => _creationDate;
  String? get modificationDate => _modificationDate;
  String? get seatType => _seatType;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  String? get updationDate => _updationDate;
  String? get locationIDF => _locationIDF;
  String? get seatingType => _seatingType;
  String? get locationType => _locationType;
  String? get tableStatus => _tableStatus;
  String? get occupiedTrackingOrderID => _occupiedTrackingOrderID;
  String? get occupiedOrderID => _occupiedOrderID;
  double? get totalPayableAmount => _totalPayableAmount;
  String? get orderDate => _orderDate;
  String? get formatedOrderDate => _formatedOrderDate;
  String? get paymentStatus => _paymentStatus;
  String? get orderStatus => _orderStatus;
  String? get orderSource => _orderSource;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SeatIDP'] = _seatIDP;
    map['BranchIDF'] = _branchIDF;
    map['RestaurantIDF'] = _restaurantIDF;
    map['SeatNumber'] = _seatNumber;
    map['SeatingCapacity'] = _seatingCapacity;
    map['CreationDate'] = _creationDate;
    map['ModificationDate'] = _modificationDate;
    map['SeatType'] = _seatType;
    map['IsActive'] = _isActive;
    map['IsDeleted'] = _isDeleted;
    map['UpdationDate'] = _updationDate;
    map['LocationIDF'] = _locationIDF;
    map['SeatingType'] = _seatingType;
    map['LocationType'] = _locationType;
    map['TableStatus'] = _tableStatus;
    map['OccupiedTrackingOrderID'] = _occupiedTrackingOrderID;
    map['OccupiedOrderID'] = _occupiedOrderID;
    map['TotalPayableAmount'] = _totalPayableAmount;
    map['OrderDate'] = _orderDate;
    map['FormatedOrderDate'] = _formatedOrderDate;
    map['PaymentStatus'] = _paymentStatus;
    map['OrderStatus'] = _orderStatus;
    map['OrderSource'] = _orderSource;
    return map;
  }

}