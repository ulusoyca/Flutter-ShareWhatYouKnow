import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-01-position-as-route-info-state/widgets/shaped_color_listview.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_grid.dart';

class HomeScreen extends StatelessWidget {
  final List<Color> colors;
  final ValueListenable<ShapeBorderType> selectedShapeBorderType;
  final ValueNotifier<String> selectedColorCode;
  final ValueNotifier<double> scrollPosition;

  HomeScreen({
    Key key,
    this.colors,
    this.selectedShapeBorderType,
    this.selectedColorCode,
    this.scrollPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          Material(
            elevation: 4.0,
            child: ColorGrid(
              colors: colors,
              selectedColorCode: selectedColorCode,
            ),
          ),
          Expanded(
            child: ShapedColorList(
              colors: colors,
              selectedShapeBorderType: selectedShapeBorderType,
              scrollPosition: scrollPosition,
              selectedColorCode: selectedColorCode,
            ),
          ),
        ],
      ),
    );
  }
}
