import 'dart:async';
import 'dart:convert';

import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:MSXIV_Driver_Display/widgets/bg_gradient.dart';
import 'package:MSXIV_Driver_Display/widgets/clock.dart';
import 'package:MSXIV_Driver_Display/widgets/errors.dart';
import 'package:MSXIV_Driver_Display/widgets/head_lights.dart';
import 'package:MSXIV_Driver_Display/widgets/left_arrow.dart';
import 'package:MSXIV_Driver_Display/widgets/rec_speed.dart';
import 'package:MSXIV_Driver_Display/widgets/right_arrow.dart';
import 'package:MSXIV_Driver_Display/widgets/soc.dart';
import 'package:MSXIV_Driver_Display/widgets/speedometer/speedometer.dart';
import 'package:MSXIV_Driver_Display/widgets/cruise_control.dart';
import 'package:MSXIV_Driver_Display/widgets/drive_state.dart';
import 'package:MSXIV_Driver_Display/utils/units.dart';
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
        backgroundColor: StdColors.background,
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

  // Vehicle
  double _manualSpeed = 0;
  double _recSpeed = 65;
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
      "${DateTime.now().hour % 12}:${DateTime.now().minute.toString().padLeft(2, '0')}";

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 10), (Timer t1) => _getTime());
    Timer.periodic(Duration(seconds: 300), (Timer t2) => removeWarnings());
    super.initState();
    print(Uri.parse("ws://localhost:8765"));
    final channel = WebSocketChannel.connect(Uri.parse("ws://localhost:8765"));
    channel.stream.listen((data) => setState(() => filterMessage(data)));
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _getTime() {
    final String formattedDateTime =
        "${DateTime.now().hour % 12}:${DateTime.now().minute.toString().padLeft(2, '0')}";
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  void _speedChange([double change]) {
    setState(() {
      _manualSpeed = change;
    });
  }

  void _recSpeedChange([double change]) {
    setState(() {
      _recSpeed = change;
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

  void selectDriveState(EEDriveOutput state) {
    setState(() {
      if (state == EEDriveOutput.EE_DRIVE_OUTPUT_DRIVE) {
        _driveState = DriveStates.Drive;
      } else if (state == EEDriveOutput.EE_DRIVE_OUTPUT_REVERSE) {
        _driveState = DriveStates.Reverse;
      } else {
        _driveState = DriveStates.Neutral;
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

  void selectLights(EELightType type, EELightState state) {
    setState(() {
      if (state == EELightState.EE_LIGHT_STATE_ON) {
        if (type == EELightType.EE_LIGHT_TYPE_DRL) {
          _lightStatus = LightStatus.DaytimeRunning;
        } else if (type == EELightType.EE_LIGHT_TYPE_SIGNAL_HAZARD) {
          _turningLeft = true;
          _turningRight = true;
        } else if (type == EELightType.EE_LIGHT_TYPE_SIGNAL_LEFT) {
          _turningLeft = true;
        } else if (type == EELightType.EE_LIGHT_TYPE_SIGNAL_RIGHT) {
          _turningRight = true;
        }
      } else {
        if (type == EELightType.EE_LIGHT_TYPE_SIGNAL_LEFT) {
          _turningLeft = false;
        } else if (type == EELightType.EE_LIGHT_TYPE_SIGNAL_RIGHT) {
          _turningRight = false;
        } else if (type == EELightType.EE_LIGHT_TYPE_SIGNAL_HAZARD) {
          _turningLeft = false;
          _turningRight = false;
        } else {
          _lightStatus = LightStatus.Off;
        }
      }
    });
  }

  void removeWarnings() {
    setState(() {
      _errors = [];
    });
  }

  void addWarnings(String msgName) {
    if (msgName == 'FAULT_SEQUENCE') {
      _errors.add(ErrorStates.CentreConsoleFault);
    } else if (msgName == 'FAULT_SEQUENCE_ACK_FROM_MOTOR_CONTROLLER') {
      _errors.add(ErrorStates.MCIAckFailed);
    } else if (msgName == 'FAULT_SEQUENCE_ACK_FROM_PEDAL') {
      _errors.add(ErrorStates.PedalACKFail);
    } else if (msgName == 'STATE_TRANSITION_FAULT') {
      _errors.add(ErrorStates.CentreConsoleStateTransitionFault);
    }
  }

  void addChargerWarnings(EEChargerFault fault) {
    if (fault == EEChargerFault.EE_CHARGER_FAULT_HARDWARE_FAILURE) {
      _errors.add(ErrorStates.ChargerFaultHardwareFailure);
    } else if (fault == EEChargerFault.EE_CHARGER_FAULT_OVER_TEMP) {
      _errors.add(ErrorStates.ChargerFaultOverTemperature);
    } else if (fault == EEChargerFault.EE_CHARGER_FAULT_WRONG_VOLTAGE) {
      _errors.add(ErrorStates.ChargerFaultWrongVoltage);
    } else if (fault == EEChargerFault.EE_CHARGER_FAULT_POLARITY_FAILURE) {
      _errors.add(ErrorStates.ChargerFaultPolarityFailure);
    } else if (fault == EEChargerFault.EE_CHARGER_FAULT_COMMUNICATION_TIMEOUT) {
      _errors.add(ErrorStates.ChargerFaultCommunicationTimeout);
    } else if (fault == EEChargerFault.EE_CHARGER_FAULT_CHARGER_OFF) {
      _errors.add(ErrorStates.ChargerFaultChargerOff);
    }
  }

  void addSolarWarnings(EESolarFault fault) {
    if (fault == EESolarFault.EE_SOLAR_FAULT_MCP3427) {
      _errors.add(ErrorStates.SolarFaultMCP3427);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_MPPT_OVERCURRENT) {
      _errors.add(ErrorStates.SolarFaultMPPTOverCurrent);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_MPPT_OVERVOLTAGE) {
      _errors.add(ErrorStates.SolarFaultMPPTOverVoltage);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_MPPT_OVERTEMPERATURE) {
      _errors.add(ErrorStates.SolarFaultMPPTOverTemperature);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_OVERCURRENT) {
      _errors.add(ErrorStates.SolarFaultOverCurrent);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_NEGATIVE_CURRENT) {
      _errors.add(ErrorStates.SolarFaultNegativeCurrent);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_OVERVOLTAGE) {
      _errors.add(ErrorStates.SolarFaultOverVoltage);
    } else if (fault == EESolarFault.EE_SOLAR_FAULT_OVERTEMPERATURE) {
      _errors.add(ErrorStates.SolarFaultOverTemperature);
    }
  }

  void addBatteryHeartbeatWarnings(int status) {
    if ((status & BPS_STATE_FAULT_KILLSWITCH) == 1) {
      _errors.add(ErrorStates.BPSKillSwitch);
    }
    if ((status & BPS_STATE_FAULT_AFE_CELL) >= 1) {
      _errors.add(ErrorStates.BPSAFECellFault);
    }
    if ((status & BPS_FAULT_SOURCE_AFE_TEMP) >= 1) {
      _errors.add(ErrorStates.BPSAFETempFault);
    }
    if ((status & BPS_STATE_FAULT_AFE_FSM) >= 1) {
      _errors.add(ErrorStates.BPSAFEFSMFault);
    }
    if ((status & BPS_STATE_FAULT_RELAY) >= 1) {
      _errors.add(ErrorStates.BPSRelayFault);
    }
    if ((status & BPS_STATE_FAULT_CURRENT_SENSE) >= 1) {
      _errors.add(ErrorStates.BPSCurrentSenseFault);
    }
    if ((status & BPS_STATE_FAULT_ACK_TIMEOUT) >= 1) {
      _errors.add(ErrorStates.BPSACKFailed);
    }
  }

  void filterMessage(String data) {
    var msg = data.split('-');
    var msgName = msg[0];
    var parsedInternalData = json.decode(msg[2].replaceAll("'", "\""));

    if (msgName == 'MOTOR_VELOCITY') {
      _speedChange((parsedInternalData['vehicle_velocity_left']).toDouble());
    } else if (msgName == 'LIGHTS') {
      selectLights(EELightType.values[(parsedInternalData['lights_id'])],
          EELightState.values[(parsedInternalData['state'])]);
    } else if (msgName == 'BATTERY_CHANGE') {
      // TODO: Figure out voltage levels versus battery charge
    } else if (msgName == 'CRUISE_CONTROL_COMMAND') {
      toggleCruise();
    } else if (msgName == 'DRIVE_STATE') {
      selectDriveState(EEDriveOutput.values[parsedInternalData['drive_state']]);
    } else if (msgName == 'BPS_HEARTBEAT') {
      addBatteryHeartbeatWarnings(parsedInternalData['status']);
    } else if (msgName == "CHARGER_FAULT") {
      addChargerWarnings(EEChargerFault.values[parsedInternalData['fault']]);
    } else if (msgName == "SOLAR_FAULT") {
      addSolarWarnings(EESolarFault.values[parsedInternalData['fault']]);
    } else if (msgName.contains(new RegExp(r'FAULT'))) {
      addWarnings(msgName);
    }

    // TODO: Handle recommeded speed message (?)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StdColors.background,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            BgGradient(),

            // Speedometer
            GestureDetector(
              onPanUpdate: (details) {
                _speedChange(details.delta.dx / 5);
              },
              onTap: toggleUnits,
              child: Speedometer(_manualSpeed, units),
            ),

            // Recommended Speed
            GestureDetector(
                onTap: () => _recSpeedChange(_recSpeed + 5),
                child: RecSpeed(_recSpeed, units)),

            // Left Arrow
            GestureDetector(
              onTap: toggleTurnLeft,
              onDoubleTap: removeWarnings,
              child: LeftArrow(turningLeft: _turningLeft),
            ),

            // Right Arrow
            GestureDetector(
              onTap: toggleTurnRight,
              child: RightArrow(turningRight: _turningRight),
            ),

            // Battery Info
            GestureDetector(
              onPanUpdate: (details) {
                batteryChange(details.delta.dx / 400);
              },
              child: SOC(_chargePercent, _charging,
                  distanceToEmpty: _distanceToEmpty, timeToFull: _timeToFull),
            ),

            // Headlights
            GestureDetector(
              onTap: toggleLights,
              child: HeadLights(_lightStatus),
            ),

            // Errors
            GestureDetector(
              onTap: removeWarnings,
              child: Errors(_errors),
            ),

            // Cruise Control
            GestureDetector(
              onTap: toggleCruise,
              child: CruiseControl(_cruiseControlOn),
            ),

            // Drive States
            GestureDetector(
              onTap: toggleDriveState,
              child: DriveState(_driveState),
            ),

            // Clock
            Clock(_timeString)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
