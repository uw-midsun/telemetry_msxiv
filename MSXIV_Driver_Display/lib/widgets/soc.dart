import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

const LOW_CHARGE = 0.3;
const double WIDTH = 50;
const double MAX_DISTANCE = 1000.0;
const double TIME_TO_FULL = 3.0;

class SOC extends StatelessWidget {
  final double chargePercent;
  final double timeToFull;
  final double distanceToEmpty;
  final bool charging;
  SOC(this.chargePercent, this.charging,
      {this.timeToFull, this.distanceToEmpty, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 20,
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  charging
                      ? ChargingIcon(
                          icon: "assets/images/plug-high.png",
                          chargePercent: chargePercent)
                      : Container(),
                  ChargingIcon(
                      icon: 'assets/images/sun-high.png',
                      chargePercent: chargePercent),
                ],
              ),
              SOCBar(chargePercent: chargePercent),
              Text(
                '${(chargePercent * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        charging
            ? SOCText(
                "${timeToFull.toString().split('.')[0]}h ${(timeToFull % 1 * 60).toString().split('.')[0]}m ",
                " Until Full")
            : SOCText(
                "${distanceToEmpty.toString().split('.')[0]}",
                "km Left",
              )
      ],
    ));
  }
}

class SOCText extends StatelessWidget {
  const SOCText(this.amount, this.label);

  final String amount, label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 3),
        ),
      ],
    );
  }
}

class SOCBar extends StatelessWidget {
  const SOCBar({
    @required this.chargePercent,
  });

  final double chargePercent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: WIDTH * chargePercent,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: chargePercent > LOW_CHARGE
                  ? StdColors.green
                  : StdColors.error,
            )),
        Container(
          width: WIDTH,
          decoration: BoxDecoration(
              border: Border.all(
                color: chargePercent > LOW_CHARGE
                    ? StdColors.green
                    : StdColors.error,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6)),
        ),
      ],
    );
  }
}

class ChargingIcon extends StatelessWidget {
  const ChargingIcon({
    @required this.icon,
    @required this.chargePercent,
  });

  final double chargePercent;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Image.asset(
        icon,
        color: chargePercent > LOW_CHARGE ? StdColors.green : StdColors.error,
      ),
    );
  }
}
