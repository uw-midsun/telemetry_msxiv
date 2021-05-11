import 'package:flutter/material.dart';

class StdColors {
  /// Standard colours for Driver Display.

  // Old colors in previous version.
  static const Color parkState = Color.fromRGBO(255, 103, 20, 1);
  static const Color reverseState = Color.fromRGBO(255, 199, 0, 1);
  static const Color green = Color.fromRGBO(68, 214, 0, 1);
  static const Color error = Color.fromRGBO(255, 77, 77, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);

  // New colors.
  static const Color background = Color.fromRGBO(12, 18, 38, 1);
  static const Color brightBlue = Color.fromRGBO(30, 122, 251, 1);
  static const List<Color> backgroundGradient = [
    Color.fromRGBO(14, 21, 45, 0.45),
    Color.fromRGBO(37, 56, 100, 0.45),
  ];

  // Colors for speedometer.
  static const Color needle = Color.fromRGBO(93, 179, 255, 1);
  static const Color spdOuterOutline = Color.fromRGBO(18, 82, 172, 0.2);
  static const Color spdInnerOutline = Color.fromRGBO(34, 55, 89, 0.4);
  static const Color spdOuterBorder = Color.fromRGBO(34, 55, 89, 0.1);
  static const List<Color> spdBgGradient = [
    Color.fromRGBO(0, 0, 0, 0),
    Color.fromRGBO(28, 38, 12, 0.15),
    Color.fromRGBO(112, 254, 255, 0.0255)
  ];
  static const List<Color> spdActiveGradient = [
    Color.fromRGBO(0, 0, 0, 0),
    Color.fromRGBO(16, 24, 49, 0.35),
    Color.fromRGBO(0, 120, 232, 0.35)
  ];
}
