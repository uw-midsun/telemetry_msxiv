import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Brushes {
  // Thin outer outline of speedometer
  static Paint getOuterOutlineBrush() {
    return Paint()
      ..color = StdColors.spdOuterOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt;
  }

  // Thick outer border of speedometer
  static Paint getOuterBorderBrush() {
    return Paint()
      ..color = StdColors.spdOuterBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.butt;
  }

  // Subtle background gradient of speedometer
  static Paint getBgGradientBrush(Offset center, double radius) {
    var boundingRect = Rect.fromCircle(center: center, radius: radius);
    const List<Color> colors = StdColors.spdBgGradient;
    const List<double> stops = [0.56, 0.6458, 1.0];

    return Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(colors: colors, stops: stops)
          .createShader(boundingRect)
      ..strokeCap = StrokeCap.square;
  }

  // Active region gradient brush
  static Paint getActiveGradientBrush(Offset center, double radius) {
    var boundingRect = Rect.fromCircle(center: center, radius: radius);
    const List<Color> colors = StdColors.spdActiveGradient;
    const List<double> stops = [0.56, 0.6354, 1.0];

    return Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(colors: colors, stops: stops)
          .createShader(boundingRect)
      ..strokeCap = StrokeCap.square;
  }

  // Brush for ticks
  static Paint getTickBrush(double strokeWidth, bool isLit) {
    var opacity = isLit ? 1.0 : 0.4;

    return Paint()
      ..color = Color.fromRGBO(255, 255, 255, opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  // brush for speedometer needle
  static Paint getNeedleBrush(Offset center, double radius) {
    return Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  // angle for needle gradient stops
  static const double gradientAngle = pi / 4;

  static Paint getOuterGradientBrush(
      double startAngle, double endAngle, Rect boundingRect) {
    final List<Color> colors = StdColors.spdBorderGradient;
    final List<double> stops = [
      (endAngle - gradientAngle - startAngle) / (2 * pi),
      (endAngle - startAngle) / (2 * pi)
    ];
    print(stops);

    return Paint()
      ..shader = SweepGradient(
              colors: colors,
              stops: stops,
              startAngle: startAngle - 0.01,
              endAngle: startAngle + 2 * pi,
              tileMode: TileMode.repeated)
          .createShader(boundingRect)
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.butt;
  }

  // inner outline of speedometer
  static Paint getInnerOutlineBrush(
      double startAngle, double endAngle, Rect boundingRect) {
    final List<Color> colors = StdColors.spdInnerGradient;
    final List<double> stops = [
      (endAngle - gradientAngle - startAngle) / (2 * pi),
      (endAngle - startAngle) / (2 * pi),
      (endAngle + gradientAngle - startAngle) / (2 * pi)
    ];

    return Paint()
      ..shader = SweepGradient(
              colors: colors,
              stops: stops,
              startAngle: startAngle - 0.01,
              endAngle: startAngle + 2 * pi,
              tileMode: TileMode.repeated)
          .createShader(boundingRect)
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }
}
