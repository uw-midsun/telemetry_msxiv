import 'package:flutter/material.dart';
import 'package:MSXIV_Driver_Display/utils/errors.dart';
import 'package:MSXIV_Driver_Display/constants/std_colors.dart';

class Fonts {
  // center speedometer number
  static final h1 = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 96,
      height: 1.5,
      fontWeight: FontWeight.bold);

  // recommended speed
  static final h2 = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 32,
      height: 1.40,
      fontWeight: FontWeight.w500);

  // Drive State
  static final h3 = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 26,
      height: 1.40,
      fontWeight: FontWeight.bold);

  // Cruise Control, Speedometer Markings
  static final sh1 = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 18,
      height: 1.40,
      fontWeight: FontWeight.bold);

  static final sh1Light = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      fontFamily: "Roboto",
      fontSize: 18,
      height: 1.40,
      fontWeight: FontWeight.bold);

  // Time, range, hazards
  static final sh2 = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 20,
      height: 1.40,
      fontWeight: FontWeight.bold);

  // Range, Time
  static final body = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 16,
      height: 1.40,
      fontWeight: FontWeight.normal);

  // Rec. speed, hazards
  static final caption = TextStyle(
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 12,
      height: 1.40,
      fontWeight: FontWeight.normal);

  static TextStyle getErrorHeader(ErrorSeverity severity) {
    return TextStyle(
        color: severity == ErrorSeverity.Dangerous
            ? StdColors.error
            : StdColors.warning,
        fontFamily: "Roboto",
        fontSize: 20,
        height: 1.40,
        fontWeight: FontWeight.bold);
  }

  static TextStyle getErrorCaption(ErrorSeverity severity) {
    return TextStyle(
        color: severity == ErrorSeverity.Dangerous
            ? StdColors.error
            : StdColors.warning,
        fontFamily: "Roboto",
        fontSize: 12,
        height: 1.40,
        fontWeight: FontWeight.normal);
  }
}
