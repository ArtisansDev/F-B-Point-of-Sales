import 'dart:convert';
import 'dart:typed_data';

import '../utils/my_log_utils.dart';

//ASCII Decimal Values
const startOfText = 2;
const endOfText = 3;

//https://www.eso.org/~ndelmott/ascii.html - ASCII Lists
String getLrc(String input) {
  final bytes = utf8.encode(input);
  final byte = bytes.reduce((o, i) => o ^= i);
  var asciiCharacterOfLrcValue = String.fromCharCode(byte);
  var hexValue = byte.toRadixString(16);

  MyLogUtils.logDebug(
      "getLrc of $input is : $byte  & asciiCharacterOfLrcValue: $asciiCharacterOfLrcValue"
      " & hex value: $hexValue");

  return asciiCharacterOfLrcValue;
}

String convertUInt8ListToString(Uint8List input) {
  String value = "";
  for (var element in input) {
    var charCode = String.fromCharCode(element);
    charCode = getCustomAsciiCharCode(element, charCode);
    value = "$value$charCode";
  }
  return value;
}

Uint8List convertStringToUInt8List(String input) {
  MyLogUtils.logDebug("convertStringToUInt8List of  input : $input");
  List<int> list = utf8.encode(input);
  var result = Uint8List.fromList(list);
  MyLogUtils.logDebug("convertStringToUInt8List of $input is : $result");
  return result;
}

//https://www.eso.org/~ndelmott/ascii.html - ASCII Lists
String getCustomAsciiCharCode(int code, String defaultValue) {
  if (code == 0) {
    return "NULL";
  }
  if (code == 1) {
    return "SOH";
  }
  if (code == 2) {
    return "<STX>";
  }
  if (code == 3) {
    return "<ETX>";
  }
  if (code == 4) {
    return "EOT";
  }
  if (code == 5) {
    return "ENQ";
  }
  if (code == 6) {
    return "ACK";
  }
  if (code == 21) {
    return "NAK";
  }
  return defaultValue;
}

bool isStatusCodeInResponseSuccess(String decimalValue) {
  return decimalValue == "00";
}

List<int> convertIntToBytes(int number, int byteLen ) {

  ByteData byteData = ByteData(byteLen);

  byteData.setInt16(0, number, Endian.little); // Use Endian.little for little-endian byte order

  // Access the bytes as a list
  List<int> bytes = [
    byteData.getUint8(0),
    byteData.getUint8(1),
  ];

  return bytes; // Output: [255, 0] for the example value 255
}

///affin bank

String affinBankConvertUInt8ListToString(Uint8List input) {
  String value = "";
  for (var element in input) {
    var charCode = String.fromCharCode(element);
    charCode = affinBankGetCustomAsciiCharCode(element, charCode);
    value = "$value$charCode";
  }
  return value;
}

//https://www.eso.org/~ndelmott/ascii.html - ASCII Lists
String affinBankGetCustomAsciiCharCode(int code, String defaultValue) {
  if (code == 0) {
    return " ";
  }
  if (code == 1) {
    return "";
  }
  if (code == 2) {
    return "";
  }
  if (code == 3) {
    return "";
  }
  if (code == 4) {
    return "";
  }
  if (code == 5) {
    return "";
  }
  if (code == 6) {
    return "ACK";
  }
  if (code == 16) {
    return "";
  }
  if (code == 18) {
    return "";
  }
  if (code == 21) {
    return "";
  }

  if (code == 22) {
    return "";
  }

  if (code == 28) {
    return "FS";
  }

  if (code == 30) {
    return "RS";
  }
  return defaultValue;
}

///rakyet bank

String rakyetBankConvertUInt8ListToString(Uint8List input) {
  String value = "";
  for (var element in input) {
    var charCode = String.fromCharCode(element);
    charCode = rakyetBankGetCustomAsciiCharCode(element, charCode);
    value = "$value$charCode";
  }
  return value;
}

//https://www.eso.org/~ndelmott/ascii.html - ASCII Lists
String rakyetBankGetCustomAsciiCharCode(int code, String defaultValue) {
  if (code == 0) {
    return " ";
  }
  if (code == 1) {
    return "";
  }
  if (code == 2) {
    return "";
  }
  if (code == 3) {
    return "";
  }
  if (code == 4) {
    return "";
  }
  if (code == 5) {
    return "";
  }
  if (code == 6) {
    return "ACK";
  }
  if (code == 16) {
    return "";
  }
  if (code == 18) {
    return "";
  }
  if (code == 21) {
    return "";
  }

  if (code == 22) {
    return "";
  }

  if (code == 28) {
    return "FS";
  }

  if (code == 30) {
    return "RS";
  }
  return defaultValue;
}



