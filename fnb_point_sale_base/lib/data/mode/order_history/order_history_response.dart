/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"TotalRecords":99,"FirstRecord":41,"LastRecord":60,"TotalPage":5,"Data":[{"OrderIDP":"513c57e6-cabb-41a5-9eff-feec286833c4","FormatedOrderDate":"26-12-2024 11:03 AM","GrandTotal":2.16,"Address":"Shapath 3, Sarkhej Gandhinagar Highway Bodakdev Ahmedabad - 380054","PinCode":"380054","StateName":"Perak","CityName":"Gopeng","Country":"Malaysia","CurrencySymbol":"RM","CurrencyCode":"MYR","PaymentGatewayName":"Fiuu","PaymentStatus":"P","PaymentGatewayNo":2,"PaymentGatewaySettingIDF":"8ac3e2eb-a423-4a27-819c-ffedd7065475","PaymentGatewayIDF":"b7171499-669d-474f-b19f-2f4b3e60718a","Name":"Guest","Email":"guest@qrt.com","PhoneCountryCode":"","PhoneNumber":"","TrackingOrderID":"9da84439547216dba0ef684a74272c3e7103e92b","UserIDF":"00000000-0000-0000-0000-000000000000","OrderType":1,"OrderSource":3,"RestaurantIDF":"00000000-0000-0000-0000-000000000000","BranchIDF":"00000000-0000-0000-0000-000000000000","SeatIDF":"5e31541a-9ec0-44f9-b43c-6ac0dc8748e9","OrderDate":"2024-12-26T11:03:22.468Z","OrderMenu":[{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":2,"DiscountPercentage":10.0,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.0,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":1.0,"ItemDiscountPrice":0.9,"DiscountedItemAmount":0.1,"DiscountedItemTotalAmount":0.2,"ItemTaxPrice":0.04,"ItemTotal":2.0,"ItemTotalTaxPrice":0.08,"ItemModifierTotal":0.0,"ItemDiscountPriceTotal":1.8,"TotalItemAmount":1.88}],"OrderTax":[{"TaxIDF":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":5.0,"TaxAmount":0.09},{"TaxIDF":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":10.0,"TaxAmount":0.19}],"QuantityTotal":0,"ItemTotal":0.0,"ModifierTotal":0.0,"DiscountTotal":0.0,"ItemTaxTotal":0.0,"SubTotal":0.0,"TaxAmountTotal":0.0,"TotalAmount":2.16,"AdditionalNotes":"","GuestInfo":null,"PaymentGatewayID":"00000000-0000-0000-0000-000000000000","PaymentGatewaySettingID":"00000000-0000-0000-0000-000000000000","TableNo":"Table-541"}]}

class OrderHistoryResponse {
  OrderHistoryResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    OrderHistoryResponseData? mOrderHistoryResponseData,
  }) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _mOrderHistoryResponseData = mOrderHistoryResponseData;
  }

  OrderHistoryResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _mOrderHistoryResponseData = json['data'] != null
        ? OrderHistoryResponseData.fromJson(json['data'])
        : null;
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  OrderHistoryResponseData? _mOrderHistoryResponseData;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  OrderHistoryResponseData? get mOrderHistoryResponseData =>
      _mOrderHistoryResponseData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_mOrderHistoryResponseData != null) {
      map['data'] = _mOrderHistoryResponseData?.toJson();
    }
    return map;
  }
}

