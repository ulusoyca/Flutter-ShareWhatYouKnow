import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-03-scroll-to-index/widgets/shape_border_listview_03.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_section_title.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapedColorList extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<String> selectedColorCodeNotifier;

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
  final ItemScrollController _itemScrollController = ItemScrollController();
  final random = Random();
  List<EdgeInsets> paddings;

  @override
  void initState() {
    paddings = List.generate(
      widget.colors.length,
      (_) => EdgeInsets.symmetric(vertical: random.nextInt(widget.colors.length) * 16.0),
    );
    widget.selectedColorCodeNotifier.addListener(() {
      if (_itemScrollController.isAttached) {
        _scrollTo(widget.selectedColorCodeNotifier.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      initialScrollIndex: _findIndexFromColorCode(widget.selectedColorCodeNotifier.value),
      itemCount: widget.colors.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: widget.colors[index].shade100,
          child: _section(context, index),
        );
      },
    );
  }

  Widget _section(BuildContext context, int index) {
    final color = widget.colors[index];
    return Padding(
      padding: paddings[index],
      child: Column(
        children: [
          ColorSectionTitle(title: color.toHex(leadingHashSign: true)),
          ShapeBorderListView(
            sectionColor: color,
            selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
            selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
          ),
        ],
      ),
    );
  }

  int _findIndexFromColorCode(String value) {
    var indexWhere = widget.colors.indexWhere((element) => element.toHex() == value);
    return indexWhere == -1 ? 0 : indexWhere;
  }

  void _scrollTo(String value) {
    int selectedColorIndex = _findIndexFromColorCode(value);
    _itemScrollController.scrollTo(
      index: selectedColorIndex,
      duration: Duration(milliseconds: max(500, selectedColorIndex * 100)),
      curve: Curves.easeInOutCubic,
    );
  }
}
