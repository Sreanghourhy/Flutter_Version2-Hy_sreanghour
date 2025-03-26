import 'package:blablacar/model/ride/RidesFilter.dart';
import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../ride_repository.dart';

class MockRidesRepository implements RidesRepository {
  final List<RidePreference> _ridePreferences = [
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
      requestedSeats: 2,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 0,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 2,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
    ),
  ];

  final List<RidesFilter> _ridesFilter = [
    RidesFilter(petsAccepted: false),
    RidesFilter(petsAccepted: false),
    RidesFilter(petsAccepted: false),
    RidesFilter(petsAccepted: true),
    RidesFilter(petsAccepted: false),
  ];

  @override
  List<Ride> getRides(
    RidePreference preference,
    RidesFilter? filter,
  ) {
    RideSortType? sortType;
    final ridesService = RidesService();

    // Get filtered rides based on preference
    List<Ride> rides = RidesService.getRidesFor(preference);

    // Apply sorting if sort type is provided
    if (sortType != null) {
      switch (sortType) {
        case RideSortType.departure:
          rides.sort(
            (a, b) =>
                a.departureLocation.name.compareTo(b.departureLocation.name),
          );
          break;
        case RideSortType.departureDate:
          rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.arrival:
          rides.sort(
            (a, b) => a.arrivalLocation.name.compareTo(b.arrivalLocation.name),
          );
          break;
        case RideSortType.requestedSeats:
          rides.sort((a, b) => b.availableSeats.compareTo(a.availableSeats));
          break;
        case RideSortType.departureTime:
          // TODO: Handle this case.
          throw UnimplementedError();
        case RideSortType.duration:
          // TODO: Handle this case.
          throw UnimplementedError();
        case RideSortType.availableSeats:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }

    return rides;
  }
}
