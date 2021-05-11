import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:flutter/material.dart';
import 'package:MSXIV_Driver_Display/utils/units.dart';

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
