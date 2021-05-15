import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:MSXIV_Driver_Display/utils/errors.dart';
import 'package:flutter/material.dart';

// TODO: implement flexible severity for errors which can be both danger/warning
// Perhaps instead of ErrorState enum, there should be an ErrorState class with severity member?
// All errors which are ambiguous are marked below with comments

class Errors extends StatelessWidget {
  final List<ErrorStates> errors;

  Errors(this.errors, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ErrorStates> filtered = List.from(errors);
    if (filtered.length > 4) {
      filtered = filtered.sublist(0, 3);
    }
    return Container(
      margin: EdgeInsets.only(top: 100, left: 24),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (filtered.contains(ErrorStates.MCIAckFailed))
            ErrorItem("MCI", "ACK Fail", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.PedalACKFail))
            ErrorItem("PED", "ACK Fail", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.CentreConsoleStateTransitionFault))
            ErrorItem("CC", "State Fault",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.ChargerFaultHardwareFailure))
            ErrorItem("CHG", "Hardware Fail",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.ChargerFaultOverTemperature))
            ErrorItem("CHG", "Over Temp", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.ChargerFaultWrongVoltage))
            ErrorItem("CHG", "Wrong Volt", ErrorSeverity.Warning),
          if (filtered.contains(ErrorStates.ChargerFaultPolarityFailure))
            ErrorItem("CHG", "Polar Fail", ErrorSeverity.Warning),
          if (filtered.contains(ErrorStates.ChargerFaultCommunicationTimeout))
            ErrorItem("CHG", "Comm Timeout", ErrorSeverity.Warning),
          if (filtered.contains(ErrorStates.ChargerFaultChargerOff))
            ErrorItem("CHG", "Charger Off", ErrorSeverity.Warning),
          if (filtered.contains(ErrorStates.SolarFaultMCP3427))
            ErrorItem("SOL", "MCP 3427", ErrorSeverity.Warning),
          if (filtered.contains(ErrorStates.SolarFaultMPPTOverCurrent))
            ErrorItem("MPPT", "Over Curr",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.SolarFaultMPPTOverVoltage))
            ErrorItem("MPPT", "Over Volt",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.SolarFaultMPPTOverTemperature))
            ErrorItem("MPPT", "Over Temp",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.SolarFaultOverCurrent))
            ErrorItem("SOL", "Over Curr",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.SolarFaultNegativeCurrent))
            ErrorItem("SOL", "Neg Curr",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.SolarFaultOverVoltage))
            ErrorItem("SOL", "Over Volt",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.SolarFaultOverTemperature))
            ErrorItem("SOL", "Over Temp",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.BPSKillSwitch))
            ErrorItem("BPS", "Killswitch",
                ErrorSeverity.Dangerous), // possibly a problem
          if (filtered.contains(ErrorStates.BPSACKFailed))
            ErrorItem("BPS", "ACK Fail", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.BPSAFECellFault))
            ErrorItem("AFE", "Cell Fault", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.BPSAFETempFault))
            ErrorItem("AFE", "Temp Fault", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.BPSAFEFSMFault))
            ErrorItem("AFE", "FSM Fault", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.BPSRelayFault))
            ErrorItem("BPS", "Relay", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.BPSCurrentSenseFault))
            ErrorItem("BPS", "Curr Sense", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.BMSOverVoltage))
            ErrorItem("BMS", "Over Volt", ErrorSeverity.Dangerous),
          if (filtered.contains(ErrorStates.MCIOverTemp))
            ErrorItem("MCI", "Over Temp", ErrorSeverity.Dangerous),
          if (errors.length > 4)
            ErrorItem("+" + (errors.length - 3).toString(), "",
                ErrorSeverity.Dangerous)
        ],
      ),
    );
  }
}

class ErrorItem extends StatelessWidget {
  final String part, name;
  final severity;
  ErrorItem(this.part, this.name, this.severity);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13, bottom: 13),
      child: Column(
        children: <Widget>[
          Text(part, style: Fonts.getErrorHeader(severity)),
          Text(name, style: Fonts.getErrorCaption(severity))
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
