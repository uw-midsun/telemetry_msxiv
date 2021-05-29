import 'package:flutter/material.dart';
import 'package:MSXIV_Driver_Display/utils/enums.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Indicators extends StatelessWidget {
  final LightStatus lightStatus;
  final RbsStatus brakeStatus;
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
  final RbsStatus brakeStatus;
  Brakes(this.brakeStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String svgURI = "assets/images/rbs/rbs_warning.svg";
    if (brakeStatus == RbsStatus.On) {
      svgURI = "assets/images/rbs/rbs_active.svg";
    } else if (brakeStatus == RbsStatus.Off) {
      svgURI = "assets/images/rbs/rbs_off.svg";
    }
    return Container(child: SvgPicture.asset(svgURI, height: 32, width: 32));
  }
}
