import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

import '../constants/stdColors.dart';

enum EEDriveOutput {
  EE_DRIVE_OUTPUT_OFF,
  EE_DRIVE_OUTPUT_DRIVE,
  EE_DRIVE_OUTPUT_REVERSE,
  NUM_EE_DRIVE_OUTPUTS,
}

enum DriveStates { Drive, Park, Reverse, Neutral }

extension on DriveStates {
  Color get color {
    switch (this) {
      case (DriveStates.Reverse):
        return StdColors.reverseState;
      case (DriveStates.Neutral):
        return StdColors.error;
      case (DriveStates.Drive):
        return StdColors.green;
      default:
        return StdColors.parkState;
    }
  }

  String get symbol {
    return this.toString().split('.')[1][0];
  }
}

// ignore: must_be_immutable
class DriveState extends StatelessWidget {
  final DriveStates _driveStates;

  DriveState(this._driveStates, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0.0, 0.7),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: _driveStates.color, width: 3),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            _driveStates.symbol,
            style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: _driveStates.color),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
