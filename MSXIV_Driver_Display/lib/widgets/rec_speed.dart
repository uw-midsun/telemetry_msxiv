import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:MSXIV_Driver_Display/utils/units.dart';
import 'package:flutter/material.dart';

class RecSpeed extends StatefulWidget {
  final double _speed;
  final Units _units;
  @override
  RecSpeed(this._speed, this._units);
  _RecSpeedState createState() => _RecSpeedState();
}

// Time for border to animate from color 1 -> color 2 (ms)
const animationDuration = 500;

class _RecSpeedState extends State<RecSpeed>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  double _speed = 0;

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

  void updateSpeed(double speed) {
    if (speed.round() != _speed.round()) {
      // Begin the animation
      TickerFuture tickerFuture = _controller.repeat(reverse: true);

      // Stop the animation after one cycle
      tickerFuture.timeout(Duration(milliseconds: animationDuration * 2),
          onTimeout: () {
        _controller.reset();
      });
      setState(() {
        _speed = speed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double containerWidth = 110;
    const BorderRadius radius =
        BorderRadius.all(Radius.circular(containerWidth));
    const double borderWidth = 2.0;
    updateSpeed(widget._speed);
    final displaySpeed = (_speed * widget._units.kmFactor).round().toString();
    return Container(
        // set overall margin and alignment
        alignment: Alignment.topRight,
        margin: EdgeInsets.all(24),
        child: Container(
            // use container as outer border
            height: containerWidth,
            width: containerWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [_colorAnimation.value, Colors.white],
                  begin: Alignment(0.0, 1.0),
                  end: Alignment(0.0, -1.0)),
              borderRadius: radius,
            ),
            child: Container(
                margin: EdgeInsets.all(borderWidth),
                height: containerWidth,
                width: containerWidth,
                decoration: BoxDecoration(
                    borderRadius: radius, color: StdColors.background),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Rec. Speed", style: Fonts.caption),
                      Text(displaySpeed, style: Fonts.h2),
                    ]))));
  }
}
