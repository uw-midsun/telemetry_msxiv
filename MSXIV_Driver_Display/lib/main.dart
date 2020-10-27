import 'dart:async';

import 'package:MSXIV_Driver_Display/constants/stdColors.dart';
import 'package:MSXIV_Driver_Display/widgets/clock.dart';
import 'package:MSXIV_Driver_Display/widgets/errors.dart';
import 'package:MSXIV_Driver_Display/widgets/head_lights.dart';
import 'package:MSXIV_Driver_Display/widgets/left_arrow.dart';
import 'package:MSXIV_Driver_Display/widgets/right_arrow.dart';
import 'package:MSXIV_Driver_Display/widgets/soc.dart';
import 'package:MSXIV_Driver_Display/widgets/speedometer.dart';
import 'package:MSXIV_Driver_Display/widgets/cruise_control.dart';
import 'package:MSXIV_Driver_Display/widgets/digital_speed.dart';
import 'package:MSXIV_Driver_Display/widgets/drive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/head_lights.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(Display());
}

class Display extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MSXIV Driver Display',
      theme: ThemeData(
        backgroundColor: stdColors.background,
      ),
      home: MainDisplay(title: 'Main Display'),
    );
  }
}

class MainDisplay extends StatefulWidget {
  MainDisplay({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  // Web Socket
  WebSocketChannel channel;
  TextEditingController controller;

  // Vehicle
  double _manualSpeed = 0;
  bool _turningLeft = false;
  bool _turningRight = false;
  LightStatus _lightStatus = LightStatus.DaytimeRunning;
  DriveStates _driveState = DriveStates.Park;
  bool _cruiseControlOn = false;
  List<ErrorStates> _errors = [];
  double _chargePercent = 1.00;
  double _timeToFull = 3.0;
  double _distanceToEmpty = 1000;
  bool _charging = false;
  Units units = Units.Kmh;
  String _timeString =
      "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 10), (Timer t) => _getTime());
    super.initState();
    final channel = WebSocketChannel.connect(Uri.parse("ws://localhost:1234"));
    controller = TextEditingController();
    channel.stream.listen((data) => setState(() => _speedChange(data)));
  }

  void _getTime() {
    final String formattedDateTime =
        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  void _speedChange([double change]) {
    setState(() {
      var temp = _manualSpeed + change;
      if (temp > TOP_SPEED) {
        _manualSpeed = TOP_SPEED;
      } else if (temp < 0) {
        _manualSpeed = 0;
      } else {
        _manualSpeed = temp;
      }
    });
  }

  void toggleTurnRight() {
    setState(() {
      _turningRight = !_turningRight;
    });
  }

  void toggleTurnLeft() {
    setState(() {
      _turningLeft = !_turningLeft;
    });
  }

  void batteryChange(change) {
    setState(() {
      var temp = _chargePercent + change;
      if (temp > 1) {
        _chargePercent = 1;
      } else if (temp < 0) {
        _chargePercent = 0;
      } else {
        _chargePercent = temp;
      }
      if (change > 0) {
        _timeToFull = TIME_TO_FULL * (1 - _chargePercent);
        _charging = true;
      } else {
        _distanceToEmpty = MAX_DISTANCE * _chargePercent;
        _charging = false;
      }
    });
  }

  void toggleCruise() {
    setState(() {
      _cruiseControlOn = !_cruiseControlOn;
    });
  }

  void toggleUnits() {
    setState(() {
      if (units == Units.Kmh) {
        units = Units.MPH;
      } else {
        units = Units.Kmh;
      }
    });
  }

  void toggleDriveState() {
    setState(() {
      if (_driveState == DriveStates.Park) {
        _driveState = DriveStates.Reverse;
      } else if (_driveState == DriveStates.Reverse) {
        _driveState = DriveStates.Neutral;
      } else if (_driveState == DriveStates.Neutral) {
        _driveState = DriveStates.Drive;
      } else {
        _driveState = DriveStates.Park;
      }
    });
  }

  void toggleLights() {
    setState(() {
      if (_lightStatus == LightStatus.DaytimeRunning) {
        _lightStatus = LightStatus.FogLights;
      } else if (_lightStatus == LightStatus.FogLights) {
        _lightStatus = LightStatus.HighBeams;
      } else if (_lightStatus == LightStatus.HighBeams) {
        _lightStatus = LightStatus.Off;
      } else if (_lightStatus == LightStatus.Off) {
        _lightStatus = LightStatus.DaytimeRunning;
      }
    });
  }

  void changeWarnings() {
    setState(() {
      if (_errors.length == 0)
        _errors = [
          ErrorStates.BPSKillSwitch,
        ];
      else if (_errors.length == 1)
        _errors = [
          ErrorStates.BPSKillSwitch,
          ErrorStates.BPSACKFailed,
          ErrorStates.BMSOverVoltage,
          ErrorStates.MCIOverTemp
        ];
      else
        _errors = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            //speed analog
            Speedometer(_manualSpeed, units),
            //left arrow
            GestureDetector(
              onTap: toggleTurnLeft,
              onDoubleTap: changeWarnings,
              child: LeftArrow(turningLeft: _turningLeft),
            ),
            //right arrow
            GestureDetector(
              onTap: toggleTurnRight,
              child: RightArrow(turningRight: _turningRight),
            ),
            //speed digital
            GestureDetector(
              onPanUpdate: (details) {
                _speedChange(details.delta.dx / 5);
              },
              onTap: toggleUnits,
              child: DigitalSpeed(_manualSpeed, units),
            ),
            //battery info
            GestureDetector(
              onPanUpdate: (details) {
                batteryChange(details.delta.dx / 400);
              },
              child: SOC(_chargePercent, _charging,
                  distanceToEmpty: _distanceToEmpty, timeToFull: _timeToFull),
            ),

            //headlights
            GestureDetector(
              onTap: toggleLights,
              child: HeadLights(_lightStatus),
            ),

            // errors
            GestureDetector(
              onTap: changeWarnings,
              child: Errors(_errors),
            ),

            //cruise control
            GestureDetector(
              onTap: toggleCruise,
              child: CruiseControl(_cruiseControlOn),
            ),
            //Drive States
            GestureDetector(
              onTap: toggleDriveState,
              child: DriveState(_driveState),
            ),

            //Clock
            Clock(_timeString)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
