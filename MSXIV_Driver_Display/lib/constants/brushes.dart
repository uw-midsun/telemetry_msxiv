import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

class Brushes {
  static final outlineBrush = Paint()
    ..color = Color.fromRGBO(250, 250, 250, 1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6
    ..strokeCap = StrokeCap.square;

  static final twentyTick = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5
    ..strokeCap = StrokeCap.square;
  static final tenTick = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.square;
  static final fiveTick = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.square;

  static final oneTick = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.square;

  static final innerTicks = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.square; 

  static Paint getNeedleBrush(Offset center, double radius) {
    return Paint()
      ..shader = RadialGradient(colors: [Colors.white, stdColors.needle])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
  }
}
