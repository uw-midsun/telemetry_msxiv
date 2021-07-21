import 'package:flutter/material.dart';
import 'package:MSXIV_Driver_Display/utils/enums.dart';
import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';

// ignore: must_be_immutable
const driveStateOrder = [
  DriveStates.Reverse,
  DriveStates.Neutral,
  DriveStates.Drive
];

class DriveState extends StatelessWidget {
  final DriveStates _driveStates;

  DriveState(this._driveStates, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Text> textArray = [];
    for (final driveState in driveStateOrder) {
      if (_driveStates == driveState) {
        textArray.add(Text(driveState.symbol, style: Fonts.h3));
      } else {
        textArray.add(Text(driveState.symbol, style: Fonts.sh1Light));
      }
    }

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 73,
        alignment: Alignment(0.0, 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: textArray,
        ),
      ),
    );
  }
}