/// TotalRecords : 99
/// FirstRecord : 41
/// LastRecord : 60
/// TotalPage : 5
/// Data : [{"OrderIDP":"513c57e6-cabb-41a5-9eff-feec286833c4","FormatedOrderDate":"26-12-2024 11:03 AM","GrandTotal":2.16,"Address":"Shapath 3, Sarkhej Gandhinagar Highway Bodakdev Ahmedabad - 380054","PinCode":"380054","StateName":"Perak","CityName":"Gopeng","Country":"Malaysia","CurrencySymbol":"RM","CurrencyCode":"MYR","PaymentGatewayName":"Fiuu","PaymentStatus":"P","PaymentGatewayNo":2,"PaymentGatewaySettingIDF":"8ac3e2eb-a423-4a27-819c-ffedd7065475","PaymentGatewayIDF":"b7171499-669d-474f-b19f-2f4b3e60718a","Name":"Guest","Email":"guest@qrt.com","PhoneCountryCode":"","PhoneNumber":"","TrackingOrderID":"9da84439547216dba0ef684a74272c3e7103e92b","UserIDF":"00000000-0000-0000-0000-000000000000","OrderType":1,"OrderSource":3,"RestaurantIDF":"00000000-0000-0000-0000-000000000000","BranchIDF":"00000000-0000-0000-0000-000000000000","SeatIDF":"5e31541a-9ec0-44f9-b43c-6ac0dc8748e9","OrderDate":"2024-12-26T11:03:22.468Z","OrderMenu":[{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":2,"DiscountPercentage":10.0,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.0,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":1.0,"ItemDiscountPrice":0.9,"DiscountedItemAmount":0.1,"DiscountedItemTotalAmount":0.2,"ItemTaxPrice":0.04,"ItemTotal":2.0,"ItemTotalTaxPrice":0.08,"ItemModifierTotal":0.0,"ItemDiscountPriceTotal":1.8,"TotalItemAmount":1.88}],"OrderTax":[{"TaxIDF":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":5.0,"TaxAmount":0.09},{"TaxIDF":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":10.0,"TaxAmount":0.19}],"QuantityTotal":0,"ItemTotal":0.0,"ModifierTotal":0.0,"DiscountTotal":0.0,"ItemTaxTotal":0.0,"SubTotal":0.0,"TaxAmountTotal":0.0,"TotalAmount":2.16,"AdditionalNotes":"","GuestInfo":null,"PaymentGatewayID":"00000000-0000-0000-0000-000000000000","PaymentGatewaySettingID":"00000000-0000-0000-0000-000000000000","TableNo":"Table-541"}]

class OrderHistoryResponseData {
  OrderHistoryResponseData({
    int? totalRecords,
    int? firstRecord,
    int? lastRecord,
    int? totalPage,
    List<OrderHistoryData>? data,
  }) {
    _totalRecords = totalRecords;
    _firstRecord = firstRecord;
    _lastRecord = lastRecord;
    _totalPage = totalPage;
    _data = data;
  }

  OrderHistoryResponseData.fromJson(dynamic json) {
    _totalRecords = json['TotalRecords'];
    _firstRecord = json['FirstRecord'];
    _lastRecord = json['LastRecord'];
    _totalPage = json['TotalPage'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(OrderHistoryData.fromJson(v));
      });
    }
  }

  int? _totalRecords;
  int? _firstRecord;
  int? _lastRecord;
  int? _totalPage;
  List<OrderHistoryData>? _data;

  int? get totalRecords => _totalRecords;

  int? get firstRecord => _firstRecord;

  int? get lastRecord => _lastRecord;

  int? get totalPage => _totalPage;

  List<OrderHistoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalRecords'] = _totalRecords;
    map['FirstRecord'] = _firstRecord;
    map['LastRecord'] = _lastRecord;
    map['TotalPage'] = _totalPage;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// OrderIDP : "513c57e6-cabb-41a5-9eff-feec286833c4"
