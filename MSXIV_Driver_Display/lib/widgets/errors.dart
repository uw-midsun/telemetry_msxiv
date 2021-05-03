import 'package:MSXIV_Driver_Display/constants/std_colors.dart';
import 'package:flutter/material.dart';

const int BPS_STATE_FAULT_KILLSWITCH = (1 << 0);
const int BPS_STATE_FAULT_AFE_CELL = (1 << 1);
const int BPS_FAULT_SOURCE_AFE_TEMP = (1 << 2);
const int BPS_STATE_FAULT_AFE_FSM = (1 << 3);
const int BPS_STATE_FAULT_RELAY = (1 << 4);
const int BPS_STATE_FAULT_CURRENT_SENSE = (1 << 5);
const int BPS_STATE_FAULT_ACK_TIMEOUT = (1 << 6);

enum EEChargerFault {
  EE_CHARGER_FAULT_HARDWARE_FAILURE,
  EE_CHARGER_FAULT_OVER_TEMP,
  EE_CHARGER_FAULT_WRONG_VOLTAGE,
  EE_CHARGER_FAULT_POLARITY_FAILURE,
  EE_CHARGER_FAULT_COMMUNICATION_TIMEOUT,
  EE_CHARGER_FAULT_CHARGER_OFF,
  NUM_EE_CHARGER_FAULTS,
}

enum EESolarFault {
  EE_SOLAR_FAULT_MCP3427,
  EE_SOLAR_FAULT_MPPT_OVERCURRENT,
  EE_SOLAR_FAULT_MPPT_OVERVOLTAGE,
  EE_SOLAR_FAULT_MPPT_OVERTEMPERATURE,
  EE_SOLAR_FAULT_OVERCURRENT,
  EE_SOLAR_FAULT_NEGATIVE_CURRENT,
  EE_SOLAR_FAULT_OVERVOLTAGE,
  EE_SOLAR_FAULT_OVERTEMPERATURE,
  NUM_EE_SOLAR_FAULTS,
}

enum ErrorStates {
  CentreConsoleFault,
  MCIAckFailed,
  PedalACKFail,
  CentreConsoleStateTransitionFault,
  ChargerFaultHardwareFailure,
  ChargerFaultOverTemperature,
  ChargerFaultWrongVoltage,
  ChargerFaultPolarityFailure,
  ChargerFaultCommunicationTimeout,
  ChargerFaultChargerOff,
  SolarFaultMCP3427,
  SolarFaultMPPTOverCurrent,
  SolarFaultMPPTOverVoltage,
  SolarFaultMPPTOverTemperature,
  SolarFaultOverCurrent,
  SolarFaultNegativeCurrent,
  SolarFaultOverVoltage,
  SolarFaultOverTemperature,
  BPSACKFailed,
  BPSKillSwitch,
  BPSAFECellFault,
  BPSAFETempFault,
  BPSAFEFSMFault,
  BPSRelayFault,
  BPSCurrentSenseFault,
  // TODO: Implement BMSOvervoltage and MCIOverTemp
  BMSOverVoltage,
  MCIOverTemp,
}

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
          if (errors.contains(ErrorStates.CentreConsoleFault))
            ErrorItem("Centre Console", "Fault"),
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
