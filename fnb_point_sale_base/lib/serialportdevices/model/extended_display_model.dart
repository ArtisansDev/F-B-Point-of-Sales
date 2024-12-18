
import '../../data/mode/get_configuration/get_configuration_response.dart';

/// args1 : "Customer Display"
/// args2 : 100
/// args3 : true
/// business : "business_test"
/// media_files : ["pp","pp1"]
/// get_configuration_response : {"round_off_configuration":[{"decimal_place":".01","value":"-0.01"},{"decimal_place":".02","value":"-0.02"},{"decimal_place":".03","value":"0.02"},{"decimal_place":".04","value":"0.01"},{"decimal_place":".05","value":"0.00"},{"decimal_place":".06","value":"-0.01"},{"decimal_place":".07","value":"-0.02"},{"decimal_place":".08","value":"0.02"},{"decimal_place":".09","value":"0.01"},{"decimal_place":".00","value":"0.00"}],"sales_tax_percentage":0,"sales_return_days_limit":2,"receipt_footer":"Test","disclaimer":"Testing","store_registration_number":"33212458214500","store_sst_number":"2200145010036501","credit_note_expiration_days":2,"loyalty_point_expiration_days":2,"cash_out_limit_info":null,"cash_out_limit_warning":null,"cash_out_limit_restrict":null,"new_member_free_loyalty_points":100,"min_promoters_per_item":1,"is_promoter_mandatory":true,"is_bill_reference_number_mandatory":true,"allow_exchange_to_different_store":1,"allow_price_override_cart_level":true,"is_employee_booking_payment_allowed":true,"allow_negative_payment":false,"allow_credit_sale":true,"allow_employee_credit_sale":true,"discount_applicable_type":{"id":1,"name":"Additional Discount On Already Discounted Prices","key":"ADDITIONAL_DISCOUNT_ON_ALREADY_DISCOUNTED_PRICES"},"booking_payment_use_type":{"id":1,"name":"Partially","key":"PARTIALLY"},"auto_birthday_voucher_generation":false,"member_registration_link":"https://posqa.freshbits.in/12/member-registration"}

class ExtendedDisplayModel {
  ExtendedDisplayModel({
    this.args1,
    this.args2,
    this.args3,
    this.business,
    this.mediaFiles,
    this.mColor,
    this.sCurrency,
    this.sCartSummary,
    this.getConfigurationResponse,
    this.logoPath,

  });

  ExtendedDisplayModel.fromJson(dynamic json) {
    args1 = json['args1'];
    args2 = json['args2'];
    args3 = json['args3'];
    business = json['business'];
    mColor = json['mColor'];
    sCurrency = json['sCurrency'];
    sCartSummary = json['sCartSummary'];
    mediaFiles = json['media_files'] != null ? json['media_files'].cast<String>() : [];
    getConfigurationResponse = json['get_configuration_response'] != null ? GetConfigurationResponse.fromJson(json['get_configuration_response']) : null;
    logoPath = json['logoPath'];
  }
  String? args1;
  int? args2;
  bool? args3;
  String? business;
  List<String>? mediaFiles;
  GetConfigurationResponse? getConfigurationResponse;
  String? mColor;
  String? sCurrency;
  String? sCartSummary;
  String? logoPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['args1'] = args1;
    map['args2'] = args2;
    map['args3'] = args3;
    map['business'] = business;
    map['media_files'] = mediaFiles;
    map['mColor'] = mColor;
    map['sCurrency'] = sCurrency;
    map['sCartSummary'] = sCartSummary;
    if (getConfigurationResponse != null) {
      map['get_configuration_response'] = getConfigurationResponse?.toJson();
    }
    map['logoPath'] = logoPath;
    return map;
  }

}

/// id : 1
/// name : "Partially"
/// key : "PARTIALLY"

class BookingPaymentUseType {
  BookingPaymentUseType({
    this.id,
    this.name,
    this.key,});

  BookingPaymentUseType.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
  }
  int? id;
  String? name;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['key'] = key;
    return map;
  }

}

/// id : 1
/// name : "Additional Discount On Already Discounted Prices"
/// key : "ADDITIONAL_DISCOUNT_ON_ALREADY_DISCOUNTED_PRICES"

class DiscountApplicableType {
  DiscountApplicableType({
    this.id,
    this.name,
    this.key,});

  DiscountApplicableType.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
  }
  int? id;
  String? name;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['key'] = key;
    return map;
  }

}

/// decimal_place : ".01"
/// value : "-0.01"

class RoundOffConfiguration {
  RoundOffConfiguration({
    this.decimalPlace,
    this.value,});

  RoundOffConfiguration.fromJson(dynamic json) {
    decimalPlace = json['decimal_place'];
    value = json['value'];
  }
  String? decimalPlace;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['decimal_place'] = decimalPlace;
    map['value'] = value;
    return map;
  }

}