import 'package:flutter/material.dart';

import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_icon_button.dart';
import '../../ride_pref/widgets/ride_pref_form.dart';

class CustomRidePrefModal extends StatefulWidget {
  final RidePreference currentPreference;

  const CustomRidePrefModal({
    super.key,
    required this.currentPreference,
    // TODO 7 : We should pass the current prefs to this moda;
  });

  @override
  State<CustomRidePrefModal> createState() => _RidePrefModalState();
}

class _RidePrefModalState extends State<CustomRidePrefModal> {
  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onSubmit(RidePreference newPreference) {
    // TODO 9 : We should pop this modal, with the new current preference
    print("TODO 9 New preference submitted : $newPreference");
    Navigator.of(context).pop(newPreference);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back icon
          BlaIconButton(
            onPressed: onBackSelected,
            icon: Icons.close,
          ),
          SizedBox(height: BlaSpacings.m),

          // Title
          Text("Edit your search",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal)),

          // Form
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: RidePrefForm(
              initialPreference: widget
                  .currentPreference, // TODO 7 : The form should be displayed with the modal current prefs
              onSubmit: onSubmit,
            ),
          )),
        ],
      ),
    ));
  }
}
