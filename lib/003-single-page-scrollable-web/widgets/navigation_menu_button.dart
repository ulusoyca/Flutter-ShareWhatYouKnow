import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_code.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class NavigationMenuButton extends StatelessWidget {
  final Color color;
  final bool selected;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final ValueNotifier<ColorCode> colorCodeNotifier;

  const NavigationMenuButton({
    Key key,
    this.color,
    this.selected,
    this.colorCodeNotifier,
    this.padding,
    this.onPressed,
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

  Text _text(BuildContext context, Color textColor) => Text(
        "#${color.toHex()}",
        style: Theme.of(context).textTheme.headline6.copyWith(color: textColor),
      );
}
