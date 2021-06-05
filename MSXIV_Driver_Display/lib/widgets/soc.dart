import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:MSXIV_Driver_Display/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const LOW_CHARGE = 0.2;
const double WIDTH = 50;
const double MAX_DISTANCE = 1000.0;
const double TIME_TO_FULL = 3.0;
const int PRECISION = 1;

/// Parent state of charge widget.
class SOC extends StatelessWidget {
  final double chargePercent;
  final double timeToFull;
  final double distanceToEmpty;
  final ChargeType chargeType;
  final Units units;
  SOC(this.chargePercent, this.chargeType,
      {this.timeToFull, this.distanceToEmpty, this.units, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.0),
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BatterySymbol(
            chargePercent: chargePercent,
            charging: chargeType,
          ),
          SOCText(distanceToEmpty, units),
          chargeType == ChargeType.Solar
              ? ChargingIcon(
                  icon: "assets/images/charge_symbols/solar_high.svg",
                  chargePercent: chargePercent)
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

/// Renders the distance remaining and units as text.
class SOCText extends StatelessWidget {
  const SOCText(this.distance, this.units);

  final double distance;
  final Units units;

  @override
  Widget build(BuildContext context) {
    String unitStr = units == Units.Kmh ? " km" : " mi";
    String distStr = (distance * units.kmFactor).toStringAsFixed(PRECISION);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: <Widget>[
        Text(distStr, style: Fonts.sh2),
        Text(unitStr, style: Fonts.body)
      ],
    );
  }
}

/// Renders the Battery Symbol based on charge left in battery,
class BatterySymbol extends StatelessWidget {
  const BatterySymbol({
    @required this.chargePercent,
    @required this.charging,
  });

  final double chargePercent;
  final ChargeType charging;

  @override
  Widget build(BuildContext context) {
    int chargeRounded = (chargePercent * 5).ceil() * 20;

    String svgUrl = charging == ChargeType.Grid
        ? 'assets/images/battery/chrg$chargeRounded.svg'
        : 'assets/images/battery/btt$chargeRounded.svg';
    return Container(
        margin: EdgeInsets.only(right: 4.0, bottom: 2.0),
        child: SvgPicture.asset(svgUrl));
  }
}

/// Renders solar charging icon.
class ChargingIcon extends StatelessWidget {
  const ChargingIcon({
    @required this.icon,
    @required this.chargePercent,
  });

  final double chargePercent;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      child: SvgPicture.asset(
        icon,
        color: chargePercent > LOW_CHARGE ? StdColors.green : StdColors.error,
      ),
    );
  }
}
