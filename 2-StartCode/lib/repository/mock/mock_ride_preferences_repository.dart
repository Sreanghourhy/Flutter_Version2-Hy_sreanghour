import 'package:blablacar/model/ride_pref/ride_pref.dart' show RidePreference;
import 'package:blablacar/repository/ride_preferences_repository.dart' show RidePreferencesRepository;

import '../../dummy_data/dummy_data.dart';

class MockRidePreferencesRepository extends RidePreferencesRepository {
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  List<RidePreference> getPastPreferences() {
    return _pastPreferences;
  }

  @override
  void addPreference(RidePreference preference) {
    _pastPreferences.add(preference);
  }
}
