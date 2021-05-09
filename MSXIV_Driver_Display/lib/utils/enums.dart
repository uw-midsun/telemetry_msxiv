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
enum ChargeType { none, solar, grid }

/// Driving state.
enum DriveStates { Drive, Reverse, Neutral }

extension DriveExtension on DriveStates {
  String get symbol {
    return this.toString().split('.')[1][0];
  }
}

///
enum EEDriveOutput {
  EE_DRIVE_OUTPUT_OFF,
  EE_DRIVE_OUTPUT_DRIVE,
  EE_DRIVE_OUTPUT_REVERSE,
  NUM_EE_DRIVE_OUTPUTS,
}

/// HeadLight status.
enum LightStatus { Off, LowBeam, HighBeams, FogLights, DaytimeRunning }

/// Braking status.
enum BrakeStatus { On, Off, Warning }
