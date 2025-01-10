/// OrderDetailList : [{"TrackingOrderID":"E24C92B9-2D3E-41A3-98A9-6BC509EC12F7","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","CounterIDF":"0E75BFA1-AF7D-4182-835B-B815C2972591","BranchIDF":"8281F828-2F99-457E-AC27-06914ABBE720","SeatIDF":"F27476A7-D498-462B-9A0A-F87933D6E518","OrderDate":"2024-11-26T10:30:00Z","OrderType":1,"OrderSource":1,"OrderMenu":[{"MenuItemIDF":"D1C092A3-8245-4D74-8C4E-CBC5E9A26D6F","VariantIDF":"A1E6D4A9-2AB2-4D19-B603-FDB6B4C21D27","Quantity":2,"DiscountPercentage":10,"ItemName":"Pizza","ItemVariantName":"Large","ItemTaxPercent":5,"AllModifierPrices":"10,20","AllModifierIDFs":"B47C3A72-6E52-489A-BC1A-99F5378E7A8A,B6ACD313-9372-4E47-9988-89E205F3D3A5","VariantPrice":500,"ItemDiscountPrice":475,"DiscountedItemAmount":25,"DiscountedItemTotalAmount":50,"ItemTaxPrice":38,"ItemTotal":1000,"ItemTotalTaxPrice":76,"ItemModifierTotal":60,"ItemDiscountPriceTotal":950,"TotalItemAmount":1036}],"OrderTax":[{"TaxIDF":"F7C95F97-BC89-41F4-B734-1D8C404A48D1","TaxName":"GST","TaxPercentage":5,"TaxAmount":76.75}],"PaymentResponse":[{"TransactionID":"7B0157A9-4EE9-40A5-81EC-77A9088484C9","ResponseCode":"200","ResponseMessage":"Success","PaymentStatus":"S","PaidAmount":1765.25,"ResponseData":"Success","PaymentGatewayNo":"1"}],"QuantityTotal":2,"ItemTotal":1000,"ModifierTotal":60,"DiscountTotal":50,"ItemTaxTotal":98.50,"SubTotal":1535,"TaxAmountTotal":230.25,"TotalAmount":1765.25,"AdjustedAmount":1765.25,"GrandTotal":1765.25,"AdditionalNotes":"No extra cheese","PaymentGatewayIDF":"9F1C4E45-9B51-4B57-A61D-A09BB51D2F7E","PaymentGatewaySettingIDF":"1D53AB9E-3A02-4177-8D4C-299BCB7C3A5C","PaymentStatus":"S","TableNo":"T5","Email":"customer@example.com","PhoneNumber":"1234567890","Name":"John Doe","PhoneCountryCode":"+1","UserIDF":"AE0D58D7-5F8A-4C65-A9F3-983E74D3EF82","CustomerIDF":"7D56F4F5-B7DB-4E96-B92B-97B57D3B49E1"}]

class ProcessMultipleOrdersRequest {
  ProcessMultipleOrdersRequest({
    List<OrderDetailList>? orderDetailList,
  }) {
    _orderDetailList = orderDetailList;
  }

  ProcessMultipleOrdersRequest.fromJson(dynamic json) {
    if (json['OrderDetailList'] != null) {
      _orderDetailList = [];
      json['OrderDetailList'].forEach((v) {
        _orderDetailList?.add(OrderDetailList.fromJson(v));
      });
    }
  }

  List<OrderDetailList>? _orderDetailList;

