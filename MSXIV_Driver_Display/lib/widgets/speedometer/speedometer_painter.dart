import 'dart:math';
import 'package:MSXIV_Driver_Display/utils/enums.dart';

import 'package:MSXIV_Driver_Display/constants/brushes.dart';
import 'package:MSXIV_Driver_Display/constants/std_Fonts.dart';
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
    final unitFactor = units.kmFactor;

    // Angles measured from positive x-axis, clockwise direction.
    const startAngle = 2.23;
    const arcLength = 2 * (3 * pi / 2 - startAngle);
    final speedAngle = startAngle + arcLength / TOP_SPEED * speed;

    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.56;

    final center = Offset(size.width / 2, size.height / 2);

    // Bounding rectanges for the speedometer arcs.
    Rect outerBoundingRect =
        Rect.fromCircle(center: center, radius: outerRadius);
    Rect outerBorderRect =
        Rect.fromCircle(center: center, radius: outerRadius - 5);
    Rect innerBoundingRect =
        Rect.fromCircle(center: center, radius: innerRadius);

    // Draw basic arcs.
    canvas.drawArc(outerBorderRect, startAngle, arcLength, false,
        Brushes.getOuterBorderBrush());
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, true,
        Brushes.getBgGradientBrush(center, outerRadius));
    canvas.drawArc(outerBoundingRect, startAngle, speedAngle - startAngle, true,
        Brushes.getActiveGradientBrush(center, outerRadius));
    canvas.drawArc(outerBoundingRect, startAngle, arcLength, false,
        Brushes.getOuterOutlineBrush());

    // Offset is distance between edge of speedometer and tick.
    const tickOffsetFromEdge = 16.0, tickWidth = 3.0;

    // Paint each tick.
    for (double spdIncr = 0; spdIncr <= TOP_SPEED * unitFactor; spdIncr += 2) {
      final tickAngle =
          startAngle + arcLength / (TOP_SPEED * unitFactor) * spdIncr;

      // Determine whether the label/tick should be active.
      final bool isActive =
          (spdIncr / unitFactor) <= speed && spdIncr % 10 == 0;

      // Set tick style according to the speed.
      final double tickLength = spdIncr % 10 == 0 ? 13 : 4;
      Paint brush = Brushes.getTickBrush(tickWidth, isActive);

      // Calculate x,y coordinates for endpoints of each tick.
      final scale =
          (outerRadius - tickOffsetFromEdge - tickWidth / 2) / outerRadius;

      double tickOuterX = scale * outerRadius * cos(tickAngle);
      double tickOuterY = scale * outerRadius * sin(tickAngle);
      double tickInnerX =
          (1 - (tickLength) / (outerRadius - tickOffsetFromEdge - tickWidth)) *
              tickOuterX;
      double tickInnerY =
          (1 - (tickLength) / (outerRadius - tickOffsetFromEdge - tickWidth)) *
              tickOuterY;

      canvas.drawLine(Offset(tickInnerX, tickInnerY) + center,
          Offset(tickOuterX, tickOuterY) + center, brush);

      // Tick Labels every 20 units.
      if (spdIncr % 20 == 0 || (spdIncr % 10 == 0 && units == Units.MPH)) {
        final labelStyle = isActive ? Fonts.sh1 : Fonts.sh1Light;
        final labelPainter = TextPainter(
            text: TextSpan(text: spdIncr.round().toString(), style: labelStyle),
            textDirection: TextDirection.ltr);
        labelPainter.layout();

        // Relative distance (0.0, 1.0) to inner vertex of tick (guesstimate).
        const double scaleDistance = 0.87;

        // Find position for each label, taking into account the size of text.
        var textOffsetX = tickInnerX * scaleDistance - labelPainter.width / 2;
        var textOffsetY = tickInnerY * scaleDistance - labelPainter.height / 2;

        labelPainter.paint(canvas, Offset(textOffsetX, textOffsetY) + center);
      }
    }

    // Thick outer border with gradient.
    canvas.drawArc(
        outerBorderRect,
        startAngle,
        (speedAngle - startAngle) % (2 * pi),
        false,
        Brushes.getOuterGradientBrush(startAngle, speedAngle, outerBorderRect));

    // Inner border with gradient.
    canvas.drawArc(
        innerBoundingRect,
        startAngle,
        arcLength,
        false,
        Brushes.getInnerOutlineBrush(
            startAngle, speedAngle, innerBoundingRect));

    // Needle. Offset on radii required since Flutter's rounded stroke cap will extend too far.
    Offset needleOuter =
        Offset(cos(speedAngle), sin(speedAngle)) * (outerRadius - 2);
    Offset needleInner =
        Offset(cos(speedAngle), sin(speedAngle)) * (innerRadius + 0.5);
    canvas.drawLine(needleInner + center, needleOuter + center,
        Brushes.getNeedleBrush(center, outerRadius));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
