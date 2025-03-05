import 'package:flutter/material.dart';
import 'package:flutter2_assignment/theme/theme.dart';

class RideCard extends StatefulWidget {
  const RideCard({super.key, this.onClick});
  final VoidCallback? onClick;
  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => {widget.onClick!()},
          child: Card(
            color: BlaColors.white,
            elevation: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('20:20PM : Paris',
                              style: BlaTextStyles.body.copyWith()),
                          Text('20:40PM : Roissy-en-France',
                              style: BlaTextStyles.body.copyWith()),
                        ],
                      ),
                      Text(
                        "\$3.50",
                        style: BlaTextStyles.body.copyWith(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const ListTile(
                  title: const Text('Driver: John Doe'),
                  subtitle: const Text('Car: Toyota Corolla'),
                  trailing: const Icon(Icons.flash_auto),
                ),
              ],
            ),
          ),
        ));
  }
}
