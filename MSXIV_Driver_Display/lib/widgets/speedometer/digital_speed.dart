import 'package:MSXIV_Driver_Display/constants/stdFonts.dart';
import 'package:flutter/material.dart';

import './speedometer.dart';

extension on Units {
  String get value {
    if (this == Units.Kmh)
      return "km/h";
    else
      return "mph";
  }

  double get kmFactor {
    if (this == Units.Kmh)
      return 1.0;
    else
      return 0.621371;
  }
}

class DigitalSpeed extends StatelessWidget {
  final double speed;
  final Units unit;
  DigitalSpeed(this.speed, this.unit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          (speed * unit.kmFactor).round().toString(),
          style: Fonts.h1,
        ),
        Text(
          unit.value,
          style: Fonts.body,
        ),
      ],
    );
  }
}
