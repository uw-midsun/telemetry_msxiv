import 'package:MSXIV_Driver_Display/widgets/speedometer_painter.dart';
import 'package:flutter/material.dart';

const TOP_SPEED = 150.0;

enum Units { Kmh, MPH }

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
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 100),
        Container(
          width: MediaQuery.of(context).size.width * 0.6666,
          height: MediaQuery.of(context).size.width * 0.6666,
          child: CustomPaint(
            painter: SpeedometerPainter(speed, unit.kmFactor, unit.secFactor),
          ),
        ),
      ],
    );
  }
}
