import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride_filter.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../provider/provider_ride_pref_screen.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatelessWidget {
  RidesScreen({super.key});

  final RideFilter currentFilter = RideFilter();

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onRidePrefSelected(BuildContext context, RidePreference newPreference) {
    context.read<RidesPrefProvider>().setCurrentPreferrence(newPreference);
    }

  void onPreferencePressed(BuildContext context, RidePreference currentPreference) async {
    final newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      context.read<RidesPrefProvider>().setCurrentPreferrence(newPreference);
        }
  }

  void onFilterPressed(BuildContext context) {
    // TODO: Implement filter functionality
  }


  @override
  Widget build(BuildContext context) {
  final preferencesProvider = context.watch<RidesPrefProvider>();
  final currentPreference = preferencesProvider.currentPreference;

    if (currentPreference == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final matchingRides = RidesService.instance.getRidesFor(
      currentPreference,
      currentFilter,
    );
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
              ridePreference: currentPreference,
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () => onPreferencePressed(context, currentPreference),
              onFilterPressed: () => onFilterPressed(context),

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
