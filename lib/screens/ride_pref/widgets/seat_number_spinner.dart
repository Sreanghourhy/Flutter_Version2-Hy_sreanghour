import 'package:flutter/material.dart';
import 'package:flutter2_assignment/theme/theme.dart';

class SeatNumberSpinner extends StatefulWidget {
  const SeatNumberSpinner({super.key});

  @override
  State<SeatNumberSpinner> createState() => _SeatNumberSpinnerState();
}

class _SeatNumberSpinnerState extends State<SeatNumberSpinner> {
  int seatCount = 1;

  void _increaseSeatCount() {
    setState(() {
      seatCount++;
    });
  }

  void _decreaseSeatCount() {
    if (seatCount > 1) {
      setState(() {
        seatCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  size: BlaTextStyles.heading.fontSize,
                  color: BlaColors.primary,
                ),
              ),
              Text(
                "Number of seats to book",
                style: BlaTextStyles.heading,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _decreaseSeatCount,
                    icon: Icon(
                      Icons.remove_circle_outline,
                      size: BlaTextStyles.body.fontSize,
                      color: seatCount > 1
                          ? BlaColors.primary
                          : BlaColors.disabled,
                    ),
                  ),
                  Text(
                    "$seatCount",
                    style: BlaTextStyles.heading,
                  ),
                  IconButton(
                    onPressed: _increaseSeatCount,
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: BlaTextStyles.body.fontSize,
                      color: BlaColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              CircleAvatar(
                radius: 20,
                backgroundColor: BlaColors.primary,
                child: IconButton(
                  onPressed: () {
                    // Add your logic here
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: BlaTextStyles.body.fontSize,
                    color: BlaColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