/// FormatedOrderDate : "26-12-2024 11:03 AM"
/// GrandTotal : 2.16
/// Address : "Shapath 3, Sarkhej Gandhinagar Highway Bodakdev Ahmedabad - 380054"
/// PinCode : "380054"
/// StateName : "Perak"
/// CityName : "Gopeng"
/// Country : "Malaysia"
/// CurrencySymbol : "RM"
/// CurrencyCode : "MYR"
/// PaymentGatewayName : "Fiuu"
/// PaymentStatus : "P"
/// PaymentGatewayNo : 2
/// PaymentGatewaySettingIDF : "8ac3e2eb-a423-4a27-819c-ffedd7065475"
/// PaymentGatewayIDF : "b7171499-669d-474f-b19f-2f4b3e60718a"
/// Name : "Guest"
/// Email : "guest@qrt.com"
/// PhoneCountryCode : ""
/// PhoneNumber : ""
/// TrackingOrderID : "9da84439547216dba0ef684a74272c3e7103e92b"
/// UserIDF : "00000000-0000-0000-0000-000000000000"
/// OrderType : 1
/// OrderSource : 3
/// RestaurantIDF : "00000000-0000-0000-0000-000000000000"
/// BranchIDF : "00000000-0000-0000-0000-000000000000"
/// SeatIDF : "5e31541a-9ec0-44f9-b43c-6ac0dc8748e9"
/// OrderDate : "2024-12-26T11:03:22.468Z"
/// OrderMenu : [{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":2,"DiscountPercentage":10.0,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.0,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":1.0,"ItemDiscountPrice":0.9,"DiscountedItemAmount":0.1,"DiscountedItemTotalAmount":0.2,"ItemTaxPrice":0.04,"ItemTotal":2.0,"ItemTotalTaxPrice":0.08,"ItemModifierTotal":0.0,"ItemDiscountPriceTotal":1.8,"TotalItemAmount":1.88}]
/// OrderTax : [{"TaxIDF":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":5.0,"TaxAmount":0.09},{"TaxIDF":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":10.0,"TaxAmount":0.19}]
/// QuantityTotal : 0
/// ItemTotal : 0.0
/// ModifierTotal : 0.0
/// DiscountTotal : 0.0
/// ItemTaxTotal : 0.0
/// SubTotal : 0.0
/// TaxAmountTotal : 0.0
/// TotalAmount : 2.16
/// AdjustedAmount : 2.16
/// AdditionalNotes : ""
/// GuestInfo : null
/// PaymentGatewayID : "00000000-0000-0000-0000-000000000000"
/// PaymentGatewaySettingID : "00000000-0000-0000-0000-000000000000"
/// TableNo : "Table-541"
/// EnvironmentType : 0 or 1
/// PackagingName : ""
/// "IsPaymentTypeChanged":true,
///"PaymentTypeChangedBy":"a35ca135-4c38-42a2-8aec-da4d4746aad9",
///"ReasonForChangingPaymentType":"mistake select payment type"
///"CounterBalanceHistoryIDF":"mistake select payment type"
class OrderHistoryData {
  OrderHistoryData({
    String? orderIDP,
    String? formatedOrderDate,
    double? grandTotal,
    String? address,
    String? pinCode,
    String? stateName,
    String? cityName,
    String? country,
    String? currencySymbol,
    String? currencyCode,
    String? paymentGatewayName,
    String? paymentStatus,
    int? paymentGatewayNo,
    String? paymentGatewaySettingIDF,
    String? paymentGatewayIDF,
    String? name,
    String? email,
    String? phoneCountryCode,
    String? phoneNumber,
    String? trackingOrderID,
    String? userIDF,
    int? orderType,
    int? orderSource,
    String? restaurantIDF,
    String? branchIDF,
    String? seatIDF,
    String? orderDate,
    List<OrderHistoryMenu>? orderMenu,
    List<OrderHistoryTax>? orderTax,
    int? quantityTotal,
    double? itemTotal,
    double? modifierTotal,
    double? discountTotal,
    double? itemTaxTotal,
    double? subTotal,
    double? taxAmountTotal,
    double? totalAmount,
    double? adjustedAmount,
    String? additionalNotes,
    dynamic guestInfo,
    String? paymentGatewayID,
    String? paymentGatewaySettingID,
    String? tableNo,
    String? packagingName,
    String? environmentType,
    String? sequentialOrderID,
    String? paymentTypeChangedBy,
    String? reasonForChangingPaymentType,
    String? counterBalanceHistoryIDF,
    bool? isPaymentTypeChanged,
    String? payAmountCash,
    String? dueAmountCash,
    String? returnAmountCash,
  }) {
    _sequentialOrderID = sequentialOrderID;
    _orderIDP = orderIDP;
    _formatedOrderDate = formatedOrderDate;
    _grandTotal = grandTotal;
    _adjustedAmount = adjustedAmount;
    _address = address;
    _pinCode = pinCode;
    _stateName = stateName;
    _cityName = cityName;
    _country = country;
    _currencySymbol = currencySymbol;
    _currencyCode = currencyCode;
    _paymentGatewayName = paymentGatewayName;
    _paymentStatus = paymentStatus;
    _paymentGatewayNo = paymentGatewayNo;
    _paymentGatewaySettingIDF = paymentGatewaySettingIDF;
    _paymentGatewayIDF = paymentGatewayIDF;
    _name = name;
    _email = email;
    _phoneCountryCode = phoneCountryCode;
    _phoneNumber = phoneNumber;
    _trackingOrderID = trackingOrderID;
    _userIDF = userIDF;
    _orderType = orderType;
    _orderSource = orderSource;
    _restaurantIDF = restaurantIDF;
    _branchIDF = branchIDF;
    _seatIDF = seatIDF;
    _orderDate = orderDate;
    _orderMenu = orderMenu;
    _orderTax = orderTax;
    _quantityTotal = quantityTotal;
    _itemTotal = itemTotal;
    _modifierTotal = modifierTotal;
    _discountTotal = discountTotal;
    _itemTaxTotal = itemTaxTotal;
    _subTotal = subTotal;
    _taxAmountTotal = taxAmountTotal;
    _totalAmount = totalAmount;
    _additionalNotes = additionalNotes;
    _guestInfo = guestInfo;
    _paymentGatewayID = paymentGatewayID;
    _paymentGatewaySettingID = paymentGatewaySettingID;
    _tableNo = tableNo;
    _packagingName = packagingName;
    _environmentType = environmentType;
    _isPaymentTypeChanged = isPaymentTypeChanged;
    _paymentTypeChangedBy = paymentTypeChangedBy;
    _reasonForChangingPaymentType = reasonForChangingPaymentType;
    _counterBalanceHistoryIDF = counterBalanceHistoryIDF;
    _payAmountCash = payAmountCash;
    _dueAmountCash = dueAmountCash;
    _returnAmountCash = returnAmountCash;
  }

