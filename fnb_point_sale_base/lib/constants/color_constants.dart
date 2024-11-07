import 'package:flutter/material.dart';

class ColorConstants {
  static const Color primaryBackgroundColor = Color(0xFFF5F5F5);
  static const Color appEditText = Color(0xFFCACACA);
  static const Color appEditTextHint = Color(0xFFD2D2D2);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color cAppButtonColour = Color(0xFF5591B2);



  ///app Colour
  static const Color cAppColors = Color(0xFF000331);

  static const int _cAppColorsBlueValue = 0xFF000331;

  static const MaterialColor cAppColorsMaterial = MaterialColor(
    _cAppColorsBlueValue,
    <int, Color>{
      50: Color(0xFF11176B),
      100: Color(0xFF0D1260),
      200: Color(0xFF090D52),
      300: Color(0xFF060A49),
      400: Color(0xFF02063D),
      500: Color(_cAppColorsBlueValue),
      600: Color(0xFF000225),
      700: Color(0xFF00021A),
      800: Color(0xFF00021A),
      900: Color(0xFF00021A),
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
