import 'dart:math';
import './speedometer.dart' show Units;

import 'package:MSXIV_Driver_Display/constants/brushes.dart';
import 'package:MSXIV_Driver_Display/constants/stdFonts.dart';
import 'package:flutter/material.dart';

// in km/h
const TOP_SPEED = 140;

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

    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.56;

    final center = Offset(size.width / 2, size.height / 2);

    // bounding rectanges for the speedometer arcs
    Rect outerBoundingRect =
        Rect.fromCircle(center: center, radius: outerRadius);
    Rect outerBorderRect =
        Rect.fromCircle(center: center, radius: outerRadius - 5);
    Rect innerBoundingRect =
        Rect.fromCircle(center: center, radius: innerRadius);

    // thick outer border
    canvas.drawArc(outerBorderRect, startAngle, arcLength, false,
        Brushes.getOuterBorderBrush());

    // dial gradient
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, true,
        Brushes.getGradientBrush(center, outerRadius));

    // outer dial outline
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, false,
        Brushes.getOuterOutlineBrush());

    const tickWidth = 3.0;
    const tickOffsetFromEdge = 16.0;

    // paint each tick
    for (double speedIncr = 0;
        speedIncr <= TOP_SPEED * unitFactor;
        speedIncr += 2) {
      var tickLength;
      var brush;
      final tickAngle =
          startAngle + arcLength / (TOP_SPEED * unitFactor) * speedIncr;

      // set tick lengths according to the speed
      if (speedIncr % 10 == 0) {
        tickLength = 16;
        brush = Brushes.getTickBrush(tickWidth, speedIncr < speed);
      } else {
        tickLength = 8;
        brush = Brushes.getTickBrush(tickWidth, false);
      }

      // calculate x,y coordinates for endpoints of each tick
      final scale = (outerRadius - tickOffsetFromEdge) / outerRadius;

      var tickOuterX = scale * outerRadius * cos(tickAngle);
      var tickOuterY = scale * outerRadius * sin(tickAngle);

      var tickInnerX =
          (1 - (tickLength) / (outerRadius - tickOffsetFromEdge)) * tickOuterX;
      var tickInnerY =
          (1 - (tickLength) / (outerRadius - tickOffsetFromEdge)) * tickOuterY;

      // paint tick using calculated coordinates
      canvas.drawLine(Offset(tickInnerX, tickInnerY) + center,
          Offset(tickOuterX, tickOuterY) + center, brush);

      // Tick Labels every 20 units
      if (speedIncr % 20 == 0) {
        // Initialize textpainter object with style + text
        final labelPainter = TextPainter(
            text:
                TextSpan(text: speedIncr.round().toString(), style: Fonts.sh1),
            textDirection: TextDirection.ltr);
        labelPainter.layout();

        // relative distance (0.0, 1.0) to inner vertex of tick (guesstimate)
        const double scaleDistance = 0.87;

        // Find position for each label, taking into account the size of text
        var textOffsetX = tickInnerX * scaleDistance - labelPainter.width / 2;
        var textOffsetY = tickInnerY * scaleDistance - labelPainter.height / 2;

        // display the tick label
        labelPainter.paint(canvas, Offset(textOffsetX, textOffsetY) + center);
      }
    }
    final speedAngle = startAngle + arcLength / TOP_SPEED * speed;
     
    // thick outer border with gradient
    canvas.drawArc(
        outerBorderRect,
        startAngle,
        (speedAngle - startAngle) % (2 * pi),
        false,
        Brushes.getNeedleBorderBrush(startAngle, speedAngle, outerBorderRect));

    // inner border with gradient
    canvas.drawArc(
        innerBoundingRect,
        startAngle,
        arcLength,
        false,
        Brushes.getInnerNeedleBrush(startAngle, speedAngle, innerBoundingRect));

    // needle

    var innerX = outerRadius * cos(speedAngle);
    var innerY = outerRadius * sin(speedAngle);
    var speedX = innerRadius * cos(speedAngle);
    var speedY = innerRadius * sin(speedAngle);

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
