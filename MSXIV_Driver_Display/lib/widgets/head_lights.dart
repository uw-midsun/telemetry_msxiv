import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

enum LightStatus { Off, LowBeam, HighBeams, FogLights, DaytimeRunning }

class HeadLights extends StatelessWidget {
  final LightStatus lightStatus;
  HeadLights(this.lightStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 30, bottom: 5),
      child: lightStatus == LightStatus.Off
          ? Text(
              "Lights Off",
              style: TextStyle(fontSize: 24, color: stdColors.reverseState),
            )
          : Image(
              height: 50,
              image: AssetImage(
                  'assets/images/HeadLights${lightStatus.toString().split('.')[1]}.png'),
              color: stdColors.reverseState,
            ),
    );
  }
}
