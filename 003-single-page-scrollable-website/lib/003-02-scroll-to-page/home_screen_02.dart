import 'package:common/model/shape_border_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:single_page_scrollable_website/003-02-scroll-to-page/color_sections_02.dart';
import 'package:single_page_scrollable_website/entity/color_code.dart';
import 'package:single_page_scrollable_website/widgets/top_navigation_menu.dart';

class HomeScreen extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType?> shapeBorderTypeNotifier;
  final ValueNotifier<ColorCode?> colorCodeNotifier;

  HomeScreen({
    Key? key,
    required this.colors,
    required this.shapeBorderTypeNotifier,
    required this.colorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          TopNavigationMenu(
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
