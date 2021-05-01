import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';
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
              image: AssetImage('assets/images/RightTurnArrow.png'),
              color: StdColors.green,
            )
          : Image(
              height: 60,
              image: AssetImage('assets/images/RightTurnArrowOutline.png'),
              color: StdColors.green.withOpacity(0.1),
            ),
      margin: EdgeInsets.only(top: 90, right: 15),
    );
  }
}