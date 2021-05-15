import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:MSXIV_Driver_Display/utils/errors.dart';
import 'package:flutter/material.dart';

class Errors extends StatelessWidget {
  final List<ErrorStates> errors;

  Errors(this.errors, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 180, left: 14),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (errors.contains(ErrorStates.MCIAckFailed))
            ErrorItem("MCI", "ACK Failed"),
          if (errors.contains(ErrorStates.PedalACKFail))
            ErrorItem("Pedal", "Over Voltage"),
          if (errors.contains(ErrorStates.CentreConsoleStateTransitionFault))
            ErrorItem("Centre Console", "State Transition Fault"),
          if (errors.contains(ErrorStates.ChargerFaultHardwareFailure))
            ErrorItem("Charger", "Hardware Failure"),
          if (errors.contains(ErrorStates.ChargerFaultOverTemperature))
            ErrorItem("Charger", "Over Temperature"),
          if (errors.contains(ErrorStates.ChargerFaultWrongVoltage))
            ErrorItem("Charger", "Wrong Voltage"),
          if (errors.contains(ErrorStates.ChargerFaultPolarityFailure))
            ErrorItem("Charger", "Polarity Failure"),
          if (errors.contains(ErrorStates.ChargerFaultCommunicationTimeout))
            ErrorItem("Charger", "Communication Timeout"),
          if (errors.contains(ErrorStates.ChargerFaultChargerOff))
            ErrorItem("Charger", "Charger Off"),
          if (errors.contains(ErrorStates.SolarFaultMCP3427))
            ErrorItem("Solar", "Fault"),
          if (errors.contains(ErrorStates.SolarFaultMPPTOverCurrent))
            ErrorItem("Solar", "MPPT Over Current"),
          if (errors.contains(ErrorStates.SolarFaultMPPTOverVoltage))
            ErrorItem("Solar", "MPPT Over Voltage"),
          if (errors.contains(ErrorStates.SolarFaultMPPTOverTemperature))
            ErrorItem("Solar", "MPPT Over Temperature"),
          if (errors.contains(ErrorStates.SolarFaultOverCurrent))
            ErrorItem("Solar", "Over Current"),
          if (errors.contains(ErrorStates.SolarFaultNegativeCurrent))
            ErrorItem("Solar", "Negative Current"),
          if (errors.contains(ErrorStates.SolarFaultOverVoltage))
            ErrorItem("Solar", "Over Voltage"),
          if (errors.contains(ErrorStates.SolarFaultOverTemperature))
            ErrorItem("Solar", "Over Temperature"),
          if (errors.contains(ErrorStates.BPSKillSwitch))
            ErrorItem("BPS", "Kill Switch"),
          if (errors.contains(ErrorStates.BPSACKFailed))
            ErrorItem("BPS", "ACK Failed"),
          if (errors.contains(ErrorStates.BPSAFECellFault))
            ErrorItem("BPS", "Cell Fault"),
          if (errors.contains(ErrorStates.BPSAFETempFault))
            ErrorItem("BPS", "AFE Temp Fault"),
          if (errors.contains(ErrorStates.BPSAFEFSMFault))
            ErrorItem("BPS", "FSM Fault"),
          if (errors.contains(ErrorStates.BPSRelayFault))
            ErrorItem("BPS", "Relay Fault"),
          if (errors.contains(ErrorStates.BPSCurrentSenseFault))
            ErrorItem("BPS", "Current Sense Fault"),
          if (errors.contains(ErrorStates.BMSOverVoltage))
            ErrorItem("BMS", "Over Voltage"),
          if (errors.contains(ErrorStates.MCIOverTemp))
            ErrorItem("MCI", "Over Temp"),
        ],
      ),
    );
  }
}

class ErrorItem extends StatelessWidget {
  final String part, name;
  ErrorItem(
    this.part,
    this.name,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 200,
      child: Column(
        children: <Widget>[
          Text(part,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: StdColors.error)),
          Text(
            name,
            style: TextStyle(color: StdColors.error),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
