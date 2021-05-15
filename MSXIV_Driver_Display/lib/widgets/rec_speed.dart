import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:MSXIV_Driver_Display/utils/enums.dart';
import 'package:flutter/material.dart';

class RecSpeed extends StatefulWidget {
  /// Displays the recommended speed of the vehicle.
  final double _speedKm;
  final Units _units;
  @override
  RecSpeed(this._speedKm, this._units);
  _RecSpeedState createState() => _RecSpeedState();
}

// Time for border to animate from color 1 -> color 2 in ms.
const animationDuration = 500;

class _RecSpeedState extends State<RecSpeed>
    with SingleTickerProviderStateMixin {
  /// Handles animation logic for the recommended speed widget.
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  double _speedKm = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration))
      ..addListener(() {
        setState(() {});
      });
    _colorAnimation = ColorTween(
            begin: Color.fromRGBO(219, 219, 219, 0.5),
            end: StdColors.brightBlue)
        .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Update speed and trigger border animation.
  void updateSpeed(double speed) {
    // Check if speed needs to be updated.
    if (speed.round() != _speedKm.round()) {
      TickerFuture tickerFuture = _controller.repeat(reverse: true);

      // Stop the animation after one period.
      tickerFuture.timeout(Duration(milliseconds: animationDuration * 2),
          onTimeout: () {
        _controller.reset();
      });
      setState(() {
        _speedKm = speed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double containerWidth = 110;
    const BorderRadius radius =
        BorderRadius.all(Radius.circular(containerWidth));
    const double borderWidth = 2.0;
    updateSpeed(widget._speedKm);
    final displaySpeed = (_speedKm * widget._units.kmFactor).round().toString();
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.all(24),
      child: Container(
        // Outer border created with nested containers - not good semantically.
        height: containerWidth,
        width: containerWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [_colorAnimation.value, Colors.white],
              stops: [0.3, 1.0],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: radius,
        ),
        child: Container(
          margin: EdgeInsets.all(borderWidth),
          height: containerWidth,
          width: containerWidth,
          decoration:
              BoxDecoration(borderRadius: radius, color: StdColors.background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Rec. Speed", style: Fonts.caption),
              Text(displaySpeed, style: Fonts.h2),
            ],
          ),
        ),
      ),
    );
  }
}
