import 'package:flutter/widgets.dart';

import '../../model/ride/ride_pref.dart';
import '../../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;
  RidesPreferencesProvider({required this.repository}) {
    // For now past preferences are fetched only 1 time
    _loadPastPreferences();
  }
  Future<void> _loadPastPreferences() async {
    try{
      _pastPreferences = await repository.getPastPreferences();
      notifyListeners();
    } catch(e) {
      print('Error loading past preferences: $e');
    }
  }

  RidePreference? get currentPreference => _currentPreference;
  void setCurrentPreferrence(RidePreference pref) {
    if (_currentPreference != null) {
      _addPreference(_currentPreference!);
    }
    _currentPreference = pref;
    notifyListeners();
  }
  void _addPreference(RidePreference preference) {
    _pastPreferences.add(preference);
    repository.addPreference(preference);
    notifyListeners();
  }

  // History is returned from newest to oldest preference
  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();
}
