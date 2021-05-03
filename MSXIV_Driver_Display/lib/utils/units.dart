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
