
import '../../../mode/customer/get_all_customer/get_all_customer_response.dart';

abstract class CustomerLocalApi {

  /// Save Current logged in Customer
  Future<void> save(GetAllCustomerResponse mGetAllCustomerResponse);

  /// Get Current logged in Customer
  Future<GetAllCustomerResponse?> getAllCustomerResponse();

  /// Delete the current Customer
  Future<bool> deleteAllCustomerResponse();

  Future<void> clearBox();
}
