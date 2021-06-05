import 'package:flutter/material.dart';

class TurnIndicators extends StatefulWidget {
  final bool turningLeft;
  final bool turningRight;
  TurnIndicators(
      {Key key, @required this.turningLeft, @required this.turningRight})
      : super(key: key);
  @override
  _TurnIndicatorsState createState() => _TurnIndicatorsState();
}

// Turn Indicator blink duration in milliseconds.
const int blinkDuration = 450;

class _TurnIndicatorsState extends State<TurnIndicators>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _showImage = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: blinkDuration));

    // Listener will reset animation controller to 0.0 when it reaches 1.0.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showImage = !_showImage;
        });

        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String baseURI = "images/turn_ind";
    var leftURI = "$baseURI/turn_left.png";
    var rightURI = "$baseURI/turn_right.png";

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(24),
      child: Container(
        alignment: Alignment.topCenter,
        width: 246,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(leftURI,
                color: Color.fromRGBO(68, 214, 0,
                    widget.turningLeft ? (_showImage ? 1.0 : 0.0) : 0)),
            Image.asset(rightURI,
                color: Color.fromRGBO(68, 214, 0,
                    widget.turningRight ? (_showImage ? 1.0 : 0.0) : 0)),
          ],
        ),
      ),
    );
  }
}
