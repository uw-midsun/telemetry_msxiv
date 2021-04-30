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
  double speed;
  final Units units;
  DigitalSpeed(this.speed, this.units, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    speed = speed * units.kmFactor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          speed.round().toString(),
          style: TextStyle(
              fontSize: 96,
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              height: 1.5),
        ),
        Text(
          units.value,
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontFamily: 'din1451'),
        ),
      ],
    );
  }
}
