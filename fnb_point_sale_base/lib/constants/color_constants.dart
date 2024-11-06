import 'package:flutter/material.dart';

class ColorConstants {
  static const Color primaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color appEditText = Color(0xFFCACACA);
  static const Color appEditTextHint = Color(0xFF424242);
  static const Color black = Colors.black;



  ///app Colour
  static const Color cAppColors = Color(0xFF27BAE3);

  static const int _cAppColorsBlueValue = 0xFF27BAE3;

  static const MaterialColor cAppColorsMaterial = MaterialColor(
    _cAppColorsBlueValue,
    <int, Color>{
      50: Color(0xFF6FE9FF),
      100: Color(0xFF5FE7FF),
      200: Color(0xFF50E3FD),
      300: Color(0xFF43D8F3),
      400: Color(0xFF38CDE8),
      500: Color(_cAppColorsBlueValue),
      600: Color(0xFF27C0DC),
      700: Color(0xFF20BCD9),
      800: Color(0xFF1AB8D5),
      900: Color(0xFF14B3D0),
    },
  );

}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
