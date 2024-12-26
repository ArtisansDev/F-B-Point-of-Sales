import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';

///partha paul
///cart_item
///21/12/24
class CartItem {
  MenuItemData? mMenuItemData;
  ///
  int count = 1;
  double price = 0.0;
  double totalPrice = 0.0;
  double taxAmount = 0.0;
  double taxPriceAmount = 0.0;

  ///Variant
  List<VariantListData>? mVariantListData;
  VariantListData? mSelectVariantListData;

  ///Modifier
  double priceModifier = 0.0;
  List<ModifierList>? mModifierList;
  List<ModifierList>? mSelectModifierList;

  String textRemarks = "";
  bool placeOrder = false;

  CartItem(
      {this.mMenuItemData,
      this.mModifierList,
      this.mSelectModifierList,
      this.mVariantListData,
      this.mSelectVariantListData});

  CartItem.fromJson(dynamic json) {
    mMenuItemData = json['menu_item_data'] != null
        ? MenuItemData.fromJson(json['menu_item_data'])
        : null;

    ///
    count = json['count'];
    price = json['price'];
    totalPrice = json['total_price'];
    taxAmount = json['tax_amount'];
    taxPriceAmount = json['tax_price_amount'];

    ///
    if (json['variant_list_data'] != null) {
      mVariantListData = [];
      json['variant_list_data'].forEach((v) {
        mVariantListData?.add(VariantListData.fromJson(v));
      });
    }
    mSelectVariantListData = json['select_variant_list_data'] != null
        ? VariantListData.fromJson(json['select_variant_list_data'])
        : null;

    ///
    priceModifier = json['price_modifier'];
    if (json['modifier_list'] != null) {
      mModifierList = [];
      json['modifier_list'].forEach((v) {
        mModifierList?.add(ModifierList.fromJson(v));
      });
    }
    if (json['select_modifier_list'] != null) {
      mSelectModifierList = [];
      json['select_modifier_list'].forEach((v) {
        mSelectModifierList?.add(ModifierList.fromJson(v));
      });
    }

    ///
    textRemarks = json['text_remarks']??'';
    placeOrder = json['place_order']??false;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mMenuItemData != null) {
      map['menu_item_data'] = mMenuItemData?.toJson();
    }
    ///
    map['count'] = count;
    map['price'] = price;
    map['total_price'] = totalPrice;
    map['tax_amount'] = taxAmount;
    map['tax_price_amount'] = taxPriceAmount;
    ///
    if (mVariantListData != null) {
      map['variant_list_data'] =
          mVariantListData?.map((v) => v.toJson()).toList();
    }
    if (mSelectVariantListData != null) {
      map['select_variant_list_data'] = mSelectVariantListData?.toJson();
    }
    ///
    map['price_modifier'] = priceModifier;
    if (mModifierList != null) {
      map['modifier_list'] =
          mModifierList?.map((v) => v.toJson()).toList();
    }
    if (mSelectModifierList != null) {
      map['select_modifier_list'] =
          mSelectModifierList?.map((v) => v.toJson()).toList();
    }

    ///
    map['text_remarks'] = textRemarks;
    map['place_order'] = placeOrder;

    return map;
  }
}
