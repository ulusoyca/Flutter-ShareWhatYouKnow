import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-03-ensure-visible/color_sections_03.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_code.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/side_navigation_menu.dart';

class HomeScreen extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueListenable<ShapeBorderType> shapeBorderTypeNotifier;
  final ValueListenable<ColorCode> colorCodeNotifier;

  HomeScreen({
    Key key,
    this.colors,
    this.shapeBorderTypeNotifier,
    this.colorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideNavigationMenu(
            colors: colors,
            colorCodeNotifier: colorCodeNotifier,
          ),
          Expanded(
            child: ColorSections(
              colors: colors,
              shapeBorderTypeNotifier: shapeBorderTypeNotifier,
              colorCodeNotifier: colorCodeNotifier,
            ),
          ),
        ],
      ),
    );
  }
}
