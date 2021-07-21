/// Misc/general enums go here.

/// Units for speed and distance.
enum Units { Kmh, MPH }

extension UnitsExtension on Units {
  String get value {
    if (this == Units.Kmh)
      return "km/h";
    else
      return "mph";
  }

  double get kmFactor {
    if (this == Units.Kmh)
      return 1.0;
    else
      return 0.621371;
  }
}

/// Charging type for car - none means discharging.
enum ChargeType { None, Solar, Grid }

/// Driving state.
enum DriveStates { Drive, Reverse, Neutral }

extension DriveExtension on DriveStates {
  String get symbol {
    return this.toString().split('.')[1][0];
  }
}

enum EEDriveOutput {
  EE_DRIVE_OUTPUT_OFF,
  EE_DRIVE_OUTPUT_DRIVE,
  EE_DRIVE_OUTPUT_REVERSE,
  NUM_EE_DRIVE_OUTPUTS,
}

/// Regen braking status.
enum RbsStatus { On, Off, Warning }

/// HeadLight status.
enum LightStatus { Off, DaytimeRunning }

enum EELightType {
  EE_LIGHT_TYPE_DRL,
  EE_LIGHT_TYPE_BRAKES,
  EE_LIGHT_TYPE_STROBE,
  EE_LIGHT_TYPE_SIGNAL_RIGHT,
  EE_LIGHT_TYPE_SIGNAL_LEFT,
  EE_LIGHT_TYPE_SIGNAL_HAZARD,
  EE_LIGHT_TYPE_HIGH_BEAMS,
  EE_LIGHT_TYPE_LOW_BEAMS,
  NUM_EE_LIGHT_TYPES,
}

enum EELightState {
  EE_LIGHT_STATE_OFF,
  EE_LIGHT_STATE_ON,
  NUM_EE_LIGHT_STATES,
}
