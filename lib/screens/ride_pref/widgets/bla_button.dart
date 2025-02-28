import 'package:flutter/material.dart';
import 'package:flutter2_assignment/theme/theme.dart';

/// List of button types
enum ButtonType {
  primary,
  secondary;
}

/// BlaButton is a custom button widget that can be used to create buttons with
/// different styles. The button can be of two types: primary and secondary.
/// The primary button has a white background with a border and text color of
/// primary color. The secondary button has a primary background with no border
/// and white text color.
/// The button can have an icon and a text. The icon is displayed on the left
/// side of the text.

class BlaButton extends StatefulWidget {
  const BlaButton(
      {super.key,
      required this.buttonType,
      required this.text,
      this.icon,
      this.onPressed});
  final ButtonType buttonType; // Button type
  final Icon? icon; // Icon to be displayed on the button
  final String text; // Text to be displayed on the button
  final VoidCallback?
      onPressed; // Callback function to be called when the button is pressed
  @override
  State<BlaButton> createState() => _BlaButtonState();
}

class _BlaButtonState extends State<BlaButton> {
  late Color background; // Background color of the button
  late Color border; // Border color of the button
  late Color textColor; // Text color of the button
  @override
  Widget build(BuildContext context) {
    /// Set the button colors based on the button type
    if (widget.buttonType == ButtonType.primary) {
      background = BlaColors.white;
      border = BlaColors.neutralLighter;
      textColor = BlaColors.primary;
    } else {
      background = BlaColors.primary;
      border = BlaColors.primary;
      textColor = BlaColors.white;
    }
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: border)),
          ),
          label: Text(widget.text,
              style: BlaTextStyles.button.copyWith(
                color: textColor,
              )),
          iconAlignment: IconAlignment.start,
          icon: Icon(
            widget.icon?.icon,
            size: 14,
            color: textColor,
          ),
        ));
  }
}
