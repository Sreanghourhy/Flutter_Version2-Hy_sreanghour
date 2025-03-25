import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride_pref.dart';
import '../../provider/provider_ride_pref_screen.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  void onRidePrefSelected(
      BuildContext context, RidePreference newPreference) async {
    // Update the current preference using provider
    context.read<RidesPrefProvider>().setCurrentPreferrence(newPreference);

    // Navigate to rides screen
    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final preferencesProvider = context.watch<RidesPrefProvider>();
    final currentRidePreference = preferencesProvider.currentPreference;
    final pastPreferences = preferencesProvider.preferencesHistory;

    return Stack(
      children: [
        // 1 - Background Image
        const BlaBlackgroud(),

        // 2 - Foreground content
        Column(
          children: [
            SizedBox(height: BlaSpacings.m),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 100),
            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 2.1 Display the Form to input the ride preferences
                  RidePrefForm(
                    initialPreference: currentRidePreference,
                    onSubmit: (pref) => onRidePrefSelected(context, pref),
                  ),
                  SizedBox(height: BlaSpacings.m),

                  // 2.2 Optionally display a list of past preferences
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: pastPreferences.length,
                      itemBuilder: (ctx, index) => RidePrefHistoryTile(
                        ridePref: pastPreferences[index],
                        onPressed: () => onRidePrefSelected(
                          context,
                          pastPreferences[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class BlaBlackgroud extends StatelessWidget {
  const BlaBlackgroud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(blablaHomeImagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}