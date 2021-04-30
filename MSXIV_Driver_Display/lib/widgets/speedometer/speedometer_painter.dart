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
    const startAngle = 2.23;
    const arcLength = 2 * (3 * pi / 2 - startAngle);

    double outerRadius = size.width / 2;
    double innerRadius = outerRadius * 0.56;

    var center = Offset(size.width / 2, size.height / 2);

    // bounding rectanges for the speedometer arcs
    Rect outerBoundingRect =
        Rect.fromCircle(center: center, radius: outerRadius);
    Rect innerBoundingRect =
        Rect.fromCircle(center: center, radius: innerRadius);

    // outer dial outline
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, false,
        Brushes.outerOutlineBrush);

    // inner dial outline - shading needs to be adjusted according to speed
    canvas.drawArc(innerBoundingRect, startAngle, arcLength, false,
        Brushes.innerOutlineBrush);

    // dial gradient
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, true,
        Brushes.getGradientBrush(center, outerRadius));

    const Map<int, double> tickWidths = {20: 5, 10: 4, 5: 3, 1: 2};
    //primary dial
    for (double speedIncr = 0;
        speedIncr <= TOP_SPEED * primUnitFactor;
        speedIncr++) {
      var innerScale;
      var brush;

      if (speedIncr % 20 == 0) {
        innerScale = 0.92;
        brush = Brushes.getTickBrush(tickWidths[20]);
      } else if (speedIncr % 10 == 0) {
        innerScale = 0.94;
        brush = Brushes.getTickBrush(tickWidths[10]);
      } else if (speedIncr % 5 == 0) {
        innerScale = 0.96;
        brush = Brushes.getTickBrush(tickWidths[5]);
      } else {
        innerScale = 0.995;
        brush = Brushes.getTickBrush(tickWidths[1]);
      }
      var scale = outerRadius * 0.97;

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

        var textX = outerRadius *
            0.76 *
            (speedIncr % 20 == 0 ? 1 : 1.04) *
            cos(startAngle +
                arcLength / (TOP_SPEED * primUnitFactor) * speedIncr);

        var textY = outerRadius *
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
        Offset(outerRadius * 0.57 * cos(startAngle),
                outerRadius * 0.57 * sin(startAngle - 0.1)) +
            center);

    var xComp = outerRadius * cos(startAngle + arcLength / TOP_SPEED * speed);
    var yComp = outerRadius * sin(startAngle + arcLength / TOP_SPEED * speed);

    var innerX = 0.36 * xComp;
    var innerY = 0.36 * yComp;
    var speedX = 0.94 * xComp;
    var speedY = 0.94 * yComp;

    //needle
    canvas.drawLine(
        Offset(innerX, innerY) + center,
        Offset(speedX, speedY) + center,
        Brushes.getNeedleBrush(center, outerRadius));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
