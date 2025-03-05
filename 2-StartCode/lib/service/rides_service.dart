// import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

import 'package:blablacar/model/ride/RidesFilter.dart';
import 'package:blablacar/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  static List<Ride> availableRides = fakeRides;  


  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePreference preferences, RidesFilter filter) {
 
    // For now, just a test
    return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
  }

  createRide({required String destination, required DateTime date, required int seats}) {}

  getRides() {}
 
}