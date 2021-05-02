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
              Text('Cruise',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              Text('Control',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        ),
        FittedBox(
          child: Container(
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(
                    color: cruiseControl
                        ? StdColors.green
                        : Color.fromRGBO(140, 50, 0, 1),
                    width: 3),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              cruiseControl ? "ON" : "OFF",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  color: cruiseControl
                      ? StdColors.green
                      : Color.fromRGBO(140, 50, 0, 1),
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
          ),
        )
      ]),
      alignment: Alignment.topRight,
      margin: EdgeInsets.fromLTRB(0, 190, 22, 0),
    );
  }
}
