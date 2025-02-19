
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';

import '../../../mode/cart_item/order_place.dart';

abstract class PlaceOrderSaleLocalApi {

  /// Save Current logged in HoldSale
  Future<void> save(PlaceOrderSaleModel mPlaceOrderSaleModel);

  /// Get Current logged in HoldSale
  Future<PlaceOrderSaleModel?> getAllPlaceOrderSale();

  /// Get Current logged in HoldSale
  Future<int?> getPlaceOrderSaleCount();

  /// Edit the current HoldSale
  Future<void> getPlaceOrderSaleEdit(OrderPlace mOrderPlace);

  /// Delete the current HoldSale
  Future<bool> getPlaceOrderDelete(String sOrderNo);

  /// Delete the current HoldSale
  Future<bool> deleteAllHoldSale();

  Future<void> clearBox();
}
