/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"VariantIDP":"e7db1346-b82f-4d0b-a8f0-00a23486c2b1","MenuItemIDF":"79755791-bf97-4f5e-80fa-a6df2f54a3ad","CurrencySymbol":"RM","QuantitySpecification":"Regular","Price":140.0,"DiscountPercentage":0.0,"DiscountedPrice":140.0,"IsActive":true,"IsDeleted":false,"IsUpdated":false},{"VariantIDP":"de31890a-1661-4798-b6e0-04724b661d2d","MenuItemIDF":"659a8023-4d4e-4380-aa13-285880606f6b","CurrencySymbol":"RM","QuantitySpecification":"330ml","Price":70.0,"DiscountPercentage":0.0,"DiscountedPrice":70.0,"IsActive":true,"IsDeleted":false,"IsUpdated":false}]

class GetAllVariantResponse {
  GetAllVariantResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      List<VariantListData>? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  GetAllVariantResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VariantListData.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<VariantListData>? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<VariantListData>? get data => _data;

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

/// VariantIDP : "e7db1346-b82f-4d0b-a8f0-00a23486c2b1"
/// MenuItemIDF : "79755791-bf97-4f5e-80fa-a6df2f54a3ad"
/// CurrencySymbol : "RM"
/// QuantitySpecification : "Regular"
/// Price : 140.0
/// DiscountPercentage : 0.0
/// DiscountedPrice : 140.0
/// IsActive : true
/// IsDeleted : false
/// IsUpdated : false

class VariantListData {
  VariantListData({
      String? variantIDP, 
      String? menuItemIDF, 
      String? currencySymbol, 
      String? quantitySpecification, 
      double? price, 
      double? discountPercentage, 
      double? discountedPrice, 
      bool? isActive, 
      bool? isDeleted, 
      bool? isUpdated,}){
    _variantIDP = variantIDP;
    _menuItemIDF = menuItemIDF;
    _currencySymbol = currencySymbol;
    _quantitySpecification = quantitySpecification;
    _price = price;
    _discountPercentage = discountPercentage;
    _discountedPrice = discountedPrice;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _isUpdated = isUpdated;
}

  VariantListData.fromJson(dynamic json) {
    _variantIDP = json['VariantIDP'];
    _menuItemIDF = json['MenuItemIDF'];
    _currencySymbol = json['CurrencySymbol'];
    _quantitySpecification = json['QuantitySpecification'];
    _price = json['Price'];
    _discountPercentage = json['DiscountPercentage'];
    _discountedPrice = json['DiscountedPrice'];
    _isActive = json['IsActive'];
    _isDeleted = json['IsDeleted'];
    _isUpdated = json['IsUpdated'];
  }
  String? _variantIDP;
  String? _menuItemIDF;
  String? _currencySymbol;
  String? _quantitySpecification;
  double? _price;
  double? _discountPercentage;
  double? _discountedPrice;
  bool? _isActive;
  bool? _isDeleted;
  bool? _isUpdated;

  String? get variantIDP => _variantIDP;
  String? get menuItemIDF => _menuItemIDF;
  String? get currencySymbol => _currencySymbol;
  String? get quantitySpecification => _quantitySpecification;
  double? get price => _price;
  double? get discountPercentage => _discountPercentage;
  double? get discountedPrice => _discountedPrice;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  bool? get isUpdated => _isUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['VariantIDP'] = _variantIDP;
    map['MenuItemIDF'] = _menuItemIDF;
    map['CurrencySymbol'] = _currencySymbol;
    map['QuantitySpecification'] = _quantitySpecification;
    map['Price'] = _price;
    map['DiscountPercentage'] = _discountPercentage;
    map['DiscountedPrice'] = _discountedPrice;
    map['IsActive'] = _isActive;
    map['IsDeleted'] = _isDeleted;
    map['IsUpdated'] = _isUpdated;
    return map;
  }

}