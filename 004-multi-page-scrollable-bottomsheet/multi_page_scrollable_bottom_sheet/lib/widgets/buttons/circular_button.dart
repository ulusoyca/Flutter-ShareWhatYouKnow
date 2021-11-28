import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final double size;
  final AppColorNames? colorName;

  const CircularButton({
    Key? key,
    this.onPressed,
    this.size = 20,
    required this.iconData,
    this.colorName = AppColorNames.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorName = this.colorName ?? AppColorNames.black;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: colorName.color10,
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
      ),
      child: Icon(iconData, color: colorName.color100, size: size),
      onPressed: onPressed,
    );
  }
}
