
import '../../../mode/product/get_all_payment_type/get_all_payment_type_response.dart';

abstract class PaymentTypeLocalApi {

  /// Save Current logged in PaymentType
  Future<void> save(GetAllPaymentTypeResponse mGetAllPaymentTypeResponse);

  /// Get Current logged in PaymentType
  Future<GetAllPaymentTypeResponse?> getPaymentTypeResponse();

  /// Delete the current PaymentType
  Future<bool> deleteAllPaymentType();

  Future<void> clearBox();
}
