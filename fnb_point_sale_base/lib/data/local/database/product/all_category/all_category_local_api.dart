
import '../../../../mode/product/get_all_category/get_all_category_response.dart';

abstract class AllCategoryLocalApi {

  /// Save Current logged in AllCategory
  Future<void> saveAllCategoryResponse(GetAllCategoryResponse allCategoryResponse);

  /// Get Current logged in AllCategory
  Future<GetAllCategoryResponse?> getAllCategoryResponse();

  /// Delete the current AllCategory
  Future<bool> deleteAllCategory();

  Future<void> clearBox();
}
