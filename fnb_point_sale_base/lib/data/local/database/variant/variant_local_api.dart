
import '../../../mode/product/get_all_variant/get_all_variant_response.dart';

abstract class VariantLocalApi {

  /// Save Current logged in AllVariant
  Future<void> save(GetAllVariantResponse mGetAllVariantResponse);

  /// Get Current logged in AllVariant
  Future<GetAllVariantResponse?> getVariantResponse();

  /// Delete the current AllVariant
  Future<bool> deleteAllVariant();

  /// Get Current logged in Variant list
  Future<List<VariantListData>?> getVariantList(String sMenuItemIDF);

  Future<void> clearBox();
}
