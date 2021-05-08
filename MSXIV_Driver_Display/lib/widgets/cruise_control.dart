import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:flutter/material.dart';

class CruiseControl extends StatelessWidget {
  final bool cruiseControl;
  CruiseControl(this.cruiseControl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('CRUISE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        FittedBox(
          child: Container(
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(
                    color: cruiseControl
                        ? Color.fromRGBO(255, 255, 255, 0)
                        : Color.fromRGBO(255, 255, 255, 0),
                    width: 0),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              cruiseControl ? "ON" : "OFF",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  color: cruiseControl
                      ? stdColors.white
                      : Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
          ),
        )
      ]),
      alignment: Alignment.topCenter,
      margin: EdgeInsets.fromLTRB(0, 50, 1000, 0),
    );
  }
}
