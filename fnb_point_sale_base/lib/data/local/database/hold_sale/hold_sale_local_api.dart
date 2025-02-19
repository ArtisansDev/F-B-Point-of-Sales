
import '../../../mode/cart_item/order_place.dart';
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import 'hold_sale_model.dart';

abstract class HoldSaleLocalApi {

  /// Save Current logged in HoldSale
  Future<void> save(HoldSaleModel mHoldSaleModel);

  /// Get Current logged in HoldSale
  Future<HoldSaleModel?> getAllHoldSale();

  /// Get Current logged in HoldSale
  Future<int?> getHoldSaleCount();

  /// Edit the current HoldSale
  Future<void> getHoldSaleEdit(OrderPlace mOrderPlace);

  /// Delete the current HoldSale
  Future<bool> getHoldSaleDelete(String sOrderNo);
  /// Delete the current HoldSale
  Future<bool> deleteAllHoldSale();

  Future<void> clearBox();
}
