import 'package:blablacar/model/ride/locations.dart';
import '../repository/ride_location_repository.dart';
import '../repository/mock/mock_location_repository.dart';

class LocationsService {
  static final LocationsRepository _repository = MockLocationsRepository();

  static List<Location> get availableLocations => _repository.getLocations();
}
