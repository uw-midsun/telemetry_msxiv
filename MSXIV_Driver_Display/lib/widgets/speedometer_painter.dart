import 'dart:math';
import 'dart:ui' as ui;

import 'package:MSXIV_Driver_Display/constants/brushes.dart';
import 'package:flutter/material.dart';

const TOP_SPEED = 150;

class SpeedometerPainter extends CustomPainter {
  double speed;
  double primUnitFactor;
  double secUnitFactor;

  SpeedometerPainter(this.speed, this.primUnitFactor, this.secUnitFactor);

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    const arcLength = 6 * pi / 4;
    const startAngle = 3 * pi / 4;
    double radius = min(centerX, centerY);

    Rect boudingRect = Rect.fromCircle(center: center, radius: radius);

    // dial outline
    canvas.drawArc(
        boudingRect, startAngle, arcLength, false, Brushes.outlineBrush);

    // dial gradient
    canvas.drawArc(boudingRect, startAngle, arcLength, true,
        Brushes.getGradientBrush(center, radius));

    //primary dial
    for (double speedIncr = 0;
        speedIncr <= TOP_SPEED * primUnitFactor;
        speedIncr++) {
      var innerScale;
      var brush;

      if (speedIncr % 20 == 0) {
        innerScale = 0.92;
        brush = Brushes.twentyTick;
      } else if (speedIncr % 10 == 0) {
        innerScale = 0.94;
        brush = Brushes.tenTick;
      } else if (speedIncr % 5 == 0) {
        innerScale = 0.96;
        brush = Brushes.fiveTick;
      } else {
        innerScale = 0.995;
        brush = Brushes.oneTick;
      }
      var scale = radius * 0.97;

      var outerX = scale *
          cos(startAngle +
              arcLength / (TOP_SPEED * primUnitFactor) * speedIncr);
      var outerY = scale *
          sin(startAngle +
              arcLength / (TOP_SPEED * primUnitFactor) * speedIncr);

      var innerX = innerScale * outerX;
      var innerY = innerScale * outerY;

      canvas.drawLine(Offset(innerX, innerY) + center,
          Offset(outerX, outerY) + center, brush);

      // 20 speed labels
      if (speedIncr % 10 == 0) {
        final textStyle = ui.TextStyle(
          color: Colors.white.withOpacity(primUnitFactor == 1
              ? speedIncr % 20 == 0
                  ? 1
                  : 0
              : 1),
          fontSize: speedIncr % 20 == 0 ? 28 : 24,
          fontWeight: FontWeight.bold,
        );

        final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle())
          ..pushStyle(textStyle)
          ..addText(speedIncr.round().toString());
        final constraints = ui.ParagraphConstraints(width: 300);
        final paragraph = paragraphBuilder.build();
        paragraph.layout(constraints);

        var textX = radius *
            0.76 *
            (speedIncr % 20 == 0 ? 1 : 1.04) *
            cos(startAngle +
                arcLength / (TOP_SPEED * primUnitFactor) * speedIncr);

        var textY = radius *
            0.82 *
            (speedIncr % 20 == 0 ? 1 : 1.04) *
            sin(startAngle +
                arcLength / (TOP_SPEED * primUnitFactor) * speedIncr);

        final offset =
            Offset(textX - (25 * primUnitFactor), textY - 12) + center;
        canvas.drawParagraph(paragraph, offset);
      }
    }

    //secondary dial
    // for (double speedIncr = 0;
    //     speedIncr <= TOP_SPEED * secUnitFactor;
    //     speedIncr += primUnitFactor == 1 ? 10 : 20) {
    //   var innerScale = 0.95;
    //   var scale = radius * 0.45;
    //   var brush = Brushes.innerTicks;

    //   var outerX = scale *
    //       cos(startAngle + arcLength / (TOP_SPEED * secUnitFactor) * speedIncr);
    //   var outerY = scale *
    //       sin(startAngle + arcLength / (TOP_SPEED * secUnitFactor) * speedIncr);

    //   var innerX = innerScale * outerX;
    //   var innerY = innerScale * outerY;

    //   //secondary dial ticks
    //   canvas.drawLine(Offset(innerX, innerY) + center,
    //       Offset(outerX, outerY) + center, brush);

    //   final textStyle = ui.TextStyle(
    //     color: Colors.grey,
    //     fontSize: 20,
    //     fontWeight: FontWeight.bold,
    //   );

    //   final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle())
    //     ..pushStyle(textStyle)
    //     ..addText(speedIncr.round().toString());
    //   final constraints = ui.ParagraphConstraints(width: 300);
    //   final paragraph = paragraphBuilder.build();
    //   paragraph.layout(constraints);

    //   var textX = centerX +
    //       radius *
    //           .52 *
    //           cos(startAngle +
    //               arcLength / (TOP_SPEED * secUnitFactor) * speedIncr);

    //   var textY = centerY +
    //       radius *
    //           0.52 *
    //           sin(startAngle +
    //               arcLength / (TOP_SPEED * secUnitFactor) * speedIncr);

    //   final offset = Offset(textX - 11, textY - 11);
    //   canvas.drawParagraph(paragraph, offset);
    // }

    //secondar unit label in bottom left
    final textStyle = ui.TextStyle(
      color: Colors.grey,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle())
      ..pushStyle(textStyle)
      ..addText(primUnitFactor == 1 ? "MPH" : "Km/h");
    final constraints = ui.ParagraphConstraints(width: 40);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    canvas.drawParagraph(
        paragraph,
        Offset(radius * 0.57 * cos(startAngle),
                radius * 0.57 * sin(startAngle - 0.1)) +
            center);

    var xComp = radius * cos(startAngle + arcLength / TOP_SPEED * speed);
    var yComp = radius * sin(startAngle + arcLength / TOP_SPEED * speed);

    var innerX = 0.36 * xComp;
    var innerY = 0.36 * yComp;
    var speedX = 0.94 * xComp;
    var speedY = 0.94 * yComp;

    //needle
    canvas.drawLine(
        Offset(innerX, innerY) + center,
        Offset(speedX, speedY) + center,
        Brushes.getNeedleBrush(center, radius));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
