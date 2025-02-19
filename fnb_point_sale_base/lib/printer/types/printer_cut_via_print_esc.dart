import 'dart:async';

import 'package:fnb_point_sale_base/utils/my_log_utils.dart';

Future<bool> cutReceiptViaEsc(String name) async {
  MyLogUtils.logDebug("cutReceiptViaEsc for $name");
  await Future.delayed(const Duration(seconds: 1));
  var result = false;
  return result;
}
