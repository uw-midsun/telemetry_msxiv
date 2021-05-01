import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

class Brushes {
  static final outerOutlineBrush = Paint()
    ..color = Color.fromRGBO(18, 82, 172, 0.2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.butt;

  static final outerBorderBrush = Paint()
    ..color = Color.fromRGBO(34, 55, 89, 0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..strokeCap = StrokeCap.butt;

  static final innerOutlineBrush = Paint()
    ..color = Color.fromRGBO(34, 55, 89, 0.4)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;

  static Paint getGradientBrush(Offset center, double radius) {
    var boundingRect = Rect.fromCircle(center: center, radius: radius);
    const List<Color> colors = [
      Color.fromRGBO(28, 38, 12, 0.15),
      Color.fromRGBO(112, 254, 255, 0.0255)
    ];
    const List<double> stops = [0.6458, 1.0];

    return Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(colors: colors, stops: stops)
          .createShader(boundingRect)
      ..strokeCap = StrokeCap.square;
  }

  static Paint getTickBrush(double strokeWidth, bool isLit) {
    var opacity = isLit ? 1.0 : 0.5;

    return Paint()
      ..color = Color.fromRGBO(255, 255, 255, opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  static Paint getNeedleBrush(Offset center, double radius) {
    return Paint()
      ..shader = RadialGradient(colors: [Colors.white, StdColors.needle])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
  }
}
