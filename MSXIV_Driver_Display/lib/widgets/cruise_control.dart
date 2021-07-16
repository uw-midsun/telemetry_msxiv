import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:flutter/material.dart';

class CruiseControl extends StatelessWidget {
  final bool cruiseControl;
  CruiseControl(this.cruiseControl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(28),
      child: Text(cruiseControl ? "CRUISE ON" : "CRUISE OFF", style: Fonts.sh1),
    );
  }
}
