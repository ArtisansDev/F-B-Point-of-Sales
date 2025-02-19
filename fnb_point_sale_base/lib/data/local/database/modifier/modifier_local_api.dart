
import '../../../mode/product/get_all_menu_item/menu_item_response.dart';
import '../../../mode/product/get_all_modifier/get_all_modifier_response.dart';

abstract class ModifierLocalApi {

  /// Save Current logged in AllModifier
  Future<void> save(GetAllModifierResponse mGetAllModifierResponse);

  /// Get Current logged in AllModifier
  Future<GetAllModifierResponse?> getModifierResponse();

  /// Get Current logged in Modifier list
  Future<List<ModifierList>?> getModifierList(List<ModifierIDs> sModifierIDs);

  /// Delete the current AllModifier
  Future<bool> deleteAllModifier();

  Future<void> clearBox();
}
