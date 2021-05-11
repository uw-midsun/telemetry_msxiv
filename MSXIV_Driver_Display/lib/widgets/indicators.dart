import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:flutter/material.dart';
import 'package:MSXIV_Driver_Display/utils/enums.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class Indicators extends StatelessWidget {
  final LightStatus lightStatus;
  final BrakeStatus brakeStatus;
  Indicators(this.lightStatus, this.brakeStatus, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeadLights(lightStatus),
          Brakes(brakeStatus),
        ],
      ),
    );
  }
}

class HeadLights extends StatelessWidget {
  final LightStatus lightStatus;
  HeadLights(this.lightStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svgURI = lightStatus == LightStatus.DaytimeRunning
        ? "assets/images/drl/drl_on.svg"
        : "assets/images/drl/drl_off.svg";
    return Container(
      margin: EdgeInsets.only(right: 24),
      child: SvgPicture.asset(svgURI),
    );
  }
}

class Brakes extends StatelessWidget {
  final BrakeStatus brakeStatus;
  Brakes(this.brakeStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String svgURI = "assets/images/rbs/rbs_warning.svg";
    if (brakeStatus == BrakeStatus.On) {
      svgURI = "assets/images/rbs/rbs_active.svg";
    } else if (brakeStatus == BrakeStatus.Off) {
      svgURI = "assets/images/rbs/rbs_off.svg";
    }
    return Container(child: SvgPicture.asset(svgURI, height: 32, width: 32));
  }
}
