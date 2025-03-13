class Country {
  static const cam = 'Cambodia';
}

class Location {
  final String name;
  final String country;

  Location({required this.name, required this.country});
}

class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  RidePreference({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

  @override
  String toString() {
    return 'From ${departure.name} to ${arrival.name}, Date: $departureDate, Seats: $requestedSeats';
  }
}



abstract class RidePreferencesListener {
  void onPreferenceChanged(RidePreference selectedPreference);
}

class RidePreferenceService {
  RidePreference _ridePreference = RidePreference(
    departure: Location(name: "Siem Reap", country: Country.cam),
    departureDate: DateTime.now(),
    arrival: Location(name: "Phnom Penh", country: Country.cam),
    requestedSeats: 1,
  );

  final List<RidePreferencesListener> _listeners = [];

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void setRidePreference(RidePreference newPreference) {
    _ridePreference = newPreference;
    _notifyListeners();
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener.onPreferenceChanged(_ridePreference);
    }
  }
}

class ConsoleLogger extends RidePreferencesListener {
  @override
  void onPreferenceChanged(RidePreference selectedPreference) {
    print('Preference has been changed to: $selectedPreference');
  }
}


void main() {
  RidePreferenceService ridePreferenceService = RidePreferenceService();
  ConsoleLogger consoleLogger = ConsoleLogger();

  final RidePreference ridePreference = RidePreference(
    departure: Location(name: "Siem Reap", country: Country.cam),
    departureDate: DateTime.now(),
    arrival: Location(name: "Battambang", country: Country.cam),
    requestedSeats: 1,
  );

  ridePreferenceService.addListener(consoleLogger);
  ridePreferenceService.setRidePreference(ridePreference);
}
