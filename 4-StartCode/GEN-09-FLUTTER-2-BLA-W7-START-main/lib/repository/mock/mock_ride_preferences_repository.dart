import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride_pref.dart';

final List<RidePreference> _pastPreferences = fakeRidePrefs;

@override
List<RidePreference> getPastPreferences() {
  Future<List<RidePreference>> getPastPreferences() async {
    await Future.delayed(const Duration(seconds: 2));
    return _pastPreferences;
  }
  return _pastPreferences; // Ensure a return value is provided
}