  List<OrderDetailList>? get orderDetailList => _orderDetailList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orderDetailList != null) {
      map['OrderDetailList'] =
          _orderDetailList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// CounterBalanceHistoryIDF : "E24C92B9-2D3E-41A3-98A9-6BC509EC12F7"
/// TrackingOrderID : "E24C92B9-2D3E-41A3-98A9-6BC509EC12F7"
/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// CounterIDF : "0E75BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// SeatIDF : "F27476A7-D498-462B-9A0A-F87933D6E518"
/// OrderDate : "2024-11-26T10:30:00Z"
/// OrderType : 1
/// OrderSource : 1
/// OrderMenu : [{"MenuItemIDF":"D1C092A3-8245-4D74-8C4E-CBC5E9A26D6F","VariantIDF":"A1E6D4A9-2AB2-4D19-B603-FDB6B4C21D27","Quantity":2,"DiscountPercentage":10,"ItemName":"Pizza","ItemVariantName":"Large","ItemTaxPercent":5,"AllModifierPrices":"10,20","AllModifierIDFs":"B47C3A72-6E52-489A-BC1A-99F5378E7A8A,B6ACD313-9372-4E47-9988-89E205F3D3A5","VariantPrice":500,"ItemDiscountPrice":475,"DiscountedItemAmount":25,"DiscountedItemTotalAmount":50,"ItemTaxPrice":38,"ItemTotal":1000,"ItemTotalTaxPrice":76,"ItemModifierTotal":60,"ItemDiscountPriceTotal":950,"TotalItemAmount":1036}]
/// OrderTax : [{"TaxIDF":"F7C95F97-BC89-41F4-B734-1D8C404A48D1","TaxName":"GST","TaxPercentage":5,"TaxAmount":76.75}]
/// PaymentResponse : [{"TransactionID":"7B0157A9-4EE9-40A5-81EC-77A9088484C9","ResponseCode":"200","ResponseMessage":"Success","PaymentStatus":"S","PaidAmount":1765.25,"ResponseData":"Success","PaymentGatewayNo":"1"}]
/// QuantityTotal : 2
/// ItemTotal : 1000
/// ModifierTotal : 60
/// DiscountTotal : 50
/// ItemTaxTotal : 98.50
/// SubTotal : 1535
/// TaxAmountTotal : 230.25
/// TotalAmount : 1765.25
/// AdjustedAmount : 1765.25
/// GrandTotal : 1765.25
/// AdditionalNotes : "No extra cheese"
/// PaymentGatewayIDF : "9F1C4E45-9B51-4B57-A61D-A09BB51D2F7E"
/// PaymentGatewaySettingIDF : "1D53AB9E-3A02-4177-8D4C-299BCB7C3A5C"
/// PaymentStatus : "S"
/// TableNo : "T5"
/// Email : "customer@example.com"
/// PhoneNumber : "1234567890"
/// Name : "John Doe"
/// PhoneCountryCode : "+1"
/// UserIDF : "AE0D58D7-5F8A-4C65-A9F3-983E74D3EF82"
/// CustomerIDF : "7D56F4F5-B7DB-4E96-B92B-97B57D3B49E1"

class OrderDetailList {
  OrderDetailList({
    String? counterBalanceHistoryIDF,
    String? trackingOrderID,
    String? restaurantIDF,
    String? counterIDF,
    String? branchIDF,
    String? seatIDF,
    String? orderDate,
    String? orderType,
    String? orderSource,
    List<OrderMenu>? orderMenu,
    List<OrderTax>? orderTax,
    List<PaymentResponse>? paymentResponse,
    int? quantityTotal,
    double? itemTotal,
    double? modifierTotal,
    double? discountTotal,
    double? itemTaxTotal,
    double? subTotal,
    double? taxAmountTotal,
    double? totalAmount,
    double? adjustedAmount,
    double? grandTotal,
    String? additionalNotes,
    String? paymentGatewayIDF,
    String? paymentGatewaySettingIDF,
    String? paymentStatus,
    String? tableNo,
    String? email,
    String? phoneNumber,
    String? name,
    String? phoneCountryCode,
    String? userIDF,
    String? customerIDF,
    String? packagingName,
    String? environmentType,
  }) {
    _counterBalanceHistoryIDF = counterBalanceHistoryIDF;
    _trackingOrderID = trackingOrderID;
    _restaurantIDF = restaurantIDF;
    _counterIDF = counterIDF;
    _branchIDF = branchIDF;
    _seatIDF = seatIDF;
    _orderDate = orderDate;
    _orderType = orderType;
    _orderSource = orderSource;
    _orderMenu = orderMenu;
    _orderTax = orderTax;
    _paymentResponse = paymentResponse;
    _quantityTotal = quantityTotal;
    _itemTotal = itemTotal;
    _modifierTotal = modifierTotal;
    _discountTotal = discountTotal;
    _itemTaxTotal = itemTaxTotal;
    _subTotal = subTotal;
    _taxAmountTotal = taxAmountTotal;
    _totalAmount = totalAmount;
    _adjustedAmount = adjustedAmount;
    _grandTotal = grandTotal;
    _additionalNotes = additionalNotes;
    _paymentGatewayIDF = paymentGatewayIDF;
    _paymentGatewaySettingIDF = paymentGatewaySettingIDF;
    _paymentStatus = paymentStatus;
    _tableNo = tableNo;
    _email = email;
    _phoneNumber = phoneNumber;
    _name = name;
    _phoneCountryCode = phoneCountryCode;
    _userIDF = userIDF;
    _customerIDF = customerIDF;
    _packagingName = packagingName;
    _environmentType = environmentType;
  }

  OrderDetailList.fromJson(dynamic json) {
    _counterBalanceHistoryIDF = json['CounterBalanceHistoryIDF'];
    _trackingOrderID = json['TrackingOrderID'];
    _restaurantIDF = json['RestaurantIDF'];
    _counterIDF = json['CounterIDF'];
    _branchIDF = json['BranchIDF'];
    _seatIDF = json['SeatIDF'];
    _orderDate = json['OrderDate'];
    _orderType = json['OrderType'];
    _orderSource = json['OrderSource'];
    if (json['OrderMenu'] != null) {
      _orderMenu = [];
      json['OrderMenu'].forEach((v) {
        _orderMenu?.add(OrderMenu.fromJson(v));
      });
    }
    if (json['OrderTax'] != null) {
      _orderTax = [];
      json['OrderTax'].forEach((v) {
        _orderTax?.add(OrderTax.fromJson(v));
      });
    }
    if (json['PaymentResponse'] != null) {
      _paymentResponse = [];
      json['PaymentResponse'].forEach((v) {
        _paymentResponse?.add(PaymentResponse.fromJson(v));
      });
    }
    _quantityTotal = json['QuantityTotal'];
    _itemTotal = json['ItemTotal'];
    _modifierTotal = json['ModifierTotal'];
    _discountTotal = json['DiscountTotal'];
    _itemTaxTotal = json['ItemTaxTotal'];
    _subTotal = json['SubTotal'];
    _taxAmountTotal = json['TaxAmountTotal'];
    _totalAmount = json['TotalAmount'];
    _adjustedAmount = json['AdjustedAmount'];
    _grandTotal = json['GrandTotal'];
    _additionalNotes = json['AdditionalNotes'];
    _paymentGatewayIDF = json['PaymentGatewayIDF'];
    _paymentGatewaySettingIDF = json['PaymentGatewaySettingIDF'];
    _paymentStatus = json['PaymentStatus'];
    _tableNo = json['TableNo'];
    _email = json['Email'];
    _phoneNumber = json['PhoneNumber'];
    _name = json['Name'];
    _phoneCountryCode = json['PhoneCountryCode'];
    _userIDF = json['UserIDF'];
    _customerIDF = json['CustomerIDF'];
    _packagingName = json['PackagingName'];
    _environmentType = json['EnvironmentType'];
  }

  String? _counterBalanceHistoryIDF;
  String? _trackingOrderID;
  String? _restaurantIDF;
  String? _counterIDF;
  String? _branchIDF;
  String? _seatIDF;
  String? _orderDate;
  String? _orderType;
  String? _orderSource;
  List<OrderMenu>? _orderMenu;
  List<OrderTax>? _orderTax;
  List<PaymentResponse>? _paymentResponse;
  int? _quantityTotal;
  double? _itemTotal;
  double? _modifierTotal;
  double? _discountTotal;
  double? _itemTaxTotal;
  double? _subTotal;
  double? _taxAmountTotal;
  double? _totalAmount;
  double? _adjustedAmount;
  double? _grandTotal;
  String? _additionalNotes;
  String? _paymentGatewayIDF;
  String? _paymentGatewaySettingIDF;
  String? _paymentStatus;
  String? _tableNo;
  String? _email;
  String? _phoneNumber;
  String? _name;
  String? _phoneCountryCode;
  String? _userIDF;
  String? _customerIDF;
  String? _packagingName;
  String? _environmentType;

  String? get counterBalanceHistoryIDF => _counterBalanceHistoryIDF;

  String? get trackingOrderID => _trackingOrderID;

  String? get restaurantIDF => _restaurantIDF;

  String? get counterIDF => _counterIDF;

  String? get branchIDF => _branchIDF;

  String? get seatIDF => _seatIDF;

  String? get orderDate => _orderDate;

  String? get orderType => _orderType;

  String? get orderSource => _orderSource;

  List<OrderMenu>? get orderMenu => _orderMenu;

  List<OrderTax>? get orderTax => _orderTax;

  List<PaymentResponse>? get paymentResponse => _paymentResponse;

  int? get quantityTotal => _quantityTotal;

  double? get itemTotal => _itemTotal;

  double? get modifierTotal => _modifierTotal;

  double? get discountTotal => _discountTotal;

  double? get itemTaxTotal => _itemTaxTotal;

  double? get subTotal => _subTotal;

  double? get taxAmountTotal => _taxAmountTotal;

  double? get totalAmount => _totalAmount;

  double? get adjustedAmount => _adjustedAmount;

  double? get grandTotal => _grandTotal;

  String? get additionalNotes => _additionalNotes;

  String? get paymentGatewayIDF => _paymentGatewayIDF;

  String? get paymentGatewaySettingIDF => _paymentGatewaySettingIDF;

  String? get paymentStatus => _paymentStatus;

  String? get tableNo => _tableNo;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  String? get name => _name;

  String? get phoneCountryCode => _phoneCountryCode;

  String? get userIDF => _userIDF;

  String? get customerIDF => _customerIDF;

  String? get packagingName => _packagingName;

  String? get environmentType => _environmentType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CounterBalanceHistoryIDF'] = _counterBalanceHistoryIDF;
    map['TrackingOrderID'] = _trackingOrderID;
    map['RestaurantIDF'] = _restaurantIDF;
    map['CounterIDF'] = _counterIDF;
    map['BranchIDF'] = _branchIDF;
    map['SeatIDF'] = _seatIDF;
    map['OrderDate'] = _orderDate;
    map['OrderType'] = _orderType;
    map['OrderSource'] = _orderSource;
    if (_orderMenu != null) {
      map['OrderMenu'] = _orderMenu?.map((v) => v.toJson()).toList();
    }
    if (_orderTax != null) {
      map['OrderTax'] = _orderTax?.map((v) => v.toJson()).toList();
    }
    if (_paymentResponse != null) {
      map['PaymentResponse'] =
          _paymentResponse?.map((v) => v.toJson()).toList();
    }
    map['QuantityTotal'] = _quantityTotal;
    map['ItemTotal'] = _itemTotal;
    map['ModifierTotal'] = _modifierTotal;
    map['DiscountTotal'] = _discountTotal;
    map['ItemTaxTotal'] = _itemTaxTotal;
    map['SubTotal'] = _subTotal;
    map['TaxAmountTotal'] = _taxAmountTotal;
    map['TotalAmount'] = _totalAmount;
    map['AdjustedAmount'] = _adjustedAmount;
    map['GrandTotal'] = _grandTotal;
    map['AdditionalNotes'] = _additionalNotes;
    map['PaymentGatewayIDF'] = _paymentGatewayIDF;
    map['PaymentGatewaySettingIDF'] = _paymentGatewaySettingIDF;
    map['PaymentStatus'] = _paymentStatus;
    map['TableNo'] = _tableNo;
    map['Email'] = _email;
    map['PhoneNumber'] = _phoneNumber;
    map['Name'] = _name;
    map['PhoneCountryCode'] = _phoneCountryCode;
    map['UserIDF'] = _userIDF;
    map['CustomerIDF'] = _customerIDF;
    map['PackagingName'] = _packagingName;
    map['EnvironmentType'] = _environmentType;
    return map;
  }
}

