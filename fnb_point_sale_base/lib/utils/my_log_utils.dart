
import 'package:flutter/foundation.dart';



enum LogType {
  RAKYAT,
  AFFIN,
  MBB,
  SALE_MISMATCH,
  NETWORK_ERRORS,
  MBB_PAYSYS,
  AFFIN_PAYSYS
}

class LogContent {
  final String content;
  LogContent(this.content);
}

class MyLogUtils {
  static void logDebug(String message,{LogType? type}) {
    if(type!=null){
      debugPrint('[$type] $message');
    }else {
      debugPrint(message);
    }
  }

  static void logSaleMismatch(String message) {
    MyLogUtils.logDebug('[SaleMismatch] $message');
  }
}
