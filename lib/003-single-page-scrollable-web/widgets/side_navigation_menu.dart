import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'navigation_menu_button.dart';

class SideNavigationMenu extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ColorCodeSelection> selectedColorCodeNotifier;

  const SideNavigationMenu({
    Key key,
    this.colors,
    this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  _SideNavigationMenuState createState() => _SideNavigationMenuState();
}

class _SideNavigationMenuState extends State<SideNavigationMenu> {
  int get selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) {
      final selectedHexColorCode = widget.selectedColorCodeNotifier.value.hexColorCode;
      return element.toHex() == selectedHexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    widget.selectedColorCodeNotifier.addListener(() {
      setState(() => {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: 200,
      child: ListView.builder(
        itemCount: widget.colors.length,
        itemBuilder: (BuildContext context, int index) {
          final color = widget.colors[index];
          return NavigationMenuButton(
            color: color,
            selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
            selected: selectedColorCodeIndex == index,
            padding: EdgeInsets.all(16),
            onPressed: () {
              widget.selectedColorCodeNotifier.value = ColorCodeSelection(
                hexColorCode: color.toHex(),
                source: ColorCodeSelectionSource.fromButtonClick,
              );
            },
          );
        },
      ),
    );
  }
}
