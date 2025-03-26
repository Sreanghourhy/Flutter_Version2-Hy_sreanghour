import 'package:flutter/material.dart';

import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class CustomRidesScreen extends StatefulWidget {
  const CustomRidesScreen({super.key});

  @override
  State<CustomRidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<CustomRidesScreen> {
  RidePreference? currentPreference =
      RidePrefService.instance.currentPreference;
  // TODO 1 :  We should get it from the service

  final RidesService ridesService = RidesService();
  List<Ride> get matchingRides => RidesService.getRidesFor(currentPreference!);

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
    setState(() {
      currentPreference = RidePrefService.instance.currentPreference;
    });
  }

  void onPreferencePressed() async {
    print("onPreferencePressed");
    // TODO  6 : we should push the modal with the current pref
    final updatedPreference = await Navigator.of(context).push<RidePreference>(
      MaterialPageRoute(
        builder: (ctx) => RidePrefModal(currentPreference: currentPreference!),
      ),
    );

    // TODO 9 :  After pop, we should get the new current pref from the modal
    if (updatedPreference != null) {
      print(updatedPreference);
      // TODO 10 :  Then we should update the service current pref, and update the view
      setState(() {
        currentPreference = updatedPreference;
        RidePrefService.instance.setCurrentPreference(updatedPreference);
      });
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
              ridePreference: currentPreference!,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RidePrefModal extends StatelessWidget {
  final RidePreference currentPreference;

  const RidePrefModal({required this.currentPreference, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Preferences'),
      ),
      body: Center(
        child: Text('Ride Preferences Modal'),
      ),
    );
  }
}
