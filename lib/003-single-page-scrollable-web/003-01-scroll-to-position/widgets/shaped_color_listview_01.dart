import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'shape_border_listview_01.dart';

class ShapedColorList extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<ColorCodeSelection> selectedColorCodeNotifier;

  const ShapedColorList({
    Key key,
    @required this.colors,
    @required this.selectedShapeBorderTypeNotifier,
    @required this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  _ShapedColorListState createState() => _ShapedColorListState();
}

class _ShapedColorListState extends State<ShapedColorList> {
  final double _minItemHeight = 700;

  double get _itemHeight => max(_scrollController.position.viewportDimension, _minItemHeight);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.selectedColorCodeNotifier.addListener(() => _scrollToSelectedColor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        itemBuilder: (BuildContext context, int index) {
          final color = widget.colors[index];
          return Container(
            height: _itemHeight,
            color: color.shade100,
            child: _section(color, context),
          );
        },
      ),
    );
  }

  void _onUserScroll(double offset) {
    final trailingIndex = (offset / _itemHeight).floor();
    final hexColorCode = widget.colors[trailingIndex].toHex();
    widget.selectedColorCodeNotifier.value = ColorCodeSelection(hexColorCode: hexColorCode, fromScroll: false);
  }

  Column _section(MaterialColor color, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ShapeBorderListView(
          sectionColor: color,
          selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
          selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
        ),
      ],
    );
  }

  void _scrollToSelectedColor() {
    int index = widget.colors.indexWhere((element) {
      final selectedHexColorCode = widget.selectedColorCodeNotifier.value.hexColorCode;
      return element.toHex() == selectedHexColorCode;
    });
    int selectedColorCodeIndex = index > -1 ? index : 0;
    final offset = selectedColorCodeIndex * _itemHeight;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
