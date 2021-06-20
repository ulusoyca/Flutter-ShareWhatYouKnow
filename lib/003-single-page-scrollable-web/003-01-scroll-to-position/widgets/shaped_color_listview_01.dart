import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_selection.dart';
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

  ScrollController _scrollController = ScrollController();

  int get _selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) {
      final hexColorCode = widget.selectedColorCodeNotifier.value.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  double _calculateItemHeight({double availableHeight}) {
    return max(availableHeight, _minItemHeight);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && widget.selectedColorCodeNotifier.value != null) {
        _scrollToSelectedColor();
      }
    });
    widget.selectedColorCodeNotifier.addListener(() {
      final fromButtonClick = widget.selectedColorCodeNotifier.value.source == ColorCodeSelectionSource.fromButtonClick;
      if (_scrollController.hasClients && fromButtonClick) {
        _scrollToSelectedColor();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final itemHeight = _calculateItemHeight(availableHeight: constraints.maxHeight);
        _scrollController = ScrollController(initialScrollOffset: itemHeight * _selectedColorCodeIndex);
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
    final itemHeight = _calculateItemHeight(availableHeight: _scrollController.position.viewportDimension);
    final trailingIndex = (offset / itemHeight).floor();
    final hexColorCode = widget.colors[trailingIndex].toHex();
    widget.selectedColorCodeNotifier.value = ColorCodeSelection(
      hexColorCode: hexColorCode,
      source: ColorCodeSelectionSource.fromScroll,
    );
  }

  Widget _section(MaterialColor color, BuildContext context) {
    return ShapeBorderListView(
      sectionColor: color,
      selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
      selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
    );
  }

  void _scrollToSelectedColor() {
    final itemHeight = _calculateItemHeight(availableHeight: _scrollController.position.viewportDimension);
    final offset = _selectedColorCodeIndex * itemHeight;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
