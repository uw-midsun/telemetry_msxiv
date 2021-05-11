import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
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
