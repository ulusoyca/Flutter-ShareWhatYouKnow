import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_code.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'navigation_menu_button.dart';

class SideNavigationMenu extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ColorCode> colorCodeNotifier;

  const SideNavigationMenu({
    Key key,
    this.colors,
    this.colorCodeNotifier,
  }) : super(key: key);

  int get colorCodeIndex {
    int index = colors.indexWhere((element) {
      final hexColorCode = colorCodeNotifier.value?.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: colorCodeNotifier,
      builder: (BuildContext context, ColorCode value, Widget child) {
        return Container(
          color: Colors.black87,
          width: 200,
          child: ListView.builder(
            itemCount: colors.length,
            itemBuilder: (BuildContext context, int index) {
              final color = colors[index];
              return NavigationMenuButton(
                color: color,
                colorCodeNotifier: colorCodeNotifier,
                selected: colorCodeIndex == index,
                padding: EdgeInsets.all(16),
                onPressed: () {
                  colorCodeNotifier.value = ColorCode(
                    hexColorCode: color.toHex(),
                    source: ColorCodeSelectionSource.fromButtonClick,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
