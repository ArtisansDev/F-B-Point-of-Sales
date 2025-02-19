// import 'order_place_guest_info_request.dart';
//
// /// TrackingOrderID : "123456789012"
// /// OrderNo : "1"
// /// UserIDF : "c4c82cc9-0f4e-4fa8-b440-d72a823a309f"
// /// OrderType : "Dine In"
// /// OrderSource : "Application"
// /// RestaurentIDP : "e7604cb6-1831-49f7-8c43-e7ef0e4a7fd7"
// /// BranchIDF : "34e74fb1-2da6-40fa-9cb4-98e20c3c83b4"
// /// OrderDate : "2024-10-29T12:34:56Z"
// /// OrderMenu : [{"MenuItemIDF":"21b56882-54a3-45bc-8fd6-597e345d08c0","VariantIDF":"79e6a511-225e-4ae4-a5d8-1b9d6d1a4e73","Quantity":2,"DiscountPercentage":10,"ItemName":"Pasta","ItemTaxPercent":5,"AllModifierPrices":"5,10","AllModifierIDFs":"8c4e0e9c-29bb-44c1-a0b4-e94ab26da1a4,f223ff6b-7a2f-48da-b09c-e90deab4c618","VariantPrice":100.00,"ItemDiscountPrice":90.00,"ItemTaxPrice":4.50,"ItemModifierTotal":15.00,"ItemTotal":109.50},{"MenuItemIDF":"bb41d058-41ee-4b0f-b3bc-ccde0c63e9db","VariantIDF":"8f2d2058-3a6c-4585-9b58-ecf8127f6cf6","Quantity":1,"DiscountPercentage":5,"ItemName":"Pizza","ItemTaxPercent":8,"AllModifierPrices":"10,20","AllModifierIDFs":"4e5093c7-6b30-4ecf-8a1c-f0e85840730b,2a6e58e3-0b89-4f78-9914-9b8fbbd47fa1","VariantPrice":500.00,"ItemDiscountPrice":475.00,"ItemTaxPrice":38.00,"ItemModifierTotal":30.00,"ItemTotal":543.00}]
// /// OrderTax : [{"TaxIDP":"e3e3b054-1c62-4e7d-b46a-2d841e7b6c67","TaxName":"GST","TaxPercentage":10,"TaxAmount":65.00},{"TaxIDP":"dcb80f2a-5d8e-4c7d-9be7-48c4eb4fd7f5","TaxName":"Service Tax","TaxPercentage":5,"TaxAmount":32.50}]
// /// QuantityTotal : 3
// /// ItemTotal : 652.50
// /// ModifierTotal : 45.00
// /// DiscountTotal : 35.00
// /// ItemTaxTotal : 42.50
// /// SubTotal : 705.00
// /// TaxAmountTotal : 97.50
// /// GrandTotal : 802.50
// /// AdditionalNotes : "Please add extra cheese to the pizza."
//
// class OrderPlaceRequest {
//   OrderPlaceRequest({
//     this.trackingOrderID,
//     this.orderNo,
//     this.userIDF,
//     this.orderType,
//     this.orderSource,
//     this.restaurentIDP,
//     this.branchIDF,
//     this.orderDate,
//     this.orderMenu,
//     this.orderTax,
//     this.quantityTotal,
//     this.itemTotal,
//     this.modifierTotal,
//     this.discountTotal,
//     this.itemTaxTotal,
//     this.subTotal,
//     this.taxAmountTotal,
//     this.totalAmount,
//     this.grandTotal,
//     this.additionalNotes,
//     this.paymentGatewayID,
//     this.paymentGatewaySettingID,
//     this.tableNo,
//     this.seatIDF,
//     this.orderPlaceGuestInfoRequest,
//   });
//
//   OrderPlaceRequest.fromJson(dynamic json) {
//     trackingOrderID = json['TrackingOrderID'];
//     orderNo = json['OrderNo'];
//     userIDF = json['UserIDF'];
//     orderType = json['OrderType'];
//     orderSource = json['OrderSource'];
//     restaurentIDP = json['RestaurantIDF'];
//     branchIDF = json['BranchIDF'];
//     orderDate = json['OrderDate'];
//     if (json['OrderMenu'] != null) {
//       orderMenu = [];
//       json['OrderMenu'].forEach((v) {
//         orderMenu?.add(OrderMenu.fromJson(v));
//       });
//     }
//     if (json['OrderTax'] != null) {
//       orderTax = [];
//       json['OrderTax'].forEach((v) {
//         orderTax?.add(OrderTax.fromJson(v));
//       });
//     }
//     quantityTotal = json['QuantityTotal'];
//     itemTotal = json['ItemTotal'];
//     modifierTotal = json['ModifierTotal'];
//     discountTotal = json['DiscountTotal'];
//     itemTaxTotal = json['ItemTaxTotal'];
//     subTotal = json['SubTotal'];
//     taxAmountTotal = json['TaxAmountTotal'];
//     totalAmount = json['TotalAmount'];
//     grandTotal = json['GrandTotal'];
//     additionalNotes = json['AdditionalNotes'];
//     paymentGatewayID = json['PaymentGatewayID'];
//     paymentGatewaySettingID = json['PaymentGatewaySettingID'];
//     tableNo = json['TableNo'];
//     seatIDF = json['SeatIDF'];
//     orderPlaceGuestInfoRequest = json['GuestInfo'] != null
//         ? OrderPlaceGuestInfoRequest.fromJson(json['GuestInfo'])
//         : null;
//   }
//
//   String? trackingOrderID;
//   String? orderNo;
//   String? userIDF;
//   String? orderType;
//   String? orderSource;
//   String? restaurentIDP;
//   String? branchIDF;
//   String? orderDate;
//   List<OrderMenu>? orderMenu;
//   List<OrderTax>? orderTax;
//   int? quantityTotal;
//   double? itemTotal;
//   double? modifierTotal;
//   double? discountTotal;
//   double? itemTaxTotal;
//   double? subTotal;
//   double? taxAmountTotal;
//   double? totalAmount;
//   double? grandTotal;
//   String? additionalNotes;
//   String? paymentGatewayID;
//   String? paymentGatewaySettingID;
//   String? tableNo;
//   String? seatIDF;
//   OrderPlaceGuestInfoRequest? orderPlaceGuestInfoRequest;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['TrackingOrderID'] = trackingOrderID;
//     map['OrderNo'] = orderNo;
//     map['UserIDF'] = userIDF;
//     map['OrderType'] = orderType;
//     map['OrderSource'] = orderSource;
//     map['RestaurantIDF'] = restaurentIDP;
//     map['BranchIDF'] = branchIDF;
//     map['OrderDate'] = orderDate;
//     map['QuantityTotal'] = quantityTotal;
//     map['ItemTotal'] = itemTotal;
//     map['ModifierTotal'] = modifierTotal;
//     map['DiscountTotal'] = discountTotal;
//     map['ItemTaxTotal'] = itemTaxTotal;
//     map['SubTotal'] = subTotal;
//     map['TaxAmountTotal'] = taxAmountTotal;
//     map['TotalAmount'] = totalAmount;
//     map['GrandTotal'] = grandTotal;
//     map['AdditionalNotes'] = additionalNotes;
//     map['PaymentGatewayID'] = paymentGatewayID;
//     map['PaymentGatewaySettingID'] = paymentGatewaySettingID;
//     map['TableNo'] = tableNo;
//     map['SeatIDF'] = seatIDF;
//     if (orderTax != null) {
//       map['OrderTax'] = orderTax?.map((v) => v.toJson()).toList();
//     }
//     if (orderMenu != null) {
//       map['OrderMenu'] = orderMenu?.map((v) => v.toJson()).toList();
//     }
//     if (orderPlaceGuestInfoRequest != null) {
//       map['GuestInfo'] = orderPlaceGuestInfoRequest?.toJson();
//     }
//     return map;
//   }
// }
//
// /// TaxIDP : "e3e3b054-1c62-4e7d-b46a-2d841e7b6c67"
// /// TaxName : "GST"
// /// TaxPercentage : 10
// /// TaxAmount : 65.00
//
// class OrderTax {
//   OrderTax({
//     this.taxIDP,
//     this.taxName,
//     this.taxPercentage,
//     this.taxAmount,
//   });
//
//   OrderTax.fromJson(dynamic json) {
//     taxIDP = json['TaxIDF'];
//     taxName = json['TaxName'];
//     taxPercentage = json['TaxPercentage'];
//     taxAmount = json['TaxAmount'];
//   }
//
//   String? taxIDP;
//   String? taxName;
//   double? taxPercentage;
//   double? taxAmount;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['TaxIDF'] = taxIDP;
//     map['TaxName'] = taxName;
//     map['TaxPercentage'] = taxPercentage;
//     map['TaxAmount'] = taxAmount;
//     return map;
//   }
// }
//
// /// MenuItemIDF : "21b56882-54a3-45bc-8fd6-597e345d08c0"
// /// VariantIDF : "79e6a511-225e-4ae4-a5d8-1b9d6d1a4e73"
// /// Quantity : 2
// /// DiscountPercentage : 10
// /// ItemName : "Pasta"
// /// ItemTaxPercent : 5
// /// AllModifierPrices : "5,10"
// /// AllModifierIDFs : "8c4e0e9c-29bb-44c1-a0b4-e94ab26da1a4,f223ff6b-7a2f-48da-b09c-e90deab4c618"
// /// VariantPrice : 100.00
// /// ItemDiscountPrice : 90.00
// /// ItemTaxPrice : 4.50
// /// ItemModifierTotal : 15.00
// /// ItemTotal : 109.50
//
// class OrderMenu {
//   OrderMenu({
//     this.menuItemIDF,
//     this.variantIDF,
//     this.quantity,
//     this.discountPercentage,
//     this.discountedItemTotalAmount,
//     this.itemName,
//     this.itemTaxPercent,
//     this.allModifierPrices,
//     this.allModifierIDFs,
//     this.variantPrice,
//     this.itemVariantName,
//     this.itemDiscountPrice,
//     this.discountedItemAmount,
//     this.itemDiscountPriceTotal,
//     this.itemTaxPrice,
//     this.itemModifierTotal,
//     this.itemTotalTaxPrice,
//     this.itemTotal,
//     this.totalItemAmount,
//   });
//
//   OrderMenu.fromJson(dynamic json) {
//     menuItemIDF = json['MenuItemIDF'];
//     variantIDF = json['VariantIDF'];
//     quantity = json['Quantity'];
//     discountPercentage = json['DiscountPercentage'];
//     discountedItemTotalAmount = json['DiscountedItemTotalAmount'];
//     itemName = json['ItemName'];
//     itemTaxPercent = json['ItemTaxPercent'];
//     allModifierPrices = json['AllModifierPrices'];
//     allModifierIDFs = json['AllModifierIDFs'];
//     variantPrice = json['VariantPrice'];
//     itemVariantName = json['ItemVariantName'];
//     itemDiscountPrice = json['ItemDiscountPrice'];
//     discountedItemAmount = json['DiscountedItemAmount'];
//     itemDiscountPriceTotal = json['ItemDiscountPriceTotal'];
//     itemTaxPrice = json['ItemTaxPrice'];
//     itemTotalTaxPrice = json['ItemTotalTaxPrice'];
//     itemModifierTotal = json['ItemModifierTotal'];
//     itemTotal = json['ItemTotal'];
//     totalItemAmount = json['TotalItemAmount'];
//   }
//
//   String? menuItemIDF;
//   String? variantIDF;
//   int? quantity;
//   double? discountPercentage;
//   double? discountedItemTotalAmount;
//   String? itemName;
//   double? itemTaxPercent;
//   String? allModifierPrices;
//   String? allModifierIDFs;
//   double? variantPrice;
//   String? itemVariantName;
//   double? itemDiscountPrice;
//   double? discountedItemAmount;
//   double? itemDiscountPriceTotal;
//   double? itemTaxPrice;
//   double? itemTotalTaxPrice;
//   double? itemModifierTotal;
//   double? itemTotal;
//   double? totalItemAmount;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['MenuItemIDF'] = menuItemIDF;
//     map['VariantIDF'] = variantIDF;
//     map['Quantity'] = quantity;
//     map['DiscountPercentage'] = discountPercentage;
//     map['ItemName'] = itemName;
//     map['DiscountedItemTotalAmount'] = discountedItemTotalAmount;
//     map['ItemTaxPercent'] = itemTaxPercent;
//     map['AllModifierPrices'] = allModifierPrices;
//     map['AllModifierIDFs'] = allModifierIDFs;
//     map['VariantPrice'] = variantPrice;
//     map['ItemVariantName'] = itemVariantName;
//     map['ItemDiscountPrice'] = itemDiscountPrice;
//     map['DiscountedItemAmount'] = discountedItemAmount;
//     map['ItemDiscountPriceTotal'] = itemDiscountPriceTotal;
//     map['ItemTaxPrice'] = itemTaxPrice;
//     map['ItemTotalTaxPrice'] = itemTotalTaxPrice;
//     map['ItemModifierTotal'] = itemModifierTotal;
//     map['ItemTotal'] = itemTotal;
//     map['TotalItemAmount'] = totalItemAmount;
//     return map;
//   }
// }
