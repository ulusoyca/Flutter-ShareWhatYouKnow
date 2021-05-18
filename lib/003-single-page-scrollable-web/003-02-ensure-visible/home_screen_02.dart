import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-02-ensure-visible/widgets/shaped_color_listview_02.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/top_navigation_menu.dart';

class HomeScreen extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueListenable<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueListenable<String> selectedColorCodeNotifier;

  HomeScreen({
    Key key,
    this.colors,
    this.selectedShapeBorderTypeNotifier,
    this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 4.0,
            child: TopNavigationMenu(
              colors: colors,
              selectedColorCodeNotifier: selectedColorCodeNotifier,
            ),
          ),
          Expanded(
            child: ShapedColorList(
              colors: colors,
              selectedShapeBorderTypeNotifier: selectedShapeBorderTypeNotifier,
              selectedColorCodeNotifier: selectedColorCodeNotifier,
            ),
          ),
        ],
      ),
    );
  }
}
