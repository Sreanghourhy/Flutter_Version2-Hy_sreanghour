import 'package:flutter/material.dart';
import 'package:flutter2_assignment/theme/theme.dart';

class TappablePrefRow extends StatefulWidget {
  const TappablePrefRow(
      {super.key,
      this.onPressed,
      this.onPressedSwap,
      required this.text,
      this.swapShow = true,
      this.icon,
      this.hasborder = true});
  final VoidCallback? onPressed;
  final VoidCallback? onPressedSwap;
  final String text;
  final bool swapShow;
  final Icon? icon;
  final bool hasborder;
  @override
  State<TappablePrefRow> createState() => _TappablePrefRowState();
}

class _TappablePrefRowState extends State<TappablePrefRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onPressed?.call(),
        child: Row(
          children: [
            Icon(
              widget.icon?.icon,
              color: BlaColors.neutralLight,
              size: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: widget.hasborder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: BlaColors.neutralLight,
                            width: 1,
                          ),
                        ),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.text,
                      style: BlaTextStyles.body,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => widget.onPressedSwap?.call(),
              icon: widget.swapShow == true
                  ? Icon(
                      Icons.swap_vert,
                      color: BlaColors.primary,
                    )
                  : Container(
                      width: 20,
                    ),
            )
          ],
        ));
  }
}
