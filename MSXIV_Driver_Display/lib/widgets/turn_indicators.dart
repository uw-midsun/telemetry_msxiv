import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:MSXIV_Driver_Display/utils/enums.dart' show TurnStatus;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
const int blinkDuration = 500;

class _TurnIndicatorsState extends State<TurnIndicators>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _showImage = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: blinkDuration));
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
    print("left: " + widget.turningLeft.toString());
    print("right: " + widget.turningRight.toString());

    return Container(
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
    );
  }
}

class LeftArrow extends StatelessWidget {
  final bool turningLeft;

  LeftArrow({Key key, @required this.turningLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: turningLeft
          ? Image(
              height: 60,
              image: AssetImage('assets/images/old/LeftTurnArrow.png'),
              color: StdColors.green,
            )
          : Image(
              height: 60,
              image: AssetImage('assets/images/old/LeftTurnArrowOutline.png'),
              color: StdColors.green.withOpacity(0.1),
            ),
      margin: EdgeInsets.only(top: 90, left: 15),
    );
  }
}

class RightArrow extends StatelessWidget {
  final bool turningRight;

  RightArrow({Key key, @required this.turningRight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: turningRight
          ? Image(
              height: 60,
              image: AssetImage('assets/images/old/RightTurnArrow.png'),
              color: StdColors.green,
            )
          : Image(
              height: 60,
              image: AssetImage('assets/images/old/RightTurnArrowOutline.png'),
              color: StdColors.green.withOpacity(0.1),
            ),
      margin: EdgeInsets.only(top: 90, right: 15),
    );
  }
}
