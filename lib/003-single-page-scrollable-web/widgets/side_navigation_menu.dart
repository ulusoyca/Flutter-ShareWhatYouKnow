import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'navigation_menu_button.dart';

class SideNavigationMenu extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<String> selectedColorCodeNotifier;

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
    int index = widget.colors.indexWhere((element) => element.toHex() == widget.selectedColorCodeNotifier.value);
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
        itemBuilder: (BuildContext context, int index) => NavigationMenuButton(
          color: widget.colors[index],
          selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
          selected: selectedColorCodeIndex == index,
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
