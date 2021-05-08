import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:flutter/material.dart';

enum EELightType {
  EE_LIGHT_TYPE_DRL,
  EE_LIGHT_TYPE_BRAKES,
  EE_LIGHT_TYPE_STROBE,
  EE_LIGHT_TYPE_SIGNAL_RIGHT,
  EE_LIGHT_TYPE_SIGNAL_LEFT,
  EE_LIGHT_TYPE_SIGNAL_HAZARD,
  EE_LIGHT_TYPE_HIGH_BEAMS,
  EE_LIGHT_TYPE_LOW_BEAMS,
  NUM_EE_LIGHT_TYPES,
}

enum EELightState {
  EE_LIGHT_STATE_OFF,
  EE_LIGHT_STATE_ON,
  NUM_EE_LIGHT_STATES,
}

enum LightStatus { Off, LowBeam, HighBeams, FogLights, DaytimeRunning }

class HeadLights extends StatelessWidget {
  final LightStatus lightStatus;
  HeadLights(this.lightStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(24),
      child: lightStatus == LightStatus.Off
          ? Text(
              "Lights Off",
              style: TextStyle(fontSize: 24, color: StdColors.reverseState),
            )
          : Image(
              height: 50,
              image: AssetImage(
                  'assets/images/old/HeadLights${lightStatus.toString().split('.')[1]}.png'),
              color: StdColors.reverseState,
            ),
    );
  }
}
