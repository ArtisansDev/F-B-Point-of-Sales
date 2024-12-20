
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';

abstract class MenuItemLocalApi {

  /// Save Current logged in MenuItem
  Future<void> save(MenuItemResponse mMenuItemResponse);

  /// Get Current logged in MenuItem
  Future<MenuItemResponse?> getMenuItemResponse();

  /// Get Current logged in MenuItem
  Future<List<MenuItemData>?> getMenuItemData(String categoryIDP);

  /// Delete the current MenuItem
  Future<bool> deleteAllMenuItem();

  Future<void> clearBox();
}
