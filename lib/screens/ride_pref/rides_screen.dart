import 'package:flutter/material.dart';
import 'package:flutter2_assignment/screens/ride_pref/widgets/ride_card.dart';
import 'package:flutter2_assignment/screens/ride_pref/widgets/user_input_data.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserInputData(
          onEdit: () {
            print('Edit');
          },
          onFilter: () {
            print('Filter');
          },
        ),
        RideCard(
          onClick: () {
            print('Ride Card Clicked');
          },
        ),
      ],
    );
  }
}
