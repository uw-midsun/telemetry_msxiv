
import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  Clock(this._timeString);

  final String _timeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_timeString,
              style: TextStyle(color: Colors.white, fontSize: 24)),
          Text(
              " ${TimeOfDay.now().period.toString().split('.')[1].toUpperCase()}",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
      padding: EdgeInsets.only(top: 15, right: 20),
    );
  }
}