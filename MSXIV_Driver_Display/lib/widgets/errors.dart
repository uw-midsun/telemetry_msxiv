import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

enum ErrorStates { BPSKillSwitch, BPSACKFailed, BMSOverVoltage, MCIOverTemp }

class Errors extends StatelessWidget {
  final List<ErrorStates> errors;

  Errors(this.errors, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 180, left: 14),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (errors.contains(ErrorStates.BPSKillSwitch))
            ErrorItem("BPS", "Kill Switch"),
          if (errors.contains(ErrorStates.BPSACKFailed))
            ErrorItem("BPS", "ACK Failed"),
          if (errors.contains(ErrorStates.BMSOverVoltage))
            ErrorItem("BMS", "Over Voltage"),
          if (errors.contains(ErrorStates.MCIOverTemp))
            ErrorItem("MCI", "Over Temp"),
        ],
      ),
    );
  }
}

class ErrorItem extends StatelessWidget {
  final String part, name;
  ErrorItem(
    this.part,
    this.name,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 100,
      child: Column(
        children: <Widget>[
          Text(part,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: stdColors.error)),
          Text(
            name,
            style: TextStyle(color: stdColors.error),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
