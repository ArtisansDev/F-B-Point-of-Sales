/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"6e9934ce-fe33-4c2d-9628-fae5475f3a25","PaymentGatewaySettingIDP":"3224d722-48f4-4c99-915b-81b19740b7c3","PaymentGatewayName":"Cash","Description":"Cash payment option","PaymentGatewayLogo":"http://staging.artisanssolutions.com/admin/Content/Images/Payment/PGM_638678102710393181.png","PaymentGatewayNo":"0","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":""},{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"4edd3f4b-0115-4706-8244-452612462b83","PaymentGatewaySettingIDP":"a31ea642-eae3-4361-b097-c4bf2d998c01","PaymentGatewayName":"Senang Pay","Description":"Senang Pay","PaymentGatewayLogo":"http://staging.artisanssolutions.com/admin/Content/Images/Payment/PGM_638678132549611074.png","PaymentGatewayNo":"1","MerchantID":"761173165749545","SecretKey":"43106-268","APIKey":"","URL":"","Configurations":""},{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"b7171499-669d-474f-b19f-2f4b3e60718a","PaymentGatewaySettingIDP":"8ac3e2eb-a423-4a27-819c-ffedd7065475","PaymentGatewayName":"Fiuu","Description":"Fiuu (formerly Razer Merchant Services)","PaymentGatewayLogo":"http://staging.artisanssolutions.com/admin/Content/Images/Payment/PGM_638690076431347022.jpg","PaymentGatewayNo":"2","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":""}]

class GetAllPaymentTypeResponse {
  GetAllPaymentTypeResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    List<GetAllPaymentTypeData>? data,}) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
  }

  GetAllPaymentTypeResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetAllPaymentTypeData.fromJson(v));
      });
    }
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<GetAllPaymentTypeData>? _data;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  List<GetAllPaymentTypeData>? get data => _data;

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

/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// PaymentGatewayIDP : "6e9934ce-fe33-4c2d-9628-fae5475f3a25"
/// PaymentGatewaySettingIDP : "3224d722-48f4-4c99-915b-81b19740b7c3"
/// PaymentGatewayName : "Cash"
/// Description : "Cash payment option"
/// PaymentGatewayLogo : "http://staging.artisanssolutions.com/admin/Content/Images/Payment/PGM_638678102710393181.png"
/// PaymentGatewayNo : "0"
/// MerchantID : ""
/// SecretKey : ""
/// APIKey : ""
/// URL : ""
/// Configurations : ""
/// QRCodeData : [{"QRCodeImage":"QR_638747992413304281.jpg"},{"QRCodeImage":"QR_638747992413304282.jpg"}]

class GetAllPaymentTypeData {
  GetAllPaymentTypeData({
    String? restaurantIDF,
    String? paymentGatewayIDP,
    String? paymentGatewaySettingIDP,
    String? paymentGatewayName,
    String? description,
    String? paymentGatewayLogo,
    String? paymentGatewayNo,
    String? merchantID,
    String? secretKey,
    String? aPIKey,
    String? url,
    bool? isSelect,
    String? configurations,
    String? requestData,
    List<QrCodeData>? qRCodeData,
  }) {
    _restaurantIDF = restaurantIDF;
    _paymentGatewayIDP = paymentGatewayIDP;
    _paymentGatewaySettingIDP = paymentGatewaySettingIDP;
    _paymentGatewayName = paymentGatewayName;
    _description = description;
    _paymentGatewayLogo = paymentGatewayLogo;
    _paymentGatewayNo = paymentGatewayNo;
    _merchantID = merchantID;
    _secretKey = secretKey;
    _aPIKey = aPIKey;
    _url = url;
    _isSelect = isSelect;
    _configurations = configurations;
    _requestData = requestData;
    _qRCodeData = qRCodeData;
  }

  GetAllPaymentTypeData.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _paymentGatewayIDP = json['PaymentGatewayIDP'];
    _paymentGatewaySettingIDP = json['PaymentGatewaySettingIDP'];
    _paymentGatewayName = json['PaymentGatewayName'];
    _description = json['Description'];
    _paymentGatewayLogo = json['PaymentGatewayLogo'];
    _paymentGatewayNo = json['PaymentGatewayNo'];
    _merchantID = json['MerchantID'];
    _secretKey = json['SecretKey'];
    _aPIKey = json['APIKey'];
    _url = json['URL'];
    _isSelect = json['isSelect'] ?? false;
    _configurations = json['Configurations'];
    _requestData = json['RequestData'];
    if (json['QRCodeData'] != null) {
      _qRCodeData = [];
      json['QRCodeData'].forEach((v) {
        _qRCodeData?.add(QrCodeData.fromJson(v));
      });
    }
  }

  String? _restaurantIDF;
  String? _paymentGatewayIDP;
  String? _paymentGatewaySettingIDP;
  String? _paymentGatewayName;
  String? _description;
  String? _paymentGatewayLogo;
  String? _paymentGatewayNo;
  String? _merchantID;
  String? _secretKey;
  String? _aPIKey;
  String? _url;
  bool? _isSelect;
  String? _configurations;
  String? _requestData;
  List<QrCodeData>? _qRCodeData;


  String? get restaurantIDF => _restaurantIDF;

  String? get paymentGatewayIDP => _paymentGatewayIDP;

  String? get paymentGatewaySettingIDP => _paymentGatewaySettingIDP;

  String? get paymentGatewayName => _paymentGatewayName;

  String? get description => _description;

  String? get paymentGatewayLogo => _paymentGatewayLogo;

  String? get paymentGatewayNo => _paymentGatewayNo;

  String? get merchantID => _merchantID;

  String? get secretKey => _secretKey;

  String? get aPIKey => _aPIKey;

  String? get url => _url;

  bool? get isSelect => _isSelect;

  String? get configurations => _configurations;

  String? get requestData => _requestData;

  List<QrCodeData>? get qRCodeData => _qRCodeData;


  setIsSelect(bool isSelect) {
    _isSelect = isSelect;
  }

  setRequestData(String requestData) {
    _requestData = requestData;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['PaymentGatewayIDP'] = _paymentGatewayIDP;
    map['PaymentGatewaySettingIDP'] = _paymentGatewaySettingIDP;
    map['PaymentGatewayName'] = _paymentGatewayName;
    map['Description'] = _description;
    map['PaymentGatewayLogo'] = _paymentGatewayLogo;
    map['PaymentGatewayNo'] = _paymentGatewayNo;
    map['MerchantID'] = _merchantID;
    map['SecretKey'] = _secretKey;
    map['APIKey'] = _aPIKey;
    map['URL'] = _url;
    map['isSelect'] = _isSelect;
    map['Configurations'] = _configurations;
    map['RequestData'] = _requestData;
    if (_qRCodeData != null) {
      map['QRCodeData'] = _qRCodeData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// QRCodeImage : "QR_638747992413304281.jpg"

class QrCodeData {
  QrCodeData({
    String? qRCodeImage,}){
    _qRCodeImage = qRCodeImage;
  }

  QrCodeData.fromJson(dynamic json) {
    _qRCodeImage = json['QRCodeImage'];
  }
  String? _qRCodeImage;

  String? get qRCodeImage => _qRCodeImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['QRCodeImage'] = _qRCodeImage;
    return map;
  }

}