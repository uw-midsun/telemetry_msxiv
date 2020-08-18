import 'package:MSXIV_Driver_Display/widgets/speedometer.dart';
import 'package:flutter/material.dart';

import 'speedometer.dart';

extension on Units {
  String get value {
    if (this == Units.Kmh)
      return "Km/h";
    else
      return "MPH";
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
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              speed.round().toString(),
              style: TextStyle(
                  fontSize: 160, color: Colors.white, fontFamily: 'din1451'),
            ),
            Text(
                units.value,
                style: TextStyle(
                    fontSize: 40, color: Colors.white, fontFamily: 'din1451'),
              ),
         
          ],
      ),
    );
  }
}
