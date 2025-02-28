import 'package:flutter/material.dart';
import 'package:flutter2_assignment/screens/ride_pref/widgets/bla_button.dart';
import 'package:flutter2_assignment/screens/ride_pref/widgets/location_picker.dart';
import 'package:flutter2_assignment/screens/ride_pref/widgets/seat_number_spinner.dart';
import 'package:flutter2_assignment/screens/ride_pref/widgets/tappable_pref_row.dart';
import 'package:flutter2_assignment/utils/animations_util.dart';

import '../../../model/ride/locations.dart';
import 'package:intl/intl.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  void _validateAndSearch() {
    if (departure == null) {
      Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          const Scaffold(
            body: LocationPicker(),
          ),
        ),
      );
      return;
    }
    if (arrival == null) {
      Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          const Scaffold(
            body: LocationPicker(),
          ),
        ),
      );
      return;
    }
    if (requestedSeats <= 0) {
      Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          const Scaffold(
            body: SeatNumberSpinner(),
          ),
        ),
      );
      return;
    }

    // Proceed with the search logic
  }
  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 400,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TappablePrefRow(
                  text: "Toulouse",
                  swapShow: true,
                  icon: const Icon(Icons.circle_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      AnimationUtils.createBottomToTopRoute(
                        const Scaffold(
                          body: LocationPicker(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TappablePrefRow(
                  text: "Bordeaux, France",
                  swapShow: false,
                  icon: const Icon(Icons.circle_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      AnimationUtils.createBottomToTopRoute(
                        const Scaffold(
                          body: LocationPicker(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TappablePrefRow(
                  text: DateFormat('EEE dd MMM').format(DateTime.now()),
                  swapShow: false,
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {
                    // To Do
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TappablePrefRow(
                  text: "1",
                  swapShow: false,
                  icon: const Icon(Icons.person_outlined),
                  hasborder: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      AnimationUtils.createBottomToTopRoute(
                        const Scaffold(
                          body: SeatNumberSpinner(),
                        ),
                      ),
                    );
                  },
                ),
                BlaButton(
                  buttonType: ButtonType.secondary,
                  text: "Search",
                  onPressed: () {
                    _validateAndSearch();
                  },
                )
              ]),
        ),
      ),
    );
  }
}