  OrderHistoryData.fromJson(dynamic json) {
    _sequentialOrderID = json['SequentialOrderID'];
    _orderIDP = json['OrderIDP'];
    _formatedOrderDate = json['FormatedOrderDate'];
    _grandTotal = json['GrandTotal'];
    _adjustedAmount = json['AdjustedAmount'];
    _address = json['Address'];
    _pinCode = json['PinCode'];
    _stateName = json['StateName'];
    _cityName = json['CityName'];
    _country = json['Country'];
    _currencySymbol = json['CurrencySymbol'];
    _currencyCode = json['CurrencyCode'];
    _paymentGatewayName = json['PaymentGatewayName'];
    _paymentStatus = json['PaymentStatus'];
    _paymentGatewayNo = json['PaymentGatewayNo'];
    _paymentGatewaySettingIDF = json['PaymentGatewaySettingIDF'];
    _paymentGatewayIDF = json['PaymentGatewayIDF'];
    _name = json['Name'];
    _email = json['Email'];
    _phoneCountryCode = json['PhoneCountryCode'];
    _phoneNumber = json['PhoneNumber'];
    _trackingOrderID = json['TrackingOrderID'];
    _userIDF = json['UserIDF'];
    _orderType = json['OrderType'];
    _orderSource = json['OrderSource'];
    _restaurantIDF = json['RestaurantIDF'];
    _branchIDF = json['BranchIDF'];
    _seatIDF = json['SeatIDF'];
    _orderDate = json['OrderDate'];
    if (json['OrderMenu'] != null) {
      _orderMenu = [];
      json['OrderMenu'].forEach((v) {
        _orderMenu?.add(OrderHistoryMenu.fromJson(v));
      });
    }
    if (json['OrderTax'] != null) {
      _orderTax = [];
      json['OrderTax'].forEach((v) {
        _orderTax?.add(OrderHistoryTax.fromJson(v));
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
    _additionalNotes = json['AdditionalNotes'];
    _guestInfo = json['GuestInfo'];
    _paymentGatewayID = json['PaymentGatewayID'];
    _paymentGatewaySettingID = json['PaymentGatewaySettingID'];
    _tableNo = json['TableNo'];
    _packagingName = json['PackagingName'];
    _paymentTypeChangedBy = json['PaymentTypeChangedBy']??'';
    _reasonForChangingPaymentType = json['ReasonForChangingPaymentType']??'';
    _counterBalanceHistoryIDF = json['CounterBalanceHistoryIDF']??'';
    _isPaymentTypeChanged = json['IsPaymentTypeChanged']??false;
    _environmentType = (json['EnvironmentType']??0).toString();
    _payAmountCash = (json['PayAmountCash']??0.00).toString();
    _dueAmountCash = (json['DueAmountCash']??0.00).toString();
    _returnAmountCash = (json['ReturnAmountCash']??0.00).toString();
  }

  String? _sequentialOrderID;
  String? _orderIDP;
  String? _formatedOrderDate;
  double? _grandTotal;
  double? _adjustedAmount;
  String? _address;
  String? _pinCode;
  String? _stateName;
  String? _cityName;
  String? _country;
  String? _currencySymbol;
  String? _currencyCode;
  String? _paymentGatewayName;
  String? _paymentStatus;
  int? _paymentGatewayNo;
  String? _paymentGatewaySettingIDF;
  String? _paymentGatewayIDF;
  String? _name;
  String? _email;
  String? _phoneCountryCode;
  String? _phoneNumber;
  String? _trackingOrderID;
  String? _userIDF;
  int? _orderType;
  int? _orderSource;
  String? _restaurantIDF;
  String? _branchIDF;
  String? _seatIDF;
  String? _orderDate;
  List<OrderHistoryMenu>? _orderMenu;
  List<OrderHistoryTax>? _orderTax;
  int? _quantityTotal;
  double? _itemTotal;
  double? _modifierTotal;
  double? _discountTotal;
  double? _itemTaxTotal;
  double? _subTotal;
  double? _taxAmountTotal;
  double? _totalAmount;
  String? _additionalNotes;
  dynamic _guestInfo;
  String? _paymentGatewayID;
  String? _paymentGatewaySettingID;
  String? _tableNo;
  String? _packagingName;
  String? _environmentType;
  String? _paymentTypeChangedBy;
  String? _reasonForChangingPaymentType;
  String? _counterBalanceHistoryIDF;
  bool? _isPaymentTypeChanged;
  String? _payAmountCash;
  String? _dueAmountCash;
  String? _returnAmountCash;

  String? get sequentialOrderID => _sequentialOrderID;
  
  String? get orderIDP => _orderIDP;

  String? get formatedOrderDate => _formatedOrderDate;

  double? get grandTotal => _grandTotal;

  double? get adjustedAmount => _adjustedAmount;

  String? get address => _address;

  String? get pinCode => _pinCode;

  String? get stateName => _stateName;

  String? get cityName => _cityName;

  String? get country => _country;

  String? get currencySymbol => _currencySymbol;

  String? get currencyCode => _currencyCode;

  String? get paymentGatewayName => _paymentGatewayName;

  String? get paymentStatus => _paymentStatus;

  int? get paymentGatewayNo => _paymentGatewayNo;

  String? get paymentGatewaySettingIDF => _paymentGatewaySettingIDF;

  String? get paymentGatewayIDF => _paymentGatewayIDF;

  String? get name => _name;

  String? get email => _email;

  String? get phoneCountryCode => _phoneCountryCode;

  String? get phoneNumber => _phoneNumber;

  String? get trackingOrderID => _trackingOrderID;

  String? get userIDF => _userIDF;

  int? get orderType => _orderType;

  int? get orderSource => _orderSource;

  String? get restaurantIDF => _restaurantIDF;

  String? get branchIDF => _branchIDF;

  String? get seatIDF => _seatIDF;

  String? get orderDate => _orderDate;

  List<OrderHistoryMenu>? get orderMenu => _orderMenu;

  List<OrderHistoryTax>? get orderTax => _orderTax;

  int? get quantityTotal => _quantityTotal;

  double? get itemTotal => _itemTotal;

  double? get modifierTotal => _modifierTotal;

  double? get discountTotal => _discountTotal;

  double? get itemTaxTotal => _itemTaxTotal;

  double? get subTotal => _subTotal;

  double? get taxAmountTotal => _taxAmountTotal;

  double? get totalAmount => _totalAmount;

  String? get additionalNotes => _additionalNotes;

  dynamic get guestInfo => _guestInfo;

  String? get paymentGatewayID => _paymentGatewayID;

  String? get paymentGatewaySettingID => _paymentGatewaySettingID;

  String? get tableNo => _tableNo;

  String? get packagingName => _packagingName;

  String? get environmentType => _environmentType;

  String? get paymentTypeChangedBy => _paymentTypeChangedBy;

  String? get reasonForChangingPaymentType => _reasonForChangingPaymentType;

  String? get counterBalanceHistoryIDF => _counterBalanceHistoryIDF;

  bool? get isPaymentTypeChanged => _isPaymentTypeChanged;

  String? get payAmountCash => _payAmountCash;

  String? get dueAmountCash => _dueAmountCash;

  String? get returnAmountCash => _returnAmountCash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SequentialOrderID'] = _sequentialOrderID;
    map['OrderIDP'] = _orderIDP;
    map['FormatedOrderDate'] = _formatedOrderDate;
    map['GrandTotal'] = _grandTotal;
    map['AdjustedAmount'] = _adjustedAmount;
    map['Address'] = _address;
    map['PinCode'] = _pinCode;
    map['StateName'] = _stateName;
    map['CityName'] = _cityName;
    map['Country'] = _country;
    map['CurrencySymbol'] = _currencySymbol;
    map['CurrencyCode'] = _currencyCode;
    map['PaymentGatewayName'] = _paymentGatewayName;
    map['PaymentStatus'] = _paymentStatus;
    map['PaymentGatewayNo'] = _paymentGatewayNo;
    map['PaymentGatewaySettingIDF'] = _paymentGatewaySettingIDF;
    map['PaymentGatewayIDF'] = _paymentGatewayIDF;
    map['Name'] = _name;
    map['Email'] = _email;
    map['PhoneCountryCode'] = _phoneCountryCode;
    map['PhoneNumber'] = _phoneNumber;
    map['TrackingOrderID'] = _trackingOrderID;
    map['UserIDF'] = _userIDF;
    map['OrderType'] = _orderType;
    map['OrderSource'] = _orderSource;
    map['RestaurantIDF'] = _restaurantIDF;
    map['BranchIDF'] = _branchIDF;
    map['SeatIDF'] = _seatIDF;
    map['OrderDate'] = _orderDate;
    if (_orderMenu != null) {
      map['OrderMenu'] = _orderMenu?.map((v) => v.toJson()).toList();
    }
    if (_orderTax != null) {
      map['OrderTax'] = _orderTax?.map((v) => v.toJson()).toList();
    }
    map['QuantityTotal'] = _quantityTotal;
    map['ItemTotal'] = _itemTotal;
    map['ModifierTotal'] = _modifierTotal;
    map['DiscountTotal'] = _discountTotal;
    map['ItemTaxTotal'] = _itemTaxTotal;
    map['SubTotal'] = _subTotal;
    map['TaxAmountTotal'] = _taxAmountTotal;
    map['TotalAmount'] = _totalAmount;
    map['AdditionalNotes'] = _additionalNotes;
    map['GuestInfo'] = _guestInfo;
    map['PaymentGatewayID'] = _paymentGatewayID;
    map['PaymentGatewaySettingID'] = _paymentGatewaySettingID;
    map['TableNo'] = _tableNo;
    map['PackagingName'] = _packagingName;
    map['EnvironmentType'] = _environmentType;
    map['IsPaymentTypeChanged'] = _isPaymentTypeChanged;
    map['PaymentTypeChangedBy'] = _paymentTypeChangedBy;
    map['ReasonForChangingPaymentType'] = _reasonForChangingPaymentType;
    map['CounterBalanceHistoryIDF'] = _counterBalanceHistoryIDF;
    map['PayAmountCash'] = _payAmountCash;
    map['DueAmountCash'] = _dueAmountCash;
    map['ReturnAmountCash'] = _returnAmountCash;
    return map;
  }
}

/// TaxIDF : "7aad68ca-7edb-4e36-a893-a191f6702ac2"
/// TaxName : "SST"
/// TaxPercentage : 5.0
/// TaxAmount : 0.09

class OrderHistoryTax {
  OrderHistoryTax({
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

  OrderHistoryTax.fromJson(dynamic json) {
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

/// MenuItemIDF : "5ee6184b-2293-43d6-beac-831b05a388c4"
/// VariantIDF : "78d5a4d3-b806-4ddd-96a0-748ac43759e5"
/// Quantity : 2
/// DiscountPercentage : 10.0
/// ItemName : "Tandoori Garlic Bread"
/// ItemVariantName : "Regular (4 Piece)"
/// ItemTaxPercent : 5.0
/// AllModifierPrices : ""
/// AllModifierIDFs : ""
/// VariantPrice : 1.0
/// ItemDiscountPrice : 0.9
/// DiscountedItemAmount : 0.1
/// DiscountedItemTotalAmount : 0.2
/// ItemTaxPrice : 0.04
/// ItemTotal : 2.0
/// ItemTotalTaxPrice : 0.08
/// ItemModifierTotal : 0.0
/// ItemDiscountPriceTotal : 1.8
/// TotalItemAmount : 1.88

class OrderHistoryMenu {
  OrderHistoryMenu({
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
    List<ModifierData>? modifierData,
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
    _modifierData = modifierData;
  }

  OrderHistoryMenu.fromJson(dynamic json) {
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
    if (json['ModifierData'] != null) {
      _modifierData = [];
      json['ModifierData'].forEach((v) {
        _modifierData?.add(ModifierData.fromJson(v));
      });
    }
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
  List<ModifierData>? _modifierData;

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

  List<ModifierData>? get modifierData => _modifierData;

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
    if (_modifierData != null) {
      map['ModifierData'] = _modifierData?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

/// ModifierIDP : "2453688d-2b3e-4f8c-b5f8-6b5c7ed9cece"
/// ModifierName : "Cheese slice (25g)"
/// Price : 10.0

class ModifierData {
  ModifierData({
    String? modifierIDP,
    String? modifierName,
    double? price,
  }) {
    _modifierIDP = modifierIDP;
    _modifierName = modifierName;
    _price = price;
  }

  ModifierData.fromJson(dynamic json) {
    _modifierIDP = json['ModifierIDP'];
    _modifierName = json['ModifierName'];
    _price = json['Price'];
  }

  String? _modifierIDP;
  String? _modifierName;
  double? _price;

  String? get modifierIDP => _modifierIDP;

  String? get modifierName => _modifierName;

  double? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ModifierIDP'] = _modifierIDP;
    map['ModifierName'] = _modifierName;
    map['Price'] = _price;
    return map;
  }
}