/// TransactionID : "7B0157A9-4EE9-40A5-81EC-77A9088484C9"
/// ResponseCode : "200"
/// ResponseMessage : "Success"
/// PaymentStatus : "S"
/// PaidAmount : 1765.25
/// ResponseData : "Success"
/// PaymentGatewayNo : "1"

class PaymentResponse {
  PaymentResponse({
    String? transactionID,
    String? responseCode,
    String? responseMessage,
    String? paymentStatus,
    double? paidAmount,
    String? responseData,
    String? paymentGatewayNo,
  }) {
    _transactionID = transactionID;
    _responseCode = responseCode;
    _responseMessage = responseMessage;
    _paymentStatus = paymentStatus;
    _paidAmount = paidAmount;
    _responseData = responseData;
    _paymentGatewayNo = paymentGatewayNo;
  }

  PaymentResponse.fromJson(dynamic json) {
    _transactionID = json['TransactionID'];
    _responseCode = json['ResponseCode'];
    _responseMessage = json['ResponseMessage'];
    _paymentStatus = json['PaymentStatus'];
    _paidAmount = json['PaidAmount'];
    _responseData = json['ResponseData'];
    _paymentGatewayNo = json['PaymentGatewayNo'];
  }

  String? _transactionID;
  String? _responseCode;
  String? _responseMessage;
  String? _paymentStatus;
  double? _paidAmount;
  String? _responseData;
  String? _paymentGatewayNo;

