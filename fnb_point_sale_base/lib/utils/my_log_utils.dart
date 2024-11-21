
import 'package:flutter/foundation.dart';




class LogContent {
  final String content;
  LogContent(this.content);
}

class MyLogUtils {
  static void logDebug(String message) {
    debugPrint(message);
  }

  static void logSaleMismatch(String message) {
    MyLogUtils.logDebug('[SaleMismatch] $message');
  }
}
