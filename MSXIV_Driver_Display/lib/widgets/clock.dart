import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  Clock(this._timeString);

  final String _timeString;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text(_timeString, style: Fonts.sh2),
            Text(
                " ${TimeOfDay.now().period.toString().split('.')[1].toUpperCase()}",
                style: Fonts.body),
          ],
        ),
        margin: EdgeInsets.only(bottom: 24, right: 24),
        alignment: Alignment.bottomRight);
  }
}