  String? get transactionID => _transactionID;

  String? get responseCode => _responseCode;

  String? get responseMessage => _responseMessage;

  String? get paymentStatus => _paymentStatus;

  double? get paidAmount => _paidAmount;

  String? get responseData => _responseData;

  String? get paymentGatewayNo => _paymentGatewayNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TransactionID'] = _transactionID;
    map['ResponseCode'] = _responseCode;
    map['ResponseMessage'] = _responseMessage;
    map['PaymentStatus'] = _paymentStatus;
    map['PaidAmount'] = _paidAmount;
    map['ResponseData'] = _responseData;
    map['PaymentGatewayNo'] = _paymentGatewayNo;
    return map;
  }
}

/// TaxIDF : "F7C95F97-BC89-41F4-B734-1D8C404A48D1"
/// TaxName : "GST"
/// TaxPercentage : 5
/// TaxAmount : 76.75

class OrderTax {
  OrderTax({
    String? taxIDF,
    String? taxName,
    double? taxPercentage,
    double? taxAmount,
  }) {
    _taxIDF = taxIDF;
    _taxName = taxName;
    _taxPercentage = taxPercentage;
    _taxAmount = taxAmount;
  }

  OrderTax.fromJson(dynamic json) {
    _taxIDF = json['TaxIDF'];
    _taxName = json['TaxName'];
    _taxPercentage = json['TaxPercentage'];
    _taxAmount = json['TaxAmount'];
  }

