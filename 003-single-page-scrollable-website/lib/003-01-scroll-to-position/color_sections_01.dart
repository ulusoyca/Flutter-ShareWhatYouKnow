import 'dart:math';

import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:single_page_scrollable_website/003-01-scroll-to-position/shape_border_listview_01.dart';
import 'package:single_page_scrollable_website/entity/color_code.dart';

class ColorSections extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType?> shapeBorderTypeNotifier;
  final ValueNotifier<ColorCode?> colorCodeNotifier;

  ColorSections({
    Key? key,
    required this.colors,
    required this.shapeBorderTypeNotifier,
    required this.colorCodeNotifier,
  }) : super(key: key) {
    print("reconstructing HomeScreen");
  }

  @override
  _ColorSectionsState createState() => _ColorSectionsState();
}

class _ColorSectionsState extends State<ColorSections> {
  final double _minItemHeight = 700;

  ScrollController _scrollController = ScrollController();

  double _calculateItemHeight({required double availableHeight}) {
    return max(availableHeight, _minItemHeight);
  }

  // Find the index of the color code from the colors list
  int get _colorCodeIndex {
    int index = widget.colors.indexWhere((element) {
      final hexColorCode = widget.colorCodeNotifier.value?.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    super.initState();
    widget.colorCodeNotifier.addListener(() {
      final fromScroll =
          widget.colorCodeNotifier.value?.source == ColorCodeSelectionSource.fromScroll;
      if (_scrollController.hasClients && !fromScroll) {
        _scrollToSection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final itemHeight = _calculateItemHeight(availableHeight: constraints.maxHeight);
        _scrollController = ScrollController(initialScrollOffset: itemHeight * _colorCodeIndex);
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is UserScrollNotification) {
              _onUserScroll(notification.metrics.pixels);
            }
            return true;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.colors.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final color = widget.colors[index];
              return Container(
                height: itemHeight,
                color: color.shade100,
                child: _section(color, context),
              );
            },
          ),
        );
      },
    );
  }

  void _onUserScroll(double offset) {
    final itemHeight =
        _calculateItemHeight(availableHeight: _scrollController.position.viewportDimension);
    final trailingIndex = (offset / itemHeight).floor();
    final hexColorCode = widget.colors[trailingIndex].toHex();
    widget.colorCodeNotifier.value = ColorCode(
      hexColorCode: hexColorCode,
      source: ColorCodeSelectionSource.fromScroll,
    );
  }

  Widget _section(MaterialColor color, BuildContext context) {
    return ShapeBorderListView(
      sectionColor: color,
      shapeBorderTypeNotifier: widget.shapeBorderTypeNotifier,
      colorCodeNotifier: widget.colorCodeNotifier,
    );
  }

  void _scrollToSection() {
    final itemHeight = _calculateItemHeight(availableHeight: context.size!.height);
    final offset = _colorCodeIndex * itemHeight;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
