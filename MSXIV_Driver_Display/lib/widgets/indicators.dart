import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:MSXIV_Driver_Display/utils/enums.dart'
    show LightStatus, RbsStatus;

class Indicators extends StatelessWidget {
  final LightStatus lightStatus;
  final RbsStatus rbsStatus;
  Indicators(this.lightStatus, this.rbsStatus, {Key key}) : super(key: key);
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
          RegenBrakeStatus(rbsStatus),
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

class RegenBrakeStatus extends StatelessWidget {
  final RbsStatus rbsStatus;
  RegenBrakeStatus(this.rbsStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String svgURI = "assets/images/rbs/rbs_warning.svg";
    if (rbsStatus == RbsStatus.On) {
      svgURI = "assets/images/rbs/rbs_active.svg";
    } else if (rbsStatus == RbsStatus.Off) {
      svgURI = "assets/images/rbs/rbs_off.svg";
    }
    return Container(child: SvgPicture.asset(svgURI, width: 32));
  }
}