  String? _taxIDF;
  String? _taxName;
  double? _taxPercentage;
  double? _taxAmount;

  String? get taxIDF => _taxIDF;

  String? get taxName => _taxName;

  double? get taxPercentage => _taxPercentage;

  double? get taxAmount => _taxAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TaxIDF'] = _taxIDF;
    map['TaxName'] = _taxName;
    map['TaxPercentage'] = _taxPercentage;
    map['TaxAmount'] = _taxAmount;
    return map;
  }
}

/// MenuItemIDF : "D1C092A3-8245-4D74-8C4E-CBC5E9A26D6F"
/// VariantIDF : "A1E6D4A9-2AB2-4D19-B603-FDB6B4C21D27"
/// Quantity : 2
/// DiscountPercentage : 10
/// ItemName : "Pizza"
/// ItemVariantName : "Large"
/// ItemTaxPercent : 5
/// AllModifierPrices : "10,20"
/// AllModifierIDFs : "B47C3A72-6E52-489A-BC1A-99F5378E7A8A,B6ACD313-9372-4E47-9988-89E205F3D3A5"
/// VariantPrice : 500
/// ItemDiscountPrice : 475
/// DiscountedItemAmount : 25
/// DiscountedItemTotalAmount : 50
/// ItemTaxPrice : 38
/// ItemTotal : 1000
/// ItemTotalTaxPrice : 76
/// ItemModifierTotal : 60
/// ItemDiscountPriceTotal : 950
/// TotalItemAmount : 1036
/// ItemAdditionalNotes : "crvrvftr"

class OrderMenu {
  OrderMenu({
    String? menuItemIDF,
    String? variantIDF,
    String? itemAdditionalNotes,
    int? quantity,
    double? discountPercentage,
    String? itemName,
    String? itemVariantName,
    double? itemTaxPercent,
    String? allModifierPrices,
    String? allModifierIDFs,
    double? variantPrice,
    double? itemDiscountPrice,
    double? discountedItemAmount,
    double? discountedItemTotalAmount,
    double? itemTaxPrice,
    double? itemTotal,
    double? itemTotalTaxPrice,
    double? itemModifierTotal,
    double? itemDiscountPriceTotal,
    double? totalItemAmount,
  }) {
    _menuItemIDF = menuItemIDF;
    _variantIDF = variantIDF;
    _itemAdditionalNotes = itemAdditionalNotes;
    _quantity = quantity;
    _discountPercentage = discountPercentage;
    _itemName = itemName;
    _itemVariantName = itemVariantName;
    _itemTaxPercent = itemTaxPercent;
    _allModifierPrices = allModifierPrices;
    _allModifierIDFs = allModifierIDFs;
    _variantPrice = variantPrice;
    _itemDiscountPrice = itemDiscountPrice;
    _discountedItemAmount = discountedItemAmount;
    _discountedItemTotalAmount = discountedItemTotalAmount;
    _itemTaxPrice = itemTaxPrice;
    _itemTotal = itemTotal;
    _itemTotalTaxPrice = itemTotalTaxPrice;
    _itemModifierTotal = itemModifierTotal;
    _itemDiscountPriceTotal = itemDiscountPriceTotal;
    _totalItemAmount = totalItemAmount;
  }

