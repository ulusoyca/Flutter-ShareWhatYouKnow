import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-02-scroll-to-page/widgets/shaped_color_pageview_02.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/top_navigation_menu.dart';

class HomeScreen extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueListenable<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueListenable<ColorCodeSelection> selectedColorCodeNotifier;

  HomeScreen({
    Key key,
    this.colors,
    this.selectedShapeBorderTypeNotifier,
    this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ShapedColorPageView(
            colors: colors,
            selectedShapeBorderTypeNotifier: selectedShapeBorderTypeNotifier,
            selectedColorCodeNotifier: selectedColorCodeNotifier,
          ),
          TopNavigationMenu(
            colors: colors,
            selectedColorCodeNotifier: selectedColorCodeNotifier,
          ),
        ],
      ),
    );
  }
}