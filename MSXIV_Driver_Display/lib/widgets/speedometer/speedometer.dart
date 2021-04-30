import 'package:flutter/material.dart';
import 'dart:math';

import './speedometer_painter.dart';
import './digital_speed.dart';

const TOP_SPEED = 150.0;

enum Units { Kmh, MPH }

extension on Units {
  double get kmFactor {
    if (this == Units.Kmh)
      return 1.0;
    else
      return 0.621371;
  }

  double get secFactor {
    if (this == Units.MPH)
      return 1.0;
    else
      return 0.621371;
  }
}

class Speedometer extends StatelessWidget {
  final double speed;
  final Units unit;
  Speedometer(this.speed, this.unit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.8;

    // take the minimum of container width and height
    double minDimension = min(width, height);
    return Container(
        child: Stack(alignment: Alignment(0, 0), children: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.7),
        child: Container(
          width: minDimension,
          height: minDimension,
          child: CustomPaint(
            painter: SpeedometerPainter(speed, unit.kmFactor, unit.secFactor),
          ),
        ),
      ),
      Align(
          alignment: Alignment(0.0, 0.7),
          child: Container(
              width: minDimension,
              height: minDimension,
              child: DigitalSpeed(speed, unit)))
    ]));
  }
}
