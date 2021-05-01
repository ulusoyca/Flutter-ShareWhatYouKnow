import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/colored_text.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class TopNavigationMenu extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<String> selectedColorCodeNotifier;

  const TopNavigationMenu({
    Key key,
    this.colors,
    this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < colors.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ElevatedButton(
              onPressed: () => selectedColorCodeNotifier.value = colors[i].toHex(),
              style: ElevatedButton.styleFrom(primary: colors[i]),
              child: ColoredText(color: colors[i]),
            ),
          ),
      ],
    );
  }
}
