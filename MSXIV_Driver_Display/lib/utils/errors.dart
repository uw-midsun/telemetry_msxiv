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

// TODO: Function returning heading, caption, and severity of and ErrorState