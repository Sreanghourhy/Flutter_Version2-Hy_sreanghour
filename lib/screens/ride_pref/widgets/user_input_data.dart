import 'package:flutter/material.dart';
import 'package:flutter2_assignment/theme/theme.dart';

class UserInputData extends StatefulWidget {
  const UserInputData({super.key, this.onEdit, this.onFilter});
  final VoidCallback? onEdit;
  final VoidCallback? onFilter;

  @override
  State<UserInputData> createState() => _UserInputDataState();
}

class _UserInputDataState extends State<UserInputData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 10),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                ),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () => {widget.onEdit!()},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paris -> Roissy-en-France',
                        style: BlaTextStyles.button
                            .copyWith(color: BlaColors.textNormal),
                      ),
                      Text(
                        'Yesterday, I Passenger',
                        style: BlaTextStyles.label
                            .copyWith(color: BlaColors.textLight),
                      ),
                    ],
                  )),
            ],
          ),
          GestureDetector(
            onTap: () => {widget.onFilter!()},
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'Filter',
                style: BlaTextStyles.button.copyWith(color: BlaColors.primary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
