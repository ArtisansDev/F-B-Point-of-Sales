

import '../../../mode/cart_item/order_place.dart';
import '../../../mode/order_place/process_multiple_orders_request.dart';

abstract class OfflinePlaceOrderSaleLocalApi {

  /// Save Current logged in HoldSale
  Future<void> save(ProcessMultipleOrdersRequest mProcessMultipleOrdersRequest);

  /// Get Current logged in HoldSale
  Future<ProcessMultipleOrdersRequest?> getAllPlaceOrderSale();

  /// Get Current logged in HoldSale
  Future<int?> getPlaceOrderSaleCount();

  /// Edit the current HoldSale
  Future<void> getPlaceOrderAdd(OrderDetailList mOrderDetailList);

  /// Delete the current HoldSale
  Future<bool> getPlaceOrderDelete(String sOrderNo);

  /// Delete the current HoldSale
  Future<bool> deleteAllHoldSale();

  Future<void> clearBox();
}
