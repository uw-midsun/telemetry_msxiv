import 'dart:math';
import './speedometer.dart' show Units;

import 'package:MSXIV_Driver_Display/constants/brushes.dart';
import 'package:MSXIV_Driver_Display/constants/stdFonts.dart';
import 'package:flutter/material.dart';

// in km/h
const TOP_SPEED = 150;

class SpeedometerPainter extends CustomPainter {
  double speed;
  double unitFactor;
  Units units;

  SpeedometerPainter(this.speed, this.units);

  @override
  void paint(Canvas canvas, Size size) {
    // factor from km -> specified unit
    unitFactor = this.units == Units.Kmh ? 1 : 0.621371;

    // startAngle measured from positive x-axis, clockwise direction
    const startAngle = 2.23;
    const arcLength = 2 * (3 * pi / 2 - startAngle);

    double outerRadius = size.width / 2;
    double innerRadius = outerRadius * 0.56;

    final center = Offset(size.width / 2, size.height / 2);

    // bounding rectanges for the speedometer arcs
    Rect outerBoundingRect =
        Rect.fromCircle(center: center, radius: outerRadius);
    Rect outerBorderRect =
        Rect.fromCircle(center: center, radius: outerRadius - 5);
    Rect innerBoundingRect =
        Rect.fromCircle(center: center, radius: innerRadius);

    // inner dial outline - TODO: shading needs to be adjusted according to speed
    canvas.drawArc(innerBoundingRect, startAngle, arcLength, false,
        Brushes.innerOutlineBrush);

    // thick outer border
    canvas.drawArc(outerBorderRect, startAngle, arcLength, false,
        Brushes.outerBorderBrush);

    // dial gradient
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, true,
        Brushes.getGradientBrush(center, outerRadius));

    // outer dial outline
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, false,
        Brushes.outerOutlineBrush);

    const tickWidth = 3.0;
    const tickOffsetFromEdge = 16.0;

    //primary dial
    for (double speedIncr = 0;
        speedIncr <= TOP_SPEED * unitFactor;
        speedIncr += 2) {
      var tickLength;
      var brush;

      // set tick lengths according to their position
      if (speedIncr % 10 == 0) {
        tickLength = 16;
        brush = Brushes.getTickBrush(tickWidth, false);
      } else {
        tickLength = 8;
        brush = Brushes.getTickBrush(tickWidth, false);
      }

      final scale = (outerRadius - tickOffsetFromEdge) / outerRadius;

      var outerX = scale *
          outerRadius *
          cos(startAngle + arcLength / (TOP_SPEED * unitFactor) * speedIncr);
      var outerY = scale *
          outerRadius *
          sin(startAngle + arcLength / (TOP_SPEED * unitFactor) * speedIncr);

      var innerX =
          (1 - (tickLength) / (outerRadius - tickOffsetFromEdge)) * outerX;
      var innerY =
          (1 - (tickLength) / (outerRadius - tickOffsetFromEdge)) * outerY;

      canvas.drawLine(Offset(innerX, innerY) + center,
          Offset(outerX, outerY) + center, brush);

      // 20 speed labels
      if (speedIncr % 10 == 0) {
        // Initialize textpainter object with style + text
        final tickLabelStyle = Fonts.sh1;
        final tickLabelSpan =
            TextSpan(text: speedIncr.round().toString(), style: tickLabelStyle);
        final labelPainter =
            TextPainter(text: tickLabelSpan, textDirection: TextDirection.ltr);
        labelPainter.layout();

        // calculate the x,y position of the tick label
        var textX = outerRadius *
                0.76 *
                cos(startAngle +
                    arcLength / (TOP_SPEED * unitFactor) * speedIncr) +
            10;

        var textY = outerRadius *
            0.82 *
            sin(startAngle + arcLength / (TOP_SPEED * unitFactor) * speedIncr);

        final offset = Offset(textX - (25 * unitFactor), textY - 12) + center;
        labelPainter.paint(canvas, offset);
      }
    }

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
