/// Constants/enums to do with errors

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

enum ErrorSeverity { Dangerous, Warning }

const List<ErrorStates> minorErrors = [
  ErrorStates.ChargerFaultWrongVoltage,
  ErrorStates.ChargerFaultPolarityFailure,
  ErrorStates.ChargerFaultCommunicationTimeout,
  ErrorStates.ChargerFaultChargerOff,
  ErrorStates.SolarFaultMCP3427,
];

extension ErrorExtension on ErrorStates {
  /// Gets heading, caption, and severity of the error.
  Map get errorInfo {
    var error = Map<dynamic, dynamic>();
    error['severity'] = minorErrors.contains(this)
        ? ErrorSeverity.Warning
        : ErrorSeverity.Dangerous;
    switch (this) {
      // CC Faults
      case ErrorStates.CentreConsoleStateTransitionFault:
        error["heading"] = "CC";
        error["caption"] = "State Fault";
        break;

      // MCI Faults
      case ErrorStates.MCIOverTemp:
        error["heading"] = "MCI";
        error["caption"] = "Over Temp";
        break;

      case ErrorStates.MCIAckFailed:
        error["heading"] = "MCI";
        error["caption"] = "ACK Fail";
        break;

      // Pedal Faults
      case ErrorStates.PedalACKFail:
        error["heading"] = "PED";
        error["caption"] = "ACK Fail";
        break;

      // Charger Faults
      case ErrorStates.ChargerFaultHardwareFailure:
        error["heading"] = "CHG";
        error["caption"] = "Hardware Fail";
        break;

      case ErrorStates.ChargerFaultOverTemperature:
        error["heading"] = "CHG";
        error["caption"] = "Over Temp";
        break;

      case ErrorStates.ChargerFaultWrongVoltage:
        error["heading"] = "CHG";
        error["caption"] = "Wrong Volt";
        break;

      case ErrorStates.ChargerFaultPolarityFailure:
        error["heading"] = "CHG";
        error["caption"] = "Polar Fail";
        break;

      case ErrorStates.ChargerFaultCommunicationTimeout:
        error["heading"] = "CHG";
        error["caption"] = "Comm Timeout";
        break;

      case ErrorStates.ChargerFaultChargerOff:
        error["heading"] = "CHG";
        error["caption"] = "Charger Off";
        break;

      // MPPT Faults
      case ErrorStates.SolarFaultMPPTOverCurrent:
        error["heading"] = "MPPT";
        error["caption"] = "Over Curr";
        break;

      case ErrorStates.SolarFaultMPPTOverVoltage:
        error["heading"] = "MPPT";
        error["caption"] = "Over Volt";
        break;

      case ErrorStates.SolarFaultMPPTOverTemperature:
        error["heading"] = "MPPT";
        error["caption"] = "Over Temp";
        break;

      // Solar Faults
      case ErrorStates.SolarFaultMCP3427:
        error["heading"] = "SOL";
        error["caption"] = "MCP 3427";
        break;

      case ErrorStates.SolarFaultOverCurrent:
        error["heading"] = "SOL";
        error["caption"] = "Over Curr";
        break;

      case ErrorStates.SolarFaultNegativeCurrent:
        error["heading"] = "SOL";
        error["caption"] = "Neg Curr";
        break;

      case ErrorStates.SolarFaultOverVoltage:
        error["heading"] = "SOL";
        error["caption"] = "Over Volt";
        break;

      case ErrorStates.SolarFaultOverTemperature:
        error["heading"] = "SOL";
        error["caption"] = "Over Temp";
        break;

      // BPS Faults
      case ErrorStates.BPSACKFailed:
        error["heading"] = "BPS";
        error["caption"] = "ACK Fail";
        break;

      case ErrorStates.BPSKillSwitch:
        error["heading"] = "BPS";
        error["caption"] = "Killswitch";
        break;

      case ErrorStates.BPSRelayFault:
        error["heading"] = "BPS";
        error["caption"] = "Relay";
        break;

      case ErrorStates.BPSCurrentSenseFault:
        error["heading"] = "BPS";
        error["caption"] = "Curr Sense";
        break;

      // AFE Faults
      case ErrorStates.BPSAFECellFault:
        error["heading"] = "AFE";
        error["caption"] = "Cell Fault";
        break;

      case ErrorStates.BPSAFETempFault:
        error["heading"] = "AFE";
        error["caption"] = "Temp Fault";
        break;

      case ErrorStates.BPSAFEFSMFault:
        error["heading"] = "AFE";
        error["caption"] = "FSM Fault";
        break;

      // BMS Faults
      case ErrorStates.BMSOverVoltage:
        error["heading"] = "BMS";
        error["caption"] = "Over Volt";
        break;

      // Sanity check in case of unknown error.
      default:
        error["heading"] = "???";
        error["caption"] = "Unknown Error";
    }
    return error;
  }
}
