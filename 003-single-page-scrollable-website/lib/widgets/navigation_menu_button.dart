import 'package:common/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

class NavigationMenuButton extends StatelessWidget {
  final Color color;
  final bool selected;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  const NavigationMenuButton({
    Key? key,
    required this.color,
    required this.selected,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    Color textColor = brightness == Brightness.light ? Colors.black : Colors.white;
    return Padding(
      padding: padding,
      child: selected
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: color),
              child: _text(context, textColor),
            )
          : TextButton(
              onPressed: onPressed,
              child: _text(context, color),
            ),
    );
  }

  Text _text(BuildContext context, Color? textColor) => Text(
        "#${color.toHex()}",
        style: Theme.of(context).textTheme.headline6!.copyWith(color: textColor),
      );
}
