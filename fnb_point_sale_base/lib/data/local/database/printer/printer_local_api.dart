
import 'package:fnb_point_sale_base/data/local/database/printer/model/my_printer.dart';

abstract class PrinterLocalApi {
  /// Save
  Future<void> save(MyPrinter elements);

  /// Get All
  Future<MyPrinter?> getMyPrinter();

  /// Delete
  Future<bool> delete();
}