  OrderMenu.fromJson(dynamic json) {
    _menuItemIDF = json['MenuItemIDF'];
    _variantIDF = json['VariantIDF'];
    _itemAdditionalNotes = json['ItemAdditionalNotes'];
    _quantity = json['Quantity'];
    _discountPercentage = json['DiscountPercentage'];
    _itemName = json['ItemName'];
    _itemVariantName = json['ItemVariantName'];
    _itemTaxPercent = json['ItemTaxPercent'];
    _allModifierPrices = json['AllModifierPrices'];
    _allModifierIDFs = json['AllModifierIDFs'];
    _variantPrice = json['VariantPrice'];
    _itemDiscountPrice = json['ItemDiscountPrice'];
    _discountedItemAmount = json['DiscountedItemAmount'];
    _discountedItemTotalAmount = json['DiscountedItemTotalAmount'];
    _itemTaxPrice = json['ItemTaxPrice'];
    _itemTotal = json['ItemTotal'];
    _itemTotalTaxPrice = json['ItemTotalTaxPrice'];
    _itemModifierTotal = json['ItemModifierTotal'];
    _itemDiscountPriceTotal = json['ItemDiscountPriceTotal'];
    _totalItemAmount = json['TotalItemAmount'];
  }

  String? _menuItemIDF;
  String? _variantIDF;
  String? _itemAdditionalNotes;
  int? _quantity;
  double? _discountPercentage;
  String? _itemName;
  String? _itemVariantName;
  double? _itemTaxPercent;
  String? _allModifierPrices;
  String? _allModifierIDFs;
  double? _variantPrice;
  double? _itemDiscountPrice;
  double? _discountedItemAmount;
  double? _discountedItemTotalAmount;
  double? _itemTaxPrice;
  double? _itemTotal;
  double? _itemTotalTaxPrice;
  double? _itemModifierTotal;
  double? _itemDiscountPriceTotal;
  double? _totalItemAmount;

  String? get menuItemIDF => _menuItemIDF;

  String? get variantIDF => _variantIDF;

  String? get itemAdditionalNotes => _itemAdditionalNotes;

  int? get quantity => _quantity;

  double? get discountPercentage => _discountPercentage;

  String? get itemName => _itemName;

  String? get itemVariantName => _itemVariantName;

  double? get itemTaxPercent => _itemTaxPercent;

  String? get allModifierPrices => _allModifierPrices;

  String? get allModifierIDFs => _allModifierIDFs;

  double? get variantPrice => _variantPrice;

  double? get itemDiscountPrice => _itemDiscountPrice;

  double? get discountedItemAmount => _discountedItemAmount;

  double? get discountedItemTotalAmount => _discountedItemTotalAmount;

  double? get itemTaxPrice => _itemTaxPrice;

  double? get itemTotal => _itemTotal;

  double? get itemTotalTaxPrice => _itemTotalTaxPrice;

  double? get itemModifierTotal => _itemModifierTotal;

  double? get itemDiscountPriceTotal => _itemDiscountPriceTotal;

  double? get totalItemAmount => _totalItemAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MenuItemIDF'] = _menuItemIDF;
    map['VariantIDF'] = _variantIDF;
    map['ItemAdditionalNotes'] = _itemAdditionalNotes;
    map['Quantity'] = _quantity;
    map['DiscountPercentage'] = _discountPercentage;
    map['ItemName'] = _itemName;
    map['ItemVariantName'] = _itemVariantName;
    map['ItemTaxPercent'] = _itemTaxPercent;
    map['AllModifierPrices'] = _allModifierPrices;
    map['AllModifierIDFs'] = _allModifierIDFs;
    map['VariantPrice'] = _variantPrice;
    map['ItemDiscountPrice'] = _itemDiscountPrice;
    map['DiscountedItemAmount'] = _discountedItemAmount;
    map['DiscountedItemTotalAmount'] = _discountedItemTotalAmount;
    map['ItemTaxPrice'] = _itemTaxPrice;
    map['ItemTotal'] = _itemTotal;
    map['ItemTotalTaxPrice'] = _itemTotalTaxPrice;
    map['ItemModifierTotal'] = _itemModifierTotal;
    map['ItemDiscountPriceTotal'] = _itemDiscountPriceTotal;
    map['TotalItemAmount'] = _totalItemAmount;
    return map;
  }
}
