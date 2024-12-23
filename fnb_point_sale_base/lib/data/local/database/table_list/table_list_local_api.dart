
import '../../../mode/product/get_all_tables/get_all_tables_response.dart';

abstract class TableListLocalApi {

  /// Save Current logged in Table list
  Future<void> save(GetAllTablesResponse mGetAllTablesResponse);

  /// Get Current logged in Tables list
  Future<GetAllTablesResponse?> getTablesListResponse();

  /// Delete the current Tables list
  Future<bool> deleteAllTablesList();

  Future<void> clearBox();
}
