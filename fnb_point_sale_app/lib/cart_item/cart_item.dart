import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';

///partha paul
///cart_item
///21/12/24
class CartItem {
  MenuItemData? mMenuItemData;
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

  String textRemarks ="";

  CartItem(
      {this.mMenuItemData,
      this.mModifierList,
      this.mSelectModifierList,
      this.mVariantListData,
      this.mSelectVariantListData});
}
