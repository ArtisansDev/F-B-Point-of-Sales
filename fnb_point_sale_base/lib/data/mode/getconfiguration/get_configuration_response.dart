// To parse this JSON data, do
//
//     final getConfigurationResponse = getConfigurationResponseFromJson(jsonString);

import 'dart:convert';

import '../../../utils/num_utils.dart';


GetConfigurationResponse getConfigurationResponseFromJson(String str) => GetConfigurationResponse.fromJson(json.decode(str));

String getConfigurationResponseToJson(GetConfigurationResponse data) => json.encode(data.toJson());

class GetConfigurationResponse {
  List<RoundOffConfiguration>? roundOffConfiguration;
  int? salesTaxPercentage;
  int? numberOfReceipts;
  int? salesReturnDaysLimit;
  String? receiptFooter;
  String? disclaimer;
  String? storeRegistrationNumber;
  String? storeSstNumber;
  int? creditNoteExpirationDays;
  int? loyaltyPointExpirationDays;
  String? cashOutLimitInfo;
  String? cashOutLimitWarning;
  String? cashOutLimitRestrict;
  int? newMemberFreeLoyaltyPoints;
  int? minPromotersPerItem;
  bool? isPromoterMandatory;
  bool? isBillReferenceNumberMandatory;
  int? allowExchangeToDifferentStore;
  bool? allowPriceOverrideCartLevel;
  bool? isEmployeeBookingPaymentAllowed;
  bool? allowNegativePayment;
  bool? allowCreditSale;
  bool? allowEmployeeCreditSale;
  EType? discountApplicableType;
  EType? bookingPaymentUseType;
  bool? autoBirthdayVoucherGeneration;
  String? memberRegistrationLink;
  String? currencySymbol;

  GetConfigurationResponse({
    this.roundOffConfiguration,
    this.salesTaxPercentage,
    this.numberOfReceipts,
    this.salesReturnDaysLimit,
    this.receiptFooter,
    this.disclaimer,
    this.storeRegistrationNumber,
    this.storeSstNumber,
    this.creditNoteExpirationDays,
    this.loyaltyPointExpirationDays,
    this.cashOutLimitInfo,
    this.cashOutLimitWarning,
    this.cashOutLimitRestrict,
    this.newMemberFreeLoyaltyPoints,
    this.minPromotersPerItem,
    this.isPromoterMandatory,
    this.isBillReferenceNumberMandatory,
    this.allowExchangeToDifferentStore,
    this.allowPriceOverrideCartLevel,
    this.isEmployeeBookingPaymentAllowed,
    this.allowNegativePayment,
    this.allowCreditSale,
    this.allowEmployeeCreditSale,
    this.discountApplicableType,
    this.bookingPaymentUseType,
    this.autoBirthdayVoucherGeneration,
    this.memberRegistrationLink,
    this.currencySymbol,
  });

  factory GetConfigurationResponse.fromJson(Map<String, dynamic> json) => GetConfigurationResponse(
    roundOffConfiguration: json["round_off_configuration"] == null ? [] : List<RoundOffConfiguration>.from(json["round_off_configuration"]!.map((x) => RoundOffConfiguration.fromJson(x))),
    salesTaxPercentage: json["sales_tax_percentage"],
    numberOfReceipts: getInValue(json["number_of_receipts"]??1),
    salesReturnDaysLimit: json["sales_return_days_limit"],
    receiptFooter: json["receipt_footer"],
    disclaimer: json["disclaimer"],
    storeRegistrationNumber: json["store_registration_number"],
    storeSstNumber: json["store_sst_number"],
    creditNoteExpirationDays: json["credit_note_expiration_days"],
    loyaltyPointExpirationDays: json["loyalty_point_expiration_days"],
    cashOutLimitInfo: json["cash_out_limit_info"],
    cashOutLimitWarning: json["cash_out_limit_warning"],
    cashOutLimitRestrict: json["cash_out_limit_restrict"],
    newMemberFreeLoyaltyPoints: json["new_member_free_loyalty_points"],
    minPromotersPerItem: json["min_promoters_per_item"],
    isPromoterMandatory: json["is_promoter_mandatory"],
    isBillReferenceNumberMandatory: json["is_bill_reference_number_mandatory"],
    allowExchangeToDifferentStore: json["allow_exchange_to_different_store"],
    allowPriceOverrideCartLevel: json["allow_price_override_cart_level"],
    isEmployeeBookingPaymentAllowed: json["is_employee_booking_payment_allowed"],
    allowNegativePayment: json["allow_negative_payment"],
    allowCreditSale: json["allow_credit_sale"],
    allowEmployeeCreditSale: json["allow_employee_credit_sale"],
    discountApplicableType: json["discount_applicable_type"] == null ? null : EType.fromJson(json["discount_applicable_type"]),
    bookingPaymentUseType: json["booking_payment_use_type"] == null ? null : EType.fromJson(json["booking_payment_use_type"]),
    autoBirthdayVoucherGeneration: json["auto_birthday_voucher_generation"],
    memberRegistrationLink: json["member_registration_link"],
    currencySymbol: json["currency_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "round_off_configuration": roundOffConfiguration == null ? [] : List<dynamic>.from(roundOffConfiguration!.map((x) => x.toJson())),
    "sales_tax_percentage": salesTaxPercentage,
    "number_of_receipts": numberOfReceipts,
    "sales_return_days_limit": salesReturnDaysLimit,
    "receipt_footer": receiptFooter,
    "disclaimer": disclaimer,
    "store_registration_number": storeRegistrationNumber,
    "store_sst_number": storeSstNumber,
    "credit_note_expiration_days": creditNoteExpirationDays,
    "loyalty_point_expiration_days": loyaltyPointExpirationDays,
    "cash_out_limit_info": cashOutLimitInfo,
    "cash_out_limit_warning": cashOutLimitWarning,
    "cash_out_limit_restrict": cashOutLimitRestrict,
    "new_member_free_loyalty_points": newMemberFreeLoyaltyPoints,
    "min_promoters_per_item": minPromotersPerItem,
    "is_promoter_mandatory": isPromoterMandatory,
    "is_bill_reference_number_mandatory": isBillReferenceNumberMandatory,
    "allow_exchange_to_different_store": allowExchangeToDifferentStore,
    "allow_price_override_cart_level": allowPriceOverrideCartLevel,
    "is_employee_booking_payment_allowed": isEmployeeBookingPaymentAllowed,
    "allow_negative_payment": allowNegativePayment,
    "allow_credit_sale": allowCreditSale,
    "allow_employee_credit_sale": allowEmployeeCreditSale,
    "discount_applicable_type": discountApplicableType?.toJson(),
    "booking_payment_use_type": bookingPaymentUseType?.toJson(),
    "auto_birthday_voucher_generation": autoBirthdayVoucherGeneration,
    "member_registration_link": memberRegistrationLink,
    "currency_symbol": currencySymbol,
  };
}

class EType {
  int? id;
  String? name;
  String? key;

  EType({
    this.id,
    this.name,
    this.key,
  });

  factory EType.fromJson(Map<String, dynamic> json) => EType(
    id: json["id"],
    name: json["name"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "key": key,
  };
}

class RoundOffConfiguration {
  String? decimalPlace;
  String? value;

  RoundOffConfiguration({
    this.decimalPlace,
    this.value,
  });

  factory RoundOffConfiguration.fromJson(Map<String, dynamic> json) => RoundOffConfiguration(
    decimalPlace: json["decimal_place"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "decimal_place": decimalPlace,
    "value": value,
  };
}