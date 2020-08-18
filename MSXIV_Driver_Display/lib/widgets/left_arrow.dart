import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

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
              image: AssetImage('assets/images/LeftTurnArrow.png'),
              color: stdColors.green,
            )
          : Image(
              height: 60,
              image: AssetImage('assets/images/LeftTurnArrowOutline.png'),
              color: stdColors.green.withOpacity(0.1),
            ),
      margin: EdgeInsets.only(top: 90, left: 15),
    );
  }
}
