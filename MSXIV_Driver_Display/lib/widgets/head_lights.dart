import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
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
