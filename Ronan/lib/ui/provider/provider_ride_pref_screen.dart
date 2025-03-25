import 'package:flutter/foundation.dart';

import '../../model/ride/ride_pref.dart';
import '../../repository/ride_preferences_repository.dart';

class RidesPrefProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  // Constructor that loads past preferences when provider is created
  RidesPrefProvider({required this.repository}) {
    _loadPastPreferences();
  }

  // Getter for current preference
  RidePreference? get currentPreference => _currentPreference;

  // Getter for past preferences history
  List<RidePreference> get preferencesHistory => _pastPreferences;

  // Load past preferences from repository
  Future<void> _loadPastPreferences() async {
    try {
      _pastPreferences = repository.getPastPreferences();
      notifyListeners();
    } catch (e) {
      print('Error loading past preferences: $e');
    }
  }

  // Method to set current preference
  void setCurrentPreferrence(RidePreference newPreference) {
    // 1. Check if new preference is different from current
    if (_currentPreference == newPreference) {
      return; // Exit if same preference
    }

    // 2. Save current preference to history before updating
    if (_currentPreference != null) {
      _savePreviousPreference(_currentPreference!);
    }

    // 3. Update current preference
    _currentPreference = newPreference;

    // 4. Notify listeners of the change
    notifyListeners();
  }

  // Helper method to save preference to history
  void _savePreviousPreference(RidePreference preference) {
    if (!_pastPreferences.contains(preference)) {  // Only add if not already in history
      _pastPreferences.insert(0, preference);  // Add to beginning of list (newest first)

    }
  }
}